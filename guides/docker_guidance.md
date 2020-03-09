# Docker guidance

## Terminology
`Dockerfile` - set of instructions for building a docker image  
`Image` - a constructed set of layered docker instructions  
`Container` - a running instance of an image

## Parent images
For large microservice architectures it may be beneficial to create Dockerfiles that are extended from a minimal Defra created parent images.  This will allow us to benefit from improved security and more efficient builds as we will not have to repeat steps that are common to all Dockerfiles.

Different parent images should be created in line with each framework's best practice.  Eg, Node.js, .Net Core, Ruby etc.

Example Dockerfiles to build parent images can be found in the below repositories:
- https://github.com/DEFRA/ffc-docker-node
- https://github.com/DEFRA/ffc-docker-dotnetcore

## Multi stage builds
Dockerfiles should implement multi stage builds to allow different build stages to be targetted for specific purposes.  For example, a final production image does not need all the unit test files and a unit test running image would use a different running command than the application.

Below is an example multi stage build which is intended to use the Future Farming and Countryside (FFC) Node.js parent image.

```
ARG PARENT_VERSION=1.0.0-node12.16.0
ARG PORT=3000
ARG PORT_DEBUG=9229
ARG REGISTRY=171014905211.dkr.ecr.eu-west-2.amazonaws.com

# Development
FROM ${REGISTRY}/ffc-node-development:${PARENT_VERSION} AS development
ARG PARENT_VERSION
ARG REGISTRY
LABEL uk.gov.defra.ffc.parent-image=${REGISTRY}/ffc-node-development:${PARENT_VERSION}
ARG PORT
ENV PORT ${PORT}
ARG PORT_DEBUG
EXPOSE ${PORT} ${PORT_DEBUG}
COPY --chown=node:node package*.json ./
RUN npm install
COPY --chown=node:node app/ ./app/
RUN npm run build
CMD [ "npm", "run", "start:watch" ]

# Production
FROM ${REGISTRY}/ffc-node:${PARENT_VERSION} AS production
ARG PARENT_VERSION
ARG REGISTRY
LABEL uk.gov.defra.ffc.parent-image=${REGISTRY}/ffc-node:${PARENT_VERSION}
ARG PORT
ENV PORT ${PORT}
EXPOSE ${PORT}
COPY --from=development /home/node/app/ ./app/
COPY --from=development /home/node/package*.json ./
RUN npm ci
CMD [ "node", "app" ]
```

## Docker Compose guidance

### Use override files to reduce duplication
Additional settings can be applied to a docker compose file by using override files.

Override files can be applied by listing the files after the `docker-compose` command with the `-f` parameter, i.e.

`docker-compose up -f docker-compose.yaml -f docker-compose.override.yaml`

Note that the above is equivalent to running the command:

`docker-compose up`

as calling `docker-compose` without specifying any files will run `docker-compose` with any available `docker-compose.yaml` and `docker-compose.override.yaml` files in the executing directory. 

Note however that:

`docker-compose up -f docker-compose.yaml`

will **not** apply the docker `docker-compose.override.yaml` file, only the file specified.

One use case is for running tests in CI - common settings can be put into the base `docker-compose.yaml` file, while changes to the command and container names can be placed in override files.

The below example demonstrates changing the command and container name for testing:

`docker-compose.yaml`

```
version: '3.4'
services:
  ffc-demo-service:
    build: .
    image: ffc-demo-service
    container_name: ffc-demo-service
    environment:
      DEMO_API: http://demo-api

volumes:
  node_modules: {}

```

`docker-compose.test.yaml`
```
version: '3.4'
services:
  ffc-demo-service:
    command: npm run test
    container_name: ffc-demo-service-test
```

The tests can be run by providing the `docker-compose.test.yaml` file with a `-f` parameter:

`docker-compose up -f docker-compose.yaml -f docker-compose.test.yaml`

Further documentation on docker-compose can be found at https://docs.docker.com/compose/reference/overview/#specifying-multiple-compose-files.

## Use projects to provide unique volumes and networks
To avoid conflicts when running different permutations of docker files, projects should be specified to segregate the volumes and networks.

This can be achieved with the `-p` switch when calling docker compose on the command line.

 i.e. to start the service

`docker-compose -p ffc-demo-service up -f docker-compose.yaml`

and to run the tests

`docker-compose -p ffc-demo-service-test up -f docker-compose.yaml -f docker-compose.test.yaml`

## Use environment variables to guarantee unique projects and containers
When running through CI, a combination of the `-p` switch and environment variables can be used to ensure each build and test has unique project and container names.

For example using Jenkins, the following compose files can be started via:

`docker-compose -p ffc-demo-service-$PR_NUMBER-$BUILD_NUMBER up -f docker-compose.yaml`

and tested with

`docker-compose -p ffc-demo-service-test-$PR_NUMBER-$BUILD_NUMBER up -f docker-compose.yaml -f docker-compose.test.yaml`

using `PR_NUMBER` and `BUILD_NUMBER` environment variables to isolate build tasks.

`docker-compose.yaml`

```
version: '3.4'
services:
  ffc-demo-service:
    build: .
    image: ffc-demo-service
    container_name: ffc-demo-service-${PR_NUMBER}-${BUILD_NUMBER}
volumes:
  node_modules: {}

```

`docker-compose.test.yaml`
```
version: '3.4'
services:
  ffc-demo-service:
    command: npm run test
    container_name: ffc-demo-service-test-${PR_NUMBER}-${BUILD_NUMBER}
```

## Composing multiple repositories for local development
For scenarios where multiple containers need to be created across multiple repositories, it is recommended to create a "development" repo.

The development repository should:
- clone all necessary repositories
- builds images from Dockerfiles in each repository by referencing Docker Compose files in those repositories
- run containers based on those images in a single Docker network by referencing Docker Compose files in those repositories
- run single containers for any shared dependencies across repositories such as message queues or databases

To facilitate this, each repository with a potentially shared dependency will need it's Docker Compose override files to be setup in such a way that dependency containers can be isolated.  This will allow those repository services to run both in isolation and as part of wider service depending on development needs.

For example, let's say we have two repositories, **ServiceA** and **ServiceB**.  **ServiceA** communicates with **ServiceB** via an ActiveMQ message queue. **ServiceB** has a PostgreSQL database.

**ServiceA**'s Docker Compose files could be structured as follows.

`docker-compose.yaml` - builds image and runs **ServiceA**
`docker-compose.override.yaml` - runs Artemis ActiveMQ container
`docker-compose.link.yaml` - runs **ServiceA** in a named Docker network

**ServiceB**'s Docker Compose files could be structured as follows.

`docker-compose.yaml` - builds image and runs **ServiceB** and PostgreSQL container
`docker-compose.override.yaml` - runs Artemis ActiveMQ container
`docker-compose.link.yaml` - runs **ServiceB** in a named Docker network

**ServiceA** and **ServiceB** can be run in isolation by running the following commands in each repository.

`docker-compose build`
`docker-compose up`

The development repository would contain the following.

`docker-compose.yaml` - runs Artemis ActiveMQ container in named Docker network

A script which would run the following commands:

```
if [ -z "$(docker network ls --filter name=^NETWORK_NAME$ --format={{.Name}})" ]; then
  docker network create NETWORK_NAME
fi
docker-compose up
docker-compose -f path/to/ServiceA/docker-compose.yaml -f path/to/ServiceA/docker-compose.link.yaml up --detach
docker-compose -f path/to/ServiceB/docker-compose.yaml -f path/to/ServiceB/docker-compose.link.yaml up --detach
```