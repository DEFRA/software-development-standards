# GitHub Advanced Security

[GitHub Advanced Security (GHAS)](https://docs.github.com/en/get-started/learning-about-github/about-github-advanced-security) is GitHub's suite of built-in security features. It is enabled on every repository in the Defra GitHub organisation.

GHAS includes:

- **Secret scanning** — detects secrets such as API keys and tokens committed to code
- **Push protection** — proactively blocks pushes that contain detected secrets
- **Dependabot** — identifies vulnerable or outdated dependencies and can automatically raise pull requests to address them
- **Code scanning** — performs static analysis to surface potential security vulnerabilities in code

Teams should maximise use of these built-in features. See the [security standards](../standards/security_standards.md) for configuration expectations.

## Secret scanning

GitHub scans all commits for secrets such as passwords, API keys, and tokens. Alerts appear under the **Security** tab in your repository and are also visible in the [Defra security overview](https://github.com/orgs/DEFRA/security/overview).

There are two types of alert:

- **Default alerts** — match GitHub's known secret patterns, plus any custom patterns added for the Defra organisation. These are higher confidence.
- **Generic alerts** — detected by GitHub's AI analysis and do not follow a known provider pattern. These have a higher rate of false positives.

Alerts indicate _potential_ secret exposure that needs investigation, not confirmed exposure. Archived repositories are included in secret scanning results — even though the code is no longer maintained, the secret value may still be active.

View all secret scanning alerts for the Defra org:

- [Default secret alerts](https://github.com/orgs/DEFRA/security/alerts/secret-scanning)
- [Generic secret alerts](https://github.com/orgs/DEFRA/security/alerts/secret-scanning?query=is%3Aopen+results%3Ageneric)

### Push protection

[Push protection](https://docs.github.com/en/code-security/secret-scanning/introduction/about-push-protection) is enabled across the Defra organisation. GitHub will block a push if it detects a potential secret in the code before it is published to the repository.

Only an **admin** can bypass push protection. If you believe a detection is a false positive, you can submit a bypass request through the GitHub UI by providing a reason.

**You must then post in the #github-support channel on the defra-digital Slack to have your request actioned.** Include:

- a link to the bypass request
- a brief explanation of why the protection should be bypassed

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.

### Custom secret patterns

The Defra organisation has custom secret patterns in addition to GitHub's defaults. Teams can request new custom patterns by posting in **#github-support** on the defra-digital Slack.

### If a secret has been exposed

If a secret has already been committed and published, follow the [credential exposure process](../processes/credential_exposure.md). The key point is: once exposed, always treat the secret as compromised — rotate it immediately regardless of how quickly the commit was removed.

## Vulnerability alerts

[Dependabot](https://docs.github.com/en/code-security/dependabot) scans your repository's dependencies against the GitHub Advisory Database and raises alerts when a vulnerability is detected. It can also automatically raise pull requests to update affected packages.

Vulnerability alerts appear in the **Security** tab of your repository and in the [Defra vulnerabilities overview](https://github.com/orgs/DEFRA/security/alerts/dependabot).

Vulnerabilities in dependencies are common across all languages and frameworks. A new vulnerability alert does not mean the code has changed — it means someone has discovered a new way to exploit existing code. The risk is failing to respond to that information.

Teams should:

- regularly review Dependabot alerts in their repositories
- action alerts promptly — either by patching the dependency or dismissing the alert with a reason

Only an **admin** can dismiss a Dependabot alert. If you need to dismiss one, submit the dismissal through the GitHub UI and then post in **#github-support** to have it approved. Include:

- a link to the dismissal request
- a brief explanation of why the alert can be dismissed

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.

## Code scanning

[Code scanning](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning) uses [CodeQL](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning-with-codeql) to perform static analysis on your code and surface potential security vulnerabilities. Alerts appear in the **Security** tab of your repository.

Like Dependabot alerts, code scanning alert dismissals require admin approval — post in **#github-support** with a link to the dismissal and a brief reason.

## Security overview

The [Defra security overview](https://github.com/orgs/DEFRA/security/overview) provides an org-wide breakdown of potential threats across all repositories. It includes:

- [**Malware**](https://github.com/orgs/DEFRA/security/alerts/malware) — repositories potentially containing known malware
- [**Vulnerabilities**](https://github.com/orgs/DEFRA/security/alerts/dependabot) — repositories with known dependency vulnerabilities that have not been archived
- [**Default secrets**](https://github.com/orgs/DEFRA/security/alerts/secret-scanning) — potential secrets matching known provider patterns or custom org patterns
- [**Generic secrets**](https://github.com/orgs/DEFRA/security/alerts/secret-scanning?query=is%3Aopen+results%3Ageneric) — potential secrets detected by AI analysis

## Monitoring security alerts

Teams are responsible for staying on top of security alerts in their repositories.

### Repository Security tab

The **Security** tab in every GitHub repository shows all open Dependabot, code scanning, and secret scanning alerts. Review it regularly — alerts appear as soon as they are detected, without needing to trigger a build.

### GitHub notifications

You can configure [GitHub notifications](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications) to receive alerts for security vulnerabilities in repositories you watch. This helps teams respond to new alerts promptly.

### Dismissing or bypassing alerts

Only an **admin** can bypass push protection or dismiss a security alert. In all cases, post in **#github-support** on the defra-digital Slack with a link to the request and a brief reason.

See the [resolving GitHub security alerts](../processes/github_security_alerts.md) process for full details.
