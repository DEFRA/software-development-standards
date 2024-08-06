# Mono repo and a multi repo

A mono repo is a single repository that contains all the code for multiple projects. A multi repo is a collection of repositories, each containing the code for a single project. Both approaches have their own advantages and disadvantages. This guide will help you decide which approach is best for your project.

Teams should proactively choose between a mono repo and a multi repo based on the project requirements. Multi repositories are the preferred approach with mono repositories only being used for small single project cases.

The decision should be made at the beginning of the project, as it can be difficult to switch between the two later on.  The level of difficultly will typically depend on the duration of time the project has been running.

The decision should be reviewed periodically to ensure that it still meets the project requirements. If the project requirements change, it may be necessary to switch between a mono repo and a multi repo.

## Considerations

Teams should consider the following key drivers for choosing between a mono repo and a multi repo:

- Size and complexity of the project
- Technology choices
- Application composition
- Collaboration
- CI/CD
- Versioning and release process
- Commit history
- Security
- Ownership

### Size and complexity

A mono repo is best suited for small, single language projects with a low number of dependencies. A multi repo is best suited for large, complex projects with multiple languages and dependencies.

Larger projects can be difficult to manage in a mono repo, as the size and complexity of the codebase can make it difficult to navigate and understand. In this case, a multi repo may be a better choice, as it allows teams to work on smaller, more manageable codebases.

Size of downloading the repository is also a consideration. A mono repo can be large and take a long time to download, particularly for new team members. A multi repo can be smaller and quicker to download, as each repository contains a smaller amount of code.

In all cases teams should consider the content of their repositories to ensure that they are not storing unnecessary files or data.

Performance of scanning tools such as secret detection tools is also increased with smaller repositories.

### Technology choices

Mono repos are best suited for projects that use a single technology stack. Multi repos are best suited for projects that use multiple technology stacks.

If a project uses multiple technology stacks, then it is more difficult to keep a single repository structure consistent.

Multiple technologies in a single repository can also lead to conflicts between any plugins or dependencies that are used by the different technologies within the repository.

### Application composition

Mono repos are best suited if components are compiled into a single application.  However, all other considerations should be taken into account before making a decision as even with monolithic application, a multi repo may be the better approach.

Multi repos are best suited if components are independently deployable applications.

### Collaboration

Mono repos simplify collaboration as all the code is in one place.  This reduces the complexity of access control and visibility of code, pull requests, issues and release notes.

However mono repos may also tightly coupled collaboration needs across independent teams.  This can lead to conflicts and bottlenecks in the development process.

Multi repos are more difficult to collaborate as data is distributed across multiple repositories.  This can mean key data is missed which leads to risk.

If multiple teams support different components then a mono repository should not be used.  Similarly if individuals within a team are responsible for different components such as frontend and backend, then a mono repository should not be used.

### Versioning and release process

For simple projects a single version may be sufficient within a mono repo, however for more complex projects a versioning strategy should be considered.  This may involve additional tooling to independently version and release projects.

Tools such as [Lerna](https://lerna.js.org/) can help manage dependencies and build processes but typically only support one technology stack.

Multi repos can have independent versioning strategies for each project which can simplify the release process.

If not composed into a single application, independent components should be released and versioned independently.

The scale of the service should be considered as releasing or rolling back a large scale mono repo code base can add unnecessary risk and complexity.

### CI/CD

Mono repos simplify CI/CD as multiple projects can be built and tested together. This can reduce the complexity of creating and managing multiple pipelines and dependencies.

However, mono repos can also lead to longer build times and increased complexity in managing dependencies, particularly if multiple technology choices are used.

Additional tooling and complexity may be required to independently build and test projects within a mono repo depending on the scale.

Multi repos require more configuration for CI/CD as each project needs its own pipeline which can lead to duplication of effort and complexity in co-ordination of pipeline updates.

The advantage is a more optimised pipeline for each project.

### Commit history

Mono repos have a single commit history which can make it easier to track changes and understand the history of the codebase.

Multi repos have multiple commit histories which can make it more difficult to track changes and understand the history of the codebase, however the history is more focused.


### Security

Mono repos can simplify security as access control and visibility is centralised.  Dependency scanning tools are also simpler to maintain.

Mono repos can also increase the risk of a single point of failure and increase the impact of a security incident.

It may also be difficult to restrict access to sensitive code or data within a mono repo.

Multi repos can increase the complexity of security as access control and visibility is distributed across multiple repositories increasing the risk stale users may have access to sensitive data.

Multi repos allow for more granular access control.

### Ownership

Mono repos work when a single team owns all the code and is expected to maintain it.

Multi repos support multiple teams owning different parts of the codebase.

## Conclusion

As per [Defra version control standards](/standards/version_control_standards.md), teams should follow a multi repository approach as the default.  Mono repositories should only be used for small scale projects consisting of a single application or package with only one development team.
