# Opening existing private code    

As specified in the [common coding standards](../standards/common_coding_standards.md), you should always code in the open.

Even when you have a temporary need for certain code to be private, you should still maintain that code as if it were already open, as specified in the [government open source guidance](https://www.gov.uk/government/publications/open-source-guidance/when-code-should-be-open-or-closed).

However, you may sometimes inherit code that is not open - these steps are intended to help guide you through making that code open.

## Review the code

- Check for sensitive information: ensure there are no credentials, API keys, or sensitive data in your code. Tools such as gitLeaks can be used for this purpose. You must check your entire commit history, not just the latest code.

- Security flaws: identify and fix any security vulnerabilities. You should analyse your code using SonarQube Cloud to identify security issues in the code and use a tool such as Snyk to check your dependencies for known vulnerabilities.

## Documentation

- Add or improve documentation: make sure your code is well-documented, including comments, README files, and any other relevant documentation. Standard README information is described in the [README standards](../standards/readme_standards.md).

- Commit messages: ensure commit messages are clear and informative.

## Licensing

- Ensure you add the Open Government Licence to your code.

- You must make sure that the information asset owner of your code has agreed to this licence.

## Repository setup

- Private GitHub repository: if your code is not already on GitHub, you can initially migrate it into a private repository. Wherever possible, you should migrate your commit history as this is useful information for people working on the code.

- Public GitHub repository: to open your code, navigate to your repository settings, scroll to the “Danger Zone,” and change the repository visibility to public. 

## Ongoing maintenance

- Version control: use version control to track changes and manage contributions. This is described in the [version control standards](../standards/version_control_standards.md).

- Community engagement: encourage contributions by providing guidelines and maintaining a public issues list.

- General guidance: follow the [general guidance](./README.md) for maintaining good open-source code.
