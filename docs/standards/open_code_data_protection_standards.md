# Open code and data protection standards

Defra codes in the open by default, as set out in our [common coding standards](common_coding_standards.md#all-code-is-open). This follows the GOV.UK [Service Standard point 12: make new source code open](https://www.gov.uk/service-manual/service-standard/point-12-make-new-source-code-open), [Technology Code of Practice point 3: be open and use open source](https://www.gov.uk/guidance/be-open-and-use-open-source) and the Service Manual guidance on [making source code open and reusable](https://www.gov.uk/service-manual/technology/making-source-code-open-and-reusable).

Coding in the open only works if we keep personal data, secrets and other sensitive information out of everything we publish. This is the responsibility of everyone who contributes to Defra code, including staff, contingent workers and suppliers.

## Rationale

- Meets the GOV.UK Service Standard and Technology Code of Practice requirements to [code in the open](https://www.gov.uk/service-manual/service-standard/point-12-make-new-source-code-open)
- Protects the people and businesses who use our services
- Supports our obligations under UK GDPR and the Data Protection Act 2018
- Public repositories are scanned by automated tools within minutes of a push, so anything published must be treated as compromised
- Building good habits from the start avoids a costly review before code can be opened later

## Standards

### Code in the open from the start

Make repositories public from the first commit, unless there is an agreed exception. Follow the government guidance on [when code should be open or closed](https://www.gov.uk/government/publications/open-source-guidance/when-code-should-be-open-or-closed) and [security considerations when coding in the open](https://www.gov.uk/government/publications/open-source-guidance/security-considerations-when-coding-in-the-open).

Plan from day one how secrets, configuration and test data will be kept out of the repository. Code that is temporarily private must still be maintained as if it were open.

### Never commit personal data

Personal data must never be committed to a repository, whether in code, comments, test data or documentation.

This includes, but is not limited to:

- Names
- Addresses and postcodes linked to an individual
- Email addresses
- Phone numbers
- Dates of birth
- National Insurance numbers
- Bank details and payment card numbers
- Passport or driving licence numbers
- Vehicle registration numbers
- IP addresses, device identifiers and location data linked to an individual
- Photographs, signatures and scanned documents
- Free text from real cases, such as case notes or correspondence
- Customer or business reference numbers belonging to real customers, such as a Customer Reference Number (CRN) or Single Business Identifier (SBI)
- Special category data, such as health information

If you are unsure whether something is personal data, treat it as personal data. The ICO provides guidance on [what is personal data](https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/personal-information-what-is-it/).

### Never use real customer data in development or testing

Real customer data must not be used in local development, automated tests, test environments, demos or prototypes.

Use the following approaches, in order of preference:

1. **Synthetic data**: generated data that looks realistic but relates to no real person or business. Use data generation libraries and reserved values, such as `example.com` email addresses and [Ofcom drama numbers](https://www.ofcom.org.uk/phones-and-broadband/phone-numbers/numbers-for-drama) like `07700 900123`.
2. **Data injected from a secure data store**: where realistic data is essential, hold it in an access-controlled store outside the repository and inject it at runtime. It must never be committed.
3. **Tokenised, pseudonymised or anonymised data**: only where synthetic data cannot meet the need. This requires agreement from the information asset owner and a data protection impact assessment (DPIA).

Pseudonymised and tokenised data is still personal data under UK GDPR and must be protected in the same way. Read the ICO guidance on [anonymisation and pseudonymisation](https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/data-sharing/anonymisation/).

Synthetic test data should be committed alongside the tests that use it, so tests are repeatable.

### Never commit secrets or credentials

Secrets and credentials must never be committed to a repository, even temporarily or in a private repository.

This includes, but is not limited to:

- Passwords
- API keys and client secrets
- Access tokens, refresh tokens and session tokens
- Private keys and certificates (for example `.pem`, `.key` and `.pfx` files)
- SSH keys
- Database connection strings containing credentials
- Cloud access keys, such as AWS access keys or Azure storage account keys and SAS tokens
- Webhook URLs with embedded tokens, such as Slack or Teams webhooks
- Signing and encryption keys
- Package registry tokens, for example in `.npmrc` or `NuGet.config`
- `kubeconfig` files
- Terraform state files

Store secrets in a cloud secret store, such as AWS Secrets Manager, Azure Key Vault or the Core Delivery Platform secrets mechanism. Follow the [managing application credentials guide](../guides/application_credentials.md) for how your application should read them.

Secrets must:

- be scoped to the minimum access needed (least privilege)
- be different in each environment
- be able to be rotated without code changes
- be rotated regularly and whenever someone with access leaves the team

Prefer short-lived credentials over long-lived ones. For example, use OpenID Connect (OIDC) to authenticate CI pipelines to cloud providers rather than storing static access keys.

The [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html) provides further industry best practice.

### Separate configuration from code

Configuration that varies between environments must be held outside the code, following [The Twelve-Factor App guidance on config](https://12factor.net/config).

- Read configuration from environment variables or a configuration service
- Commit sensible non-sensitive defaults so the application is easy to run locally
- Commit an example file, such as `.env.example`, containing every required setting with placeholder values
- Add files that hold real values to `.gitignore`, for example `.env`, local configuration overrides and key files
- Never set secrets in Docker `ENV` or `ARG` instructions, as these are stored in the image. See the [container standards](container_standards.md)
- Never store secrets in plain text in Helm values or Kubernetes manifests. See the [Kubernetes standards](kubernetes_standards.md)
- Validate configuration on startup and fail fast if required values are missing

An example `.env.example`:

```bash
PORT=3000
LOG_LEVEL=info
DATABASE_HOST=localhost
DATABASE_USER=replace-me
DATABASE_PASSWORD=replace-me
NOTIFY_API_KEY=replace-me
```

Configuration code, such as infrastructure as code, should still be published in the open. Follow the Service Manual guidance on [making configuration code open](https://www.gov.uk/service-manual/technology/making-source-code-open-and-reusable#making-configuration-code-open).

### Avoid publishing sensitive infrastructure detail

Do not publish infrastructure detail that adds no value to the code and could help an attacker.

This includes, but is not limited to:

- Internal hostnames and URLs of non-public environments
- Private IP addresses and network ranges
- Cloud account, subscription and tenant IDs, where they are not needed
- Firewall rules and IP allow lists
- Details of security controls, such as monitoring thresholds or fraud detection rules

Inject these values as configuration instead. Speak to your technical architect if you are unsure.

### Keep sensitive data out of everything you publish

The standards on this page apply to everything published alongside code, not just source files.

This includes:

- Commit messages and branch names
- Pull request descriptions and review comments
- Issues and discussions
- Wikis, READMEs and other documentation
- Screenshots and screen recordings
- Test fixtures, snapshots and seed data
- Database dumps and backups
- Log extracts, stack traces and HTTP archive (HAR) files
- Notebook outputs, such as Jupyter notebooks
- CI logs and build artifacts

Mask secrets in CI logs and redact personal data from screenshots and log extracts before sharing them. The [logging standards](logging_standards.md) set out what must not be logged.

### Do not share real data or secrets with AI assistants

Do not include personal data, real customer data or secrets in prompts to AI coding assistants. Use synthetic examples instead.

Check AI-generated code and test data for anything that looks like real personal data or credentials before committing it. See the [GitHub Copilot guide](../guides/github_copilot.md).

### Review for sensitive data before you publish

All changes must be checked for sensitive data as part of [code review](../processes/pull_requests.md). Reviewers should check the whole change, including test data, configuration and documentation.

GitHub secret scanning and push protection are enabled across the Defra organisation. Do not bypass push protection unless you are certain the detection is a false positive. See the [GitHub Advanced Security guide](../guides/github_advanced_security.md) and [resolving GitHub security alerts](../processes/github_security_alerts.md).

Remember that commit history is published too. Removing sensitive data in a later commit does not remove it from the repository. When opening existing code, follow the guide to [opening existing private code](../guides/opening_private_code.md).

### Act immediately if sensitive data is published

If a secret or credential is published, follow the [credential exposure process](../processes/credential_exposure.md). Always treat the secret as compromised and rotate it.

If personal data is published, treat it as a personal data breach. Report it immediately using Defra's [incident reporting process](https://defra.sharepoint.com/sites/Defraintranet/SitePages/Incident-reporting.aspx) (internal link). Defra Security will assess the breach and decide whether it must be reported to the ICO. Some breaches must be reported to the ICO within 72 hours, so do not delay.

Do not report the breach to the ICO yourself.

Making a repository private or deleting it does not fix the problem. The data may already have been cached, cloned or forked.

## Related standards and guidance

- [Common coding standards](common_coding_standards.md)
- [Logging standards](logging_standards.md)
- [Security standards](security_standards.md)
- [Quality assurance and test standards](quality_assurance_standards.md)
- [Managing application credentials](../guides/application_credentials.md)
- [Credential exposure](../processes/credential_exposure.md)
- [Opening existing private code](../guides/opening_private_code.md)
- [GitHub Advanced Security](../guides/github_advanced_security.md)

## Status

This standard was added in November 2026.
