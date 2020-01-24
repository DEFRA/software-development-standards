# Quality assurance and test standards

This page covers the minimum standards that apply to quality assurance (QA) and testing on Defra's digital services.

All digital services must meet the [GOV.UK service standard](https://www.gov.uk/service-manual/service-standard).

Government Digital Service guidance on testing services is available on the [technology page of the service manual](https://www.gov.uk/service-manual/technology).

Further QA & Test guidance is available on the [Defra QA & Test wiki](https://github.com/DEFRA/qa-test/wiki).

## Acceptance criteria

Wherever possible, define positive and negative acceptance criteria up front, **before** a story is developed.

Default acceptance criteria for new stories:

* Screens, behaviour and content match designs from the prototype or wireframe
* Styles match the [design system](https://design-system.service.gov.uk/)
* Accessible - meets [Web Content Accessibility Guidelines (WCAG) version 2.1](https://www.w3.org/WAI/standards-guidelines/wcag/glance/) at levels A and AA
* Works across [all supported browsers](https://www.gov.uk/service-manual/technology/designing-for-different-browsers-and-devices) including IE11 and mobile
* Server-side [error validation](https://design-system.service.gov.uk/components/error-message/) exists for all fields
* No obvious performance issues (most transactions under 1 second, avoid transactions over 10 seconds)
* No existing functionality has regressed

Negative scenarios are just as important as positive ones. For example, "an admin user can export data" implies that "a standard user cannot export data".

## Accessibility

All digital services, internal or external-facing, must meet [Web Content Accessibility Guidelines (WCAG) version 2.1](https://www.w3.org/WAI/standards-guidelines/wcag/glance/) at levels A and AA.

[Accessibility information, guides and checklist](https://github.com/DEFRA/qa-test/wiki/Accessibility) used in Defra

[GOV.UK accessibility guidance](https://www.gov.uk/service-manual/helping-people-to-use-your-service/making-your-service-accessible-an-introduction)

## Automated testing

The default test technologies for new projects are:

* Cucumber
* [Webdriver.io](https://webdriver.io/)
* Node.JS
* Selenium

[More test automation information and guides](https://github.com/DEFRA/qa-test/wiki/Automation)

Use GitHub to publish test code in the open, but **never** publish any passwords or other sensitive data. Passwords can be stored in private files or repositories (for example hiding a file using `.gitignore`), or via local environment variables.

## Browser testing

Test services on the [GOV.UK set of required browsers](https://www.gov.uk/service-manual/technology/designing-for-different-browsers-and-devices).

## Bug (defect) management

By default, use [Jira](https://www.atlassian.com/software/jira) to manage bugs as follows:

* If a bug is as a direct result of a story that's currently in development, then attach the details to that story.
* If a bug is a regression issue then raise a separate bug in Jira.

[Defra Jira guidance and list of administrators](https://github.com/DEFRA/qa-test/wiki/Jira)

## Code quality testing

Automated test code must meet Defra [software development standards](https://github.com/DEFRA/software-development-standards).

All development and test code must undergo regular linting to check that it meets minimum standards.

## Continuous integration (pipeline)

By default we use Jenkins for continuous integration and to manage deployments.

Where possible, build automated tests into the team's continuous integration process, so that only working code can be deployed. These can be done for functional testing as well as performance and accessibility.

## Documentation

Quality assurance must produce the following documentation as part of any major work:

* **Test plan**, using the headings on this page as a guide
* **Test completion report** before a major release, detailing the status of any testing and bugs, and any outstanding risks
* **Automated test suite** with features written in a format readable to non-technical colleagues

Official templates are on the QA & Test Sharepoint although these can be adapted to meet the needs of the team.

For each user story, document its testing alongside that story - for example, as Jira comments or a linked document.

Other documentation, produced by QA as required:

* **QA information document** covering practical information such as how to access test environments and data.
* **Site map** - a list of pages on the service and whether they are covered by automated tests
* **Performance test report**

## Exploratory testing

All stories should undergo a level of manual, exploratory testing based on the perceived level of risk that needs mitigating. This relies on the experience of the tester. If unsure how best to approach this, the speak to a QA colleague to help put together an exploratory test charter.

[GOV.UK information on exploratory testing](https://www.gov.uk/service-manual/technology/exploratory-testing)

## High availability testing

Before releasing a new production environment, work with the WebOps team to test and monitor how the service recovers from servers being deactivated.

## Penetration (security) testing

[GOV.UK advice on vulnerability and penetration testing](https://www.gov.uk/service-manual/technology/vulnerability-and-penetration-testing)

## Performance testing

The default tool in Defra is [JMeter](https://jmeter.apache.org/).

Any performance test should include the following by default:

* **Load** - can the service deal with 120% of the likely maximum load?
* **Soak** - can the service deal with high load for a prolonged period without memory leakage?
* **Stress** - what is the service's breaking point, and how does it recover?

## Risk management

Share any risks that originate from QA activity with your product manager and ensure that you have sight of the team risk register.

## Unit and API testing

Maintain visibility of the unit and API test approach, and test coverage.

## Usability

Maintain sight of the team's user research - the recommendation is to be involved for [2 hours every 6 weeks](https://www.gov.uk/service-manual/user-research/how-user-research-improves-service-design).

[Test your service with users with disabilities](https://www.gov.uk/service-manual/user-research/running-research-sessions-with-people-with-disabilities).
