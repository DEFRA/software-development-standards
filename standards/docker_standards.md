## Docker standards

### General
- all containers should be created using Docker
- Linux containers should be used
- containers should not be run using root user
- containers should be scanned regularly for vulnerabilities

### Parent images
We should create Dockerfiles that are extended from a minimal Defra created parent images.  This will allow us to benefit from improved security and more efficient builds as we will not have to repeat steps that are common to all Dockerfiles.

Different parent images should be created in line with each framework's best practice.  Eg, Node.js, .Net Core, Ruby etc.

Parent Dockerfiles should be hosted in GitHub and be deployed to a container registry via CI/CD.

Example Node.js parent image:
```
ARG NODE_VERSION=10.18.0
FROM node:$NODE_VERSION-alpine
ARG NODE_VERSION
ARG VERSION=1.0.0

# We need a basic init process to handle signals and reap zombie processes, tini handles that
RUN apk update && apk add --no-cache tini=0.18.0-r0
ENTRYPOINT ["/sbin/tini", "--"]

# Never run as root, use the node user from the alpine image
USER node
# Default workdir for all the containers that use this image
WORKDIR /home/node

ENV NODE_ENV production
# Set global npm dependancies to be stored under the node user directory
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin
LABEL uk.gov.defra.ffc-node-base.version=$VERSION \
      uk.gov.defra.ffc-node-base.node-version=$NODE_VERSION
```

#### Node.js
- extend a minimal Node base image - e.g. node:alpine
- set a fixed major version of the base image
- set the `NODE_ENV` environment variable to production in parent
- set global NPM dependencies to be stored under the node user directory:
  ```
  ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
  ENV PATH=$PATH:/home/node/.npm-global/bin
  ```
- run as the `node` user and not `root`
- ensure the working directory is owned by the node user - e.g. /home/node
- make the exposed port configurable via a build argument and set as an environment variable:
  ```
  ARG PORT=3000
  ENV PORT ${PORT}
  ```

#### .Net Core
- a parent image should exist for both the .Net Core SDK and the .Net Core Runtime
- extend a minimal .Net Core base image
- set a fixed major version of the base image
- set the `ASPNETCORE_ENVIRONMENT` environment variable to production in parent
- run as the `www-data` user and not `root`
- ensure the working directory is owned by the www-data user - e.g. /app
- a remote debugger should be added to the SDK file to aid development and testing
  ```
  RUN apt-get update \
  && apt-get install -y --no-install-recommends unzip \
  && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg
  ```

## Container scanning
Container scanning tools collate vulnerability reports from a number of sources to determine security issues within operating system kernels, libraries, and software packages.

Containers should be regularly scanned using tools such as Clair, Anchore Engine, Aqua Trivy or JFrog XRay.

A comparison of the different tools is available in [Confluence](https://eaflood.atlassian.net/wiki/spaces/FPS/pages/1408172407/Container+Image+Scanning+Tools)

## Multi stage builds
Dockerfiles should implement multi stage builds to allow different container configuration and behaviour to be created for development, test and production.

Below is an example multi stage build which is intended to use the Future Farming and Countryside (FFC) Node.js parent image.

```
# Base stage installs production dependencies
ARG REGISTRY=562955126301.dkr.ecr.eu-west-2.amazonaws.com
ARG BASE_VERSION=1.0.0
ARG DEV_VERSION=1.0.0
FROM $REGISTRY/ffc-node-base:$BASE_VERSION as base
ARG PORT=3000
ENV PORT ${PORT}
USER node
WORKDIR /home/node
COPY --chown=node:node package*.json ./
RUN npm ci

# Development stage installs devDependencies, builds app from source and declares a file watcher as the default command
FROM $REGISTRY/ffc-node-development:$DEV_VERSION AS development
EXPOSE ${PORT} 9229 9230
USER node
WORKDIR /home/node
COPY --from=base --chown=node:node /home/node/package*.json ./
COPY --from=base --chown=node:node /home/node/node_modules ./node_modules
RUN npm install
COPY --chown=node:node app/ ./app/
RUN npm run build
CMD [ "npm", "run", "start:watch" ]

# Test stage copied in Jest configuration and declares the test task as the default command
FROM development AS test
USER node
WORKDIR /home/node
COPY --chown=node:node jest.config.js ./jest.config.js
COPY --chown=node:node test/ ./test/
CMD [ "npm", "run", "test" ]

# Production stage exposes service port, copies in built app code and declares the Node app as the default command
FROM base AS production
USER node
WORKDIR /home/node
EXPOSE ${PORT}
COPY --from=development /home/node/app/ ./app/
CMD [ "node", "app/index" ]
```

## Docker Compose
Docker compose can be used for local development and within a CI/CD pipeline to build docker containers.

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

One use case is for testing - common settings can be put into the base `docker-compose.yaml` file, while changes to the command and container names can be placed in override files.

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

## Avoid conflicts with unique container names
The docker container name should be unique in override files if they may be run simultaneously. 

If the `docker-compose.yaml` and the `docker-compose.test.yaml` had the same name conflicts will occur if tearing down and rebuilding the container happens while both containers are in use.

An example of setting the container name can be seen in the sample yaml in [Use override files to reduce duplication](#use-override-files-to-reduce-duplication).

## Use environment variables to guarantee unique projects and containers
When running on a build server a combination of the `-p` switch and environment variables can be used to ensure each build and test has unique project and container names.

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
