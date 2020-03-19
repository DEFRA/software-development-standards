# Docker standards

## Terminology
`Dockerfile` - set of instructions for building a docker image  
`Image` - a constructed set of layered docker instructions  
`Container` - a running instance of an image

## Standards
- images are created using Docker
- Docker Compose is used for defining container builds
- Linux containers are used if the service to be containerised can run on Linux
- containers are built from alpine base images
- containers are not run using root user
- containers are scanned regularly for vulnerabilities
- images are be signed
- images are tagged using semantic versioning
- images are self contained and carry all runtime dependencies
- production images should be immutable and once built do not change but can be configured
- images have well defined APIs to expose functionality
- containers run as a single process
