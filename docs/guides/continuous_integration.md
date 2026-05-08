# Continuous integration

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

#### Dependabot

Enable [Dependabot](https://docs.github.com/en/code-security/dependabot) in each repository to automatically raise pull requests when vulnerable or outdated dependencies are detected. 

Dependabot depends on the [dependency graph](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph) being enabled.

> Dependency graph will shortly be automatically enabled for all repositories by default.

Grouped Dependabot updates are recommended to reduce pull request noise.

#### Dependency review action

Add the [dependency review action](https://github.com/actions/dependency-review-action) to your pull request workflows. It checks whether a PR is introducing any packages with known vulnerabilities and fails the check if so, preventing vulnerable dependencies from being merged.

The review won't catch vulnerabilities in existing dependencies, but it will help prevent new ones from being added.

See the [security standards](../standards/security_standards.md) for more details and an example workflow.

#### GitHub Security tab

Regularly review the **Security** tab in your GitHub repository. It provides a continuously-updated view of Dependabot alerts, code scanning results, and secret scanning alerts without needing to trigger a build.

### Maintainability and test coverage

Defra has a [SonarQube Cloud](https://www.sonarsource.com/products/sonarcloud/) organisation, which should be used to perform static quality analysis checks on your code.
It provides a rating for the security, reliability and maintainability of your code and estimates the time it would take to deal with any technical debt.

You should include SonarQube Cloud in your CI so that it flags problems it spots in your code, like duplication or complexity.

You can also configure your build tool (like GitHub Actions) to report unit test coverage to SonarQube Cloud.
It will then include your test coverage in its assessment of your code.

SonarQube Cloud is free to use for open source GitHub repositories.

### Significant changes

GitHub Advanced Security integration added 1 May 2026.
