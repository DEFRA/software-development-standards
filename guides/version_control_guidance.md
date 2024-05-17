# Version control guidance

This guidance helps to explain how to apply version control to our code.

It is compliant with our version control standards, but provides some additional information on ways to implement version control practice.

## Teams

Avoid putting everything related to your project in a single repository.

Put each component (application, package, library, etc) into its own repository, and use [GitHub teams](https://help.github.com/en/articles/organizing-members-into-teams) to manage access to them.

This makes it easy to apply version control to each component individually, whilst also ensuring that access to the repositories is simple to control.

For additional guidance on choosing between a mono repo and a multi repo, see the [guidance](/guides/choosing_mono_or_multi_repo.md).
