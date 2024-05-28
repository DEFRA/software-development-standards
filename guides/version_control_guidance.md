# Version control guidance

This guidance helps to explain how to apply version control to our code.

It is compliant with our version control standards, but provides some additional information on ways to implement version control practice.

## Teams

Teams should follow a multi repository approach and should avoid putting everything related to a project in a single repository.

For example, put each component (application, package, library, etc) into its own repository, and use [GitHub teams](https://help.github.com/en/articles/organizing-members-into-teams) to manage access to them.

This makes it easy to apply version control to each component individually, whilst also ensuring that access to the repositories is simple to control.

A mono repository should only be considered for small scale projects consisting of a single application or package.

For additional context behind this standard, see the [guidance](/guides/mono_or_multi_repo.md).
