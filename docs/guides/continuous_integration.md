# Continuous integration

NOTE: This guidance only applies to repositories and projects which are public on GitHub and can therefore take advantage of several free integrations. We intend to expand upon this guide in the future to cover the rest of our ecosystem.

> Continuous Integration (CI) is a development practice that requires developers to integrate code into a shared repository several times a day. Each check-in is then verified by an automated build, allowing teams to detect problems early.
>
> [ThoughtWorks](https://www.thoughtworks.com/continuous-integration)

This automated build can check several things, including:

- the application compiles successfully (if it needs compiling)
- unit tests pass
- code style checks pass (for example, linters)

## CI with GitHub

Many services can integrate with GitHub and automatically respond to new commits or pull requests. So every time you push code to GitHub, it will trigger the build and report the status.

[GitHub Actions](https://github.com/features/actions/) is free to use for open source GitHub repositories.

You can configure your repository to always require certain checks when merging to protected branches (like `main`). If a required check fails, it will block merging until the problem is fixed.

We recommend making the build a required check. This should prevent anyone from merging breaking changes into the main branch.

There are lots of other tools which can integrate with GitHub, especially if your repository is open source.

### Security

These tools check the security of your project. This can include reporting vulnerabilities in your dependencies, or doing static analysis on your code.

- Use [Snyk](https://snyk.io/) for Node.js projects
- Use [Hakiri](https://hakiri.io/) for Ruby projects

These tools are free to use for open source GitHub repositories.

### Maintainability and test coverage

Defra has a [SonarQube Cloud](https://www.sonarsource.com/products/sonarcloud/) organisation, which should be used to perform static quality analysis checks on your code.
It provides a rating for the security, reliability and maintainability of your code and estimates the time it would take to deal with any technical debt.

You should include SonarQube Cloud in your CI so that it flags problems it spots in your code, like duplication or complexity.

You can also configure your build tool (like GitHub Actions) to report unit test coverage to SonarQube Cloud.
It will then include your test coverage in its assessment of your code.

SonarQube Cloud is free to use for open source GitHub repositories.

## CI with Jenkins

We use Jenkins for our internal build servers.
