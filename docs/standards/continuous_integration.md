# Continuous integration

> Continuous Integration (CI) is a development practice that requires developers to integrate code into a shared repository several times a day. Each check-in is then verified by an automated build, allowing teams to detect problems early.

This automated build can check several things, including:

- the application compiles successfully (if it needs compiling)
- tests pass
- code style checks pass (for example, linters)
- code quality checks pass
- security checks pass

## Branch protection

`Main` branches should be protected with [branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches) to ensure that all changes are reviewed and pass required checks before being merged.

## GitHub Actions

We use [GitHub Actions](https://github.com/features/actions/) for our CI builds as it is well integrated with GitHub and is free to use for open source GitHub repositories.

### Commit SHA pinning

When using GitHub Actions, you should pin your actions to a specific commit SHA rather than a branch or tag. This ensures that the exact version of the action you have tested and approved is used in your workflow.

Whilst this will prevent you from automatically inheriting updates to the action, it will protect you from compromised version tags or branches in the action's repository. This is an increasingly common threat vector for supply chain attacks, where an attacker can push a malicious update to a branch or tag that your workflow is using, and it will automatically be used in your workflow without you needing to change anything.

If you want to update to a new version of the action, you can update the commit SHA in your workflow file after testing the new version.

Example:

Use:

```yaml
# Reference the tag or branch you are targetting as a comment for clarity, but use the commit SHA for the action reference
uses: aquasecurity/trivy-action@57a97c7e7821a5776cebc9bb87c984fa69cba8f1 # 0.35.0
```

Not:

```yaml
uses: aquasecurity/trivy-action@v0.35.0
```

Or:

```yaml
uses: aquasecurity/trivy-action@main
```

The commit SHA can be found in the GitHub Action's repository and selecting the short style commit associated with the target version or branch, then taking the long commit from the browser address bar when viewing that commit.

The long commit SHA should be used as it is guaranteed to be unique.

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

This includes vulnerabilities in your GitHub actions themselves.

> Note: there is a bug in the GitHub UI where the `ecosystem` tab incorrectly filters GitHub Actions as `ecosystem:"GitHub Actions"` instead of the correct `ecosystem:actions`.

### Maintainability and test coverage

Defra has a [SonarQube Cloud](https://www.sonarsource.com/products/sonarcloud/) organisation, which should be used to perform static quality analysis checks on your code.

It provides a rating for the security, reliability and maintainability of your code and estimates the time it would take to deal with any technical debt.

You should include SonarQube Cloud in your CI so that it flags problems it spots in your code, like duplication or complexity.

You should configure your CI to report unit test coverage to SonarQube Cloud. It will then include your test coverage in its assessment of your code.

SonarQube Cloud is free to use for open source GitHub repositories.

### Significant changes

- GitHub Advanced Security integration added 1 May 2026.
- Move from guide to standard 20 May 2026.
- Add commit pinning standard 20 May 2026.
