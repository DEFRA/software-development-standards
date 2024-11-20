## JavaScript standards

Use vanilla JavaScript, don't use extensions to the language such as TypeScript

### Use [Standard JS](https://standardjs.com/) to lint your code

- A consistent approach to code layout, spacing and formatting makes it easier to switch between projects.

By [adding it as a dev dependency](https://standardjs.com/index.html#install) it can be easily used in the terminal,
[Webstorm](https://blog.jetbrains.com/webstorm/2017/04/using-javascript-standard-style/),
and [Visual Studio](https://marketplace.visualstudio.com/items?itemName=chenxsan.vscode-standardjs).

### Do not use front end JavaScript frameworks

- Frameworks such as React, Angular, Vue etc go against [progressive enhancement](https://www.gov.uk/service-manual/technology/using-progressive-enhancement)
- Even frameworks that provide server-side rendering encourage and enable accidental use of client-side approaches, which violate the progressive enhancement principle
- The [GOV.UK Design System](https://design-system.service.gov.uk/) already provides a set of accessible components that support progressive enhancement

A service could make a case for using a framework to deliver a highly-functional progressive enhancement, for example an interactive map, but these must be managed as explicit exceptions to this standard.

## Status

This standard was formally adopted on 1 July 2019.

## Significant changes

Clarification on not using front end frameworks was added 1 December 2024.
