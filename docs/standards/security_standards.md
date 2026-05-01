# Security Standard

Having a secure approach to development has never been so important.

The way we build software and systems is rapidly evolving, becoming more and more automated and integrated. This results in a need to have some standards and guidance around security. Rather than maintain our own, we follow the standards of [OWASP](https://www.owasp.org/index.php/Main_Page)

## Standards

Use the [OWASP Secure coding practices - quick reference guide](https://www.owasp.org/index.php/OWASP_Secure_Coding_Practices_-_Quick_Reference_Guide) for details of the standards to apply.

**Important note.** We are using version 2

## GitHub Advanced Security

Defra has GitHub Advanced Security enabled across its organisation. Teams should maximise use of these built-in features rather than relying on third-party tools.

### Dependency graph

Ensure the [dependency graph](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph) is enabled in every repository. It is the foundation for Dependabot alerts and the dependency review action.

### Dependabot

Enable [Dependabot](https://docs.github.com/en/code-security/dependabot) to automatically raise pull requests when vulnerable or outdated dependencies are detected. Grouped updates are recommended to reduce noise — see [grouping Dependabot version updates](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file#groups) for configuration details.

### Dependency review action

Add the [GitHub dependency review action](https://github.com/actions/dependency-review-action) to your pull request workflow. It compares the dependencies introduced by a PR against the GitHub Advisory Database and fails the check if any known-vulnerable packages are being added, preventing vulnerabilities from being merged rather than detecting them after the fact.

An example workflow can be found in the [fcp-audit repository](https://github.com/DEFRA/fcp-audit/blob/309fc8ed7022ed981ee620d97bd455799a704cf0/.github/workflows/).

### GitHub Security tab

Regularly review the **Security** tab in your repository. It provides a continuously-updated view of:

- Dependabot alerts for vulnerable dependencies already in the repo
- Code scanning alerts from static analysis
- Secret scanning alerts

This means you do not need to wait for a build to run to discover a vulnerability, issues are surfaced as soon as they are detected.

### Snyk

Snyk has been assessed alongside GitHub Advanced Security. As GitHub Advanced Security provides largely equivalent capability and is already available to all Defra teams, teams should look to maximise usage of GitHub Advanced Security rather than relying on Snyk.

