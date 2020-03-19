# Docker standards

## Terminology
`Dockerfile` - set of instructions for building a docker image  
`Image` - a constructed set of layered docker instructions  
`Container` - a running instance of an image

## Standards
- images are created using Docker
- Docker Compose is used for defining container builds
- Linux containers are used if the service to be containerised can run on Linux
- images are built from alpine base images
- images are built using Defra parent images (see below)
- containers are not run using root user
- containers are scanned regularly for vulnerabilities
- images are be signed
- images are tagged using semantic versioning
- images are self contained and carry all runtime dependencies
- production images should be immutable and once built do not change but can be configured
- images have well defined APIs to expose functionality
- containers run as a single process

## Defra parent images
Images are extended from a minimal Defra created parent image.  This allow us to benefit from improved security and more efficient builds as we will not have to repeat steps that are common to all Dockerfiles.

Different parent images should be created in line with each framework's best practice.  Eg, Node.js, .Net Core, Ruby etc.

Defra's Dockerfiles to build parent images can be found in the below repositories:
- [Node.js](https://github.com/DEFRA/defra-docker-node)
- [.Net Core](https://github.com/DEFRA/defra-docker-dotnetcore)
