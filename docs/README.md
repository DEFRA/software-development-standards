# Introduction

> These pages are automatically generated from content hosted in this [GitHub repository](https://github.com/DEFRA/software-development-standards)

## About

This is the home for standards and guidance relating to software development in [Defra](https://www.gov.uk/government/organisations/department-for-environment-food-rural-affairs).

These form part of the software development standards policy for Defra and apply to all software development undertaken on behalf of the Defra group whether by staff, contingent workers or suppliers.

All developers working on behalf of Defra need to be aware of their obligation to follow these standards.

Any deviation must be managed as an exception under Defra's architectural governance processes.

We maintain these standards on GitHub to ensure they have the greatest visibility to all developers and are readily available in a familiar environment. To aid readability, you can refer to the [GitHub documentation on managing accessibility settings](https:/..github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-user-account-settings/managing-accessibility-settings).

## Principles

The standards and guidance provided here a based on an agreed set of principles.

- [Principles for these standards](./principles/README.md)
- [Coding principles](./principles/coding_principles.md)
- [Security principles](./principles/security_principles.md)


## Standards

These are the standards that must be followed for all software development undertaken on behalf of the Defra group.

### Coding standards

- [Common coding standards](./standards/common_coding_standards.md)
- [Development languages](./standards/development_language_standards.md)
- [JavaScript standards](./standards/javascript_standards.md)
- [C# coding standards](./standards/csharp_coding_standards.md)
- [Logging standards](./standards/logging_standards.md)
- [Mobile application standards](./standards/mobile_app_standards.md)
- [Node.js standards](./standards/node_standards.md)
- [UiPath standards](./standards/uipath_standards.md)
- [Quality assurance and test standards](./standards/quality_assurance_standards.md)
- [Security standards](./standards/security_standards.md)
- [Version control standards](./standards/version_control_standards.md)

### Packaging and deployment standards
  
- [Container standards](./standards/container_standards.md)
- [Deployment standards](./standards/deployment_standards.md)
- [Kubernetes standards](./standards/kubernetes_standards.md)

### Database standards

- [PL/SQL coding standards](./standards/plsql_coding_standards.md)
- [TSQL and SQL Server database standards](./standards/tsql_and_sqldb_standards.md)

### Documentation standards

- [README standards](./standards/readme_standards.md)

### Standards for non-strategic technologies

- [Java coding standards](./standards/java_coding_standards.md)
- [Ruby coding standards](./standards/ruby_coding_standards.md)

## Processes and guides

These guides provide additional support for meeting and working with the standards.

### Processes

- [Credential exposure](./processes/credential_exposure.md)
- [GitHub access](./processes/github_access.md)
- [Pull requests](./processes/pull_requests.md)

### Guides

- [General guidance](./guides/README.md)
- [Choosing between a mono repo and a multi repo](./guides/mono_or_multi_repo.md)
- [Choosing packages](./guides/choosing_packages.md)
- [Continuous integration](./guides/continuous_integration.md)
- [Developer workflows](./guides/developer_workflows.md)
- [Docker guidance](./guides/docker_guidance.md)
- [Java auto-format with Eclipse](./guides/java_auto_format_eclipse.md)
- [Kubernetes](./guides/kubernetes.md)
- [Mobile application guidance](./guides/mobile_app_guidance.md)
- [New starters](./guides/new_starters.md)
- [Opening existing private code](./guides/opening_private_code.md)
- [PL/SQL auto-format with TOAD](./guides/plsql_auto_format_toad.md)
- [SQL Prompt](./guides/version_control_guidance.md)
- [Style guide for standards](./guides/style_guide_for_standards.md)
- [Using AWS session manager](./guides/aws_session_manager.md)
- [Using unmanaged devices](./guides/unmanaged_devices.md)
- [Version control guidance](./guides/version_control_guidance.md)

## Contributing to this project

We encourage everyone to contribute to these standards!

They have been produced as a series of markdown files to make the process of adding and maintaining the documentation as simple as possible.

It is maintained under source control to cater for this, allowing anyone to make suggestions for improvement via the standard [pull request process](https://help.github.com/articles/using-pull-requests/). They can then be discussed and approved by the [DEFRA/sds-group](https://github.com/orgs/DEFRA/teams/sds-group).

Please ensure you have read our [principles](./principles/README.md) first, and then [contribution guidelines](CONTRIBUTING.md) for details on how to get started.

## Viewing the guide

The guide is best viewed in GitHub pages at [https://defra.github.io/software-development-standards](https://defra.github.io/software-development-standards/)

## Updating the guide

This documentation is written in markdown and is built using [MkDocs](https://www.mkdocs.org) and the [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) theme.

Please follow the below installation instructions prior to working with this repository:

- [mkdocs.org](https://www.mkdocs.org)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

Running `mkdocs serve` will build the site locally and run it on an available localhost port.

There is no need to manually publish page updates to GitHub pages.  This is automated following a merge into the main branch.

## License

THIS INFORMATION IS LICENSED UNDER THE CONDITIONS OF THE OPEN GOVERNMENT LICENCE found at:

<http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3>

The following attribution statement MUST be cited in your products and applications when using this information.

>Contains public sector information licensed under the Open Government license v3

### About the license

The Open Government Licence (OGL) was developed by the Controller of Her Majesty's Stationery Office (HMSO) to enable information providers in the public sector to license the use and re-use of their information under a common open licence.

It is designed to encourage use and re-use of information freely and flexibly, with only a few conditions.
