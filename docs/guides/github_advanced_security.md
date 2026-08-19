# GitHub Advanced Security

[GitHub Advanced Security (GHAS)](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security) is GitHub's suite of built-in security features. It is enabled on every repository in the Defra GitHub organisation.

GHAS includes:

- **Secret scanning** - detects secrets such as API keys and tokens committed to code
- **Push protection** - proactively blocks pushes that contain detected secrets
- **Dependabot** - identifies vulnerable or outdated dependencies and can automatically raise pull requests to address them
- **Code scanning** - performs static analysis to surface potential security vulnerabilities in code

Teams should maximise use of these built-in features. See the [security standards](../standards/security_standards.md) for configuration expectations.

## Secret scanning

GitHub scans all commits for secrets such as passwords, API keys, and tokens. Alerts appear under the **Security and Quality** tab in your repository and are also visible in the [Defra security overview](https://github.com/orgs/DEFRA/security/overview).

There are two types of alert:

- **Default alerts** - match GitHub's known secret patterns, plus any custom patterns added for the Defra organisation. These are higher confidence.
- **Generic alerts** - detected by GitHub's AI analysis and do not follow a known provider pattern. These have a higher rate of false positives.

Alerts indicate _potential_ secret exposure that needs investigation, not confirmed exposure. Archived repositories are included in secret scanning results - even though the code is no longer maintained, the secret value may still be active.

View all secret scanning alerts for the Defra org:

- [Default secret alerts](https://github.com/orgs/DEFRA/security/alerts/secret-scanning)
- [Generic secret alerts](https://github.com/orgs/DEFRA/security/alerts/secret-scanning?query=is%3Aopen+results%3Ageneric)

### Push protection

[Push protection](https://docs.github.com/en/code-security/secret-scanning/introduction/about-push-protection) is enabled across the Defra organisation. GitHub will block a push if it detects a potential secret in the code before it is published to the repository.

Only an **admin** can bypass push protection. If you believe a detection is a false positive, you can submit a bypass request through the GitHub UI by providing a reason.

**You must then post in the [`#github-support`](https://defra-digital.slack.com/archives/C015VCNLKFE) channel on the defra-digital Slack to have your request actioned.** Include:

- a link to the bypass request
- a brief explanation of why the protection should be bypassed

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.

### Custom secret patterns

The Defra organisation has custom secret patterns in addition to GitHub's defaults. Teams can request new custom patterns by posting in [`#github-support`](https://defra-digital.slack.com/archives/C015VCNLKFE) on the defra-digital Slack.

### If a secret has been exposed

If a secret has already been committed and published, follow the [credential exposure process](../processes/credential_exposure.md). The key point is: once exposed, always treat the secret as compromised - rotate it immediately regardless of how quickly the commit was removed.

## Vulnerability alerts

[Dependabot](https://docs.github.com/en/code-security/dependabot) scans your repository's dependencies against the GitHub Advisory Database and raises alerts when a vulnerability is detected. It can also automatically raise pull requests to update affected packages.

Vulnerability alerts appear in the **Security and Quality** tab of your repository and in the [Defra vulnerabilities overview](https://github.com/orgs/DEFRA/security/alerts/dependabot).

Vulnerabilities in dependencies are common across all languages and frameworks. A new vulnerability alert does not mean the code has changed - it means someone has discovered a new way to exploit existing code. The risk is failing to respond to that information.

Teams should:

- regularly review Dependabot alerts in their repositories
- action alerts promptly - either by patching the dependency or dismissing the alert with a reason

Only an **admin** can dismiss a Dependabot alert. If you need to dismiss one, submit the dismissal through the GitHub UI and then post in [`#github-support`](https://defra-digital.slack.com/archives/C015VCNLKFE) to have it approved. 

Include:
- a link to the dismissal request
- a brief explanation of why the alert can be dismissed

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.

## Code scanning

[Code scanning](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning) uses [CodeQL](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning-with-codeql) to perform static analysis on your code and surface potential security vulnerabilities. Alerts appear in the **Security and Quality** tab of your repository.

Like Dependabot alerts, code scanning alert dismissals require admin approval - post in [`#github-support`](https://defra-digital.slack.com/archives/C015VCNLKFE) with a link to the dismissal and a brief reason.

## Security overview

The [Defra security overview](https://github.com/orgs/DEFRA/security/overview) provides an org-wide breakdown of potential threats across all repositories. It includes:

- [**Malware**](https://github.com/orgs/DEFRA/security/alerts/malware) - repositories potentially containing known malware
- [**Vulnerabilities**](https://github.com/orgs/DEFRA/security/alerts/dependabot) - repositories with known dependency vulnerabilities that have not been archived
- [**Default secrets**](https://github.com/orgs/DEFRA/security/alerts/secret-scanning) - potential secrets matching known provider patterns or custom org patterns
- [**Generic secrets**](https://github.com/orgs/DEFRA/security/alerts/secret-scanning?query=is%3Aopen+results%3Ageneric) - potential secrets detected by AI analysis

## Monitoring security alerts

Teams are responsible for staying on top of security alerts in their repositories.

### Repository Security tab

The **Security and Quality** tab in every GitHub repository shows all open Dependabot, code scanning, and secret scanning alerts. Review it regularly - alerts appear as soon as they are detected, without needing to trigger a build.

### GitHub notifications

You can configure [GitHub notifications](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications) to receive alerts for security vulnerabilities in repositories you watch. This helps teams respond to new alerts promptly.

### Dismissing or bypassing alerts

Only an **admin** can bypass push protection or dismiss a security alert. In all cases, post in [`#github-support`](https://defra-digital.slack.com/archives/C015VCNLKFE) on the defra-digital Slack with a link to the request and a brief reason.

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.

## Software Bill of Materials (SBOM)

A Software Bill of Materials (SBOM) is a list of all the components in your software, including dependencies and their versions. It helps teams understand the supply chain of their software and identify potential vulnerabilities.

In GitHub, you can generate an SBOM for your repository using the [GitHub Dependency Graph](https://docs.github.com/en/code-security/how-tos/secure-your-supply-chain/establish-provenance-and-integrity/export-dependencies-as-sbom).

The Dependency Graph automatically includes all dependencies in [supported ecosystems](https://docs.github.com/en/code-security/reference/supply-chain-security/dependency-graph-supported-package-ecosystems) where GitHub can read a manifest directly from the repository (for example `package.json` and `.csproj`). Most repositories need no extra setup.

Automatic detection has gaps, though. The sections below cover common scenarios where teams need to submit to the Dependency Graph themselves.

### Container images

Manifest scanning can't see what actually ends up inside a built Docker image, such as base image packages and OS-level dependencies. This is why it does not include dependencies from Docker images used by a repository.

Defra-provided images generate an SBOM from the built image during CI and submit it to their own Dependency Graph on each release:

- [Node.js](https://github.com/DEFRA/defra-docker-node)
- [.NET](https://github.com/DEFRA/defra-docker-dotnetcore)

Both use the [Anchore SBOM Action](https://github.com/marketplace/actions/anchore-sbom-action) against the built image. They need this CI-driven approach because each repository builds several supported versions from one workflow, so a single scan could not represent all of them; each version is submitted separately (see correlators, below). If your repository only builds a single image with no version matrix, a full CI pipeline like this may be more than you need - the simpler options below may be a better fit.

### Other gaps in automatic detection

Dependencies can fail to appear in the Dependency Graph automatically when packages come from private or internal feeds, when dependency data is vendored or generated in ways GitHub cannot parse, or when the ecosystem is outside GitHub's supported list. Rather than one prescribed tool, pick whichever fits your project:

- [SPDX Dependency Submission Action](https://github.com/marketplace/actions/spdx-dependency-submission-action) - uses Microsoft's SBOM Tool, a good general-purpose default with broad ecosystem support.
- [SBOM Dependency Submission Action](https://github.com/marketplace/actions/sbom-submission-action) - submits an existing CycloneDX SBOM, useful if your pipeline already produces one.
- [Anchore SBOM Action](https://github.com/marketplace/actions/anchore-sbom-action) - also works standalone against a filesystem or image target, not just the container matrix case above.
- [Export SBOM from the UI or REST API](https://docs.github.com/en/code-security/how-tos/secure-your-supply-chain/establish-provenance-and-integrity/export-dependencies-as-sbom) - a one-off snapshot rather than a continuous submission, useful for ad hoc requests.

### Submitting more than one component

If a single repository or workflow submits dependencies for more than one component, such as a version matrix or several sub-projects, give each submission its own stable **correlator** so GitHub doesn't overwrite one component's entry with another's. Keep each correlator stable across routine version bumps (for example, key it off a major version rather than the full version string) so history and alerts stay attached to the right component.

> **Retiring a component:** removing a matrix entry or sub-project from CI only stops future updates - GitHub keeps showing the last submitted snapshot for that correlator indefinitely, and Dependabot keeps alerting on it. To clear it, submit one final empty manifest for that correlator, as done by [`scripts/retire-version.sh`](https://github.com/DEFRA/defra-docker-node/blob/main/scripts/retire-version.sh) in the Node.js and .NET image repositories.
