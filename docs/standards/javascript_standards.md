## JavaScript standards

Use vanilla JavaScript, don't use extensions to the language such as TypeScript

### Use [neostandard](https://github.com/neostandard/neostandard) to lint your code

neostandard is an opinioned JavaScript linter that enforces a consistent coding style.

- A consistent approach to code layout, spacing and formatting makes it easier to switch between projects.

- By adding it as a dev dependency it can be easily used in the terminal and CI pipelines.

- The choice of an opinionated linter is deliberate as it avoids teams needing to spend time debating the merits of different styles.

- Teams should not extend or modify the neostandard ruleset.

#### [Standard JS](https://standardjs.com/)

Standard JS was previously Defra's choice of linter, however this is no longer maintained as it once was.

neostandard is the spiritual successor to Standard JS and is maintained by many of the same people.

Whilst there is no immediate requirement that teams migrate existing codebases to neostandard, new projects should use neostandard.

Migration is relatively straightforward and neostandard [documentation](https://github.com/neostandard/neostandard?tab=readme-ov-file#migrate-from-standard) includes a guide.

### Do not use front end JavaScript frameworks

- Frameworks such as React, Angular, Vue etc go against [progressive enhancement](https://www.gov.uk/service-manual/technology/using-progressive-enhancement)
- Even frameworks that provide server-side rendering encourage and enable accidental use of client-side approaches, which violate the progressive enhancement principle
- The [GOV.UK Design System](https://design-system.service.gov.uk/) already provides a set of accessible components that support progressive enhancement

A service could make a case for using a framework to deliver a highly-functional progressive enhancement, for example an interactive map, but these must be managed as explicit exceptions to this standard.

## Status

This standard was formally adopted on 1 July 2019.

## Significant changes

- Clarification on not using front end frameworks was added 1 December 2024.
- Standard JS was replaced with neostandard 8 April 2025
