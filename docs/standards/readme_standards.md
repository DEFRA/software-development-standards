# README standards

Every repo must have a README file in its root. The README is the starting point for anyone who wants to develop or test the repo. It provides an overview of what the repo is, and how to install, run and test its contents.

The README should include the following (if they apply):

- **Description of the product** – what the service or product is, and what role this repo performs within it
- **Prerequisites** – what you need to install or configure before you can set up the repo
- **Setup process** - how to set up your local environment to work on the repo, including:
  - development tools
  - test tools
- **How to run in development** – how to locally run the application in development mode after setup
- **How to run tests** – how to run the test suite, broken into different categories if relevant (unit, integration, acceptance)
- **Branching policy** – the branching policy used by the project
- **Contributing to the project** - what to know before you submit your first pull request (this could also be in the form of a `CONTRIBUTING.md` file)
- **Licence information** – what licence the repo uses (in addition to your `LICENSE` file)

The file should be in Markdown format (.md).

## Additional detail

You may also want to include:

- How the product fits into wider architecture
- Internal product architecture
- Data structure
- API end points
- Monitoring
- Error handling
- Audit
- User access
- Security
- Complexity worth documenting
- Pipelines

If this documentation is too lengthy or complex, it doesn't have to be in the README. Just make sure your README tells users where to find these additional docs.

## A basic README.md template

```markdown
# name-of-repo

The "Register your dinosaur" service allows customers to apply online for a dinosaur licence.

This application handles the backend dinosaur processing.

## Prerequisites

## Setup

### Development

### Test

## Running in development

## Running tests

## Branching policy

## Contributing to this project

Please read the [contribution guidelines](/CONTRIBUTING.md) before submitting a pull request.

## Licence

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

>Contains public sector information licensed under the Open Government licence v3

### About the licence

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
```
