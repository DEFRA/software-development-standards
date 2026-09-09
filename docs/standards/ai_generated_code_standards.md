# AI generated code standards

Defra approved AI code assistants, such as GitHub Copilot, are permitted and encouraged for use on Defra codebases. Code produced with their help is still held to exactly the same standards as anything written by hand.

For practical guidance on using GitHub Copilot effectively, see the [GitHub Copilot guide](../guides/github_copilot.md).

## Standards

### Developers are accountable for all AI generated code they commit

You are responsible for the correctness, security and quality of every line you commit, regardless of whether you or an AI assistant wrote it.

### All AI generated code must be reviewed before merge

AI generated code should follow the same [code review](common_coding_standards.md#all-code-is-reviewed) process as any other change. Do not merge AI generated code that you have not read, understood and tested yourself.

### AI generated code should meet all existing standards

Coding style, linting, [security](security_standards.md), test coverage standards still apply.

### Never share secrets, credentials or personal data with an AI tool

Prompts and attached context may be sent to a third-party service. Never paste secrets, credentials, connection strings or personal data into a prompt. See [managing application credentials](../guides/application_credentials.md).

### Only use organisationally sanctioned AI tools and licences

Follow the latest guidance from the Defra AI Digital Toolkit - [Tools | AI digital toolkit](https://digital.defra.gov.uk/ai-toolkit/tools)

### Check the licensing and provenance of suggested code

AI assistants can reproduce third-party code, including code under licences incompatible with our projects. If you cannot attest to the licence of a non-trivial suggestion, do not commit it.