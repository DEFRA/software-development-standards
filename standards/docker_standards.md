## Docker standards

### Terminology
`Dockerfile` - set of instructions for building a docker image  
`Image` - a constructed set of layered docker instructions  
`Container` - a running instance of an image

### General
- images should be created using Docker
- Linux containers are preferred
- containers should be built from alpine base images
- containers should not be run using root user
- containers should be scanned regularly for vulnerabilities
- images should be signed
- images should be tagged using semantic versioning
- images are self contained and carry all runtime dependencies
- production images should be immutable and once built do not change but can be configured
- images should have well defined APIs to expose functionality
- containers should run as a single process 
