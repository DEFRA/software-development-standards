# Container standards

## Terminology
`Dockerfile` - set of instructions for building a docker image  
`Image` - a constructed set of layered docker instructions  
`Container` - a running instance of an image

## Standards
### Images are created using Docker
### Docker Compose is used for defining container builds

Using a consistent containerisation tool will help enforce standards and better promote developer mobility.
 
### Linux containers are used if the service to be containerised can run on Linux  

Underlying container hosts can only host either Linux or Windows containers.  A model of consistenty would reduce the number of underlying hosts.  Windows containers can only be run on Windows hosts which typically have greater licensing costs vs Linux.

*Note that services built using .Net Framework vs .Net Core cannot be run using Linux containers.  Defra's position is .Net Core should be preferred over .Net Framework but there may be some use cases if containerising legacy services*

### Images are built using Defra base images (see below)
### Containers are not run using root user

Containers are not trust boundaries and therefore should never be run as root for security reasons.

### Public images are signed

A digital fingerprint should be added to each image.  This enables consumers of images to verify the source and trust levels of the image they are consuming.

### Production images should be immutable and once built do not change but can be configured
### Images are tagged using semantic versioning
### Images are self contained and carry all runtime dependencies

Images should not be dependent on their host infrastructure for any application dependency.  This enables them to be freely deployed and orchestrated anywhere capable of running containers.

## Defra base images
Images are extended from a minimal Defra created parent image.  This allow us to benefit from improved security and more efficient builds as we will not have to repeat steps that are common to all Dockerfiles.

Different parent images should be created in line with each framework's best practice.  Eg, Node.js, .Net Core, Ruby etc.

Defra's Dockerfiles to build parent images can be found in the below GitHub repositories:
- [Node.js](https://github.com/DEFRA/defra-docker-node)
- [.Net Core](https://github.com/DEFRA/defra-docker-dotnetcore)

Each image is hosted in DockerHub and has an equivalent development and production image.  

- [Node.js](https://hub.docker.com/repository/docker/defradigital/node)
- [Node.js development](https://hub.docker.com/repository/docker/defradigital/node-development)
- [.Net Core](https://hub.docker.com/repository/docker/defradigital/dotnetcore)
- [.Net Core development](https://hub.docker.com/repository/docker/defradigital/dotnetcore-development)
