# Common coding standards

These are common standards that apply to coding.

Mostly these follow common [programming principles](https://en.wikipedia.org/wiki/Category:Programming_principles)

## Rationale

- Ensure consistency across coding standards for different languages

## Standards

### All code is open

Whilst we acknowledge that there are cases where it may be necessary for code to not be open, this standard ensures that those cases are managed as exceptions.

### All coding is done on a branch

No code changes are made directly to the main branch.

This reflects the 'golden' state of the branch and mirrors the general standard that changes are never made directly to production services.

### All code is checked for correct coding style

Language-dependent

### All branches have CI

Covering code style, security checking, dependency checking, build and unit tests.

### Unit test coverage is at least 90%

All changes must have sufficient coverage and the overall total coverage must not decrease.

### All code is reviewed

All code changes are reviewed by another developer before they are merged.

### All code is checked for readability

> There are only two hard things in Computer Science: cache invalidation and naming things.
>
> -- Phil Karlton

Avoid basic errors such as

- Generic variable names: `p`, `temp`, `v`
- Using arrays over hashes: `['Bob', 'Smith', 'Bristol']` over `{ name: 'Bob', surname: 'Smith', location: 'Bristol' }`
- Use of acronyms: particularly domain specific ones. Someone new to the service may not know their GOR from their WIMS

Other than that when considering the name for a method, class, module etc try not to approach it from what makes sense to you, but instead what best describes the intent of the thing, and what will help the person who comes after you.

Stick to the conventions and naming standards of the language or framework you are using.

Aim to write readable code that does not require comments.

Use the principle of **separate in order to name**. Essentially break your code down into small (and if necessary one line) sub routines that have names that express what their intent is. Read [Write readable code without comments](http://www.wikihow.com/Write-Readable-Code-Without-Comments) for more on how to do this.

If you have to add comments, make them useful

- **Comments are code** - Keep them small, simple and re-factor them as you make changes
- **Don't document the _how_** - Document *why* the thing is needed, or *why* its doing it the way it is
- **Comment in the right place** - Talk about the module at the module declaration, the subroutine at the method declaration etc
- **Only write about the code** - Don't include names, dates, commit comments or your opinions

Don't include commented out code. It's noise that only confuses. Use the commit history if you need to see what was there before.

And most importantly write them *as you write the code*. If you don't, you probably never will!

### All code is appropriately documented

Document the *how* for the project

When it comes to other developers or users of the project, the thing they are most interested in is the *how*. *How* can I build/deploy/run this project. *How* can I use it in my own work.

### All code is checked for simplicity

We don't code for reuse until we have a confirmed need for reuse.

We apply the [rule of three](https://en.wikipedia.org/wiki/Rule_of_three_(computer_programming)) to help decide when to abstract code.

We don't break up our applications until there is a confirmed need to do so.

The path to reuse starts with module/namespacing. When the need for reuse is confirmed we first build a package. Only if there is demand from multiple services, and the benefits for a deployed service over a shared package are clear do we build a new application.

### All code is checked for quality

All repos are connected to a quality analysis tool and the tool's maximum quality rating is maintained.

All repos on GitHub and Azure Repos are connected to our SonarCloud organisation and the Defra standard quality gate is met.

### All code is checked for security

All repos are connected to a security tool to monitor for vulnerabilities in the dependencies and static code vulnerabilities.

### All code has dependency checking

No out of date dependencies or libraries with known vulnerabilities.

### All code is licensed appropriately

The README on all repos must include an appropriate licence.

Include a licence file in your repo (following convention, spell this file LICENSE).

The default licence for all Defra code is the [Open Government Licence](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/). Any deviation should be agreed with the product owner (or suitable alternative stateholder) responsible for the code. The product owner may wish to seek guidance from the relevant legal team within their organisation.

Cases for using an alternative licence should result in efficiency of cost for the taxpayer and might include promoting wider adoption of the code or ensuring compliance with other licences. Follow the National Archives [guidance about alternative open software licences](http://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/open-government-licence/open-software-licences/).

## Status

This standard was formally adopted on 1 July 2019.

Amended to add standard on code licencing in April 2025.

## Significant changes

SonarCloud was adopted as our standard quality analysis tool on 1 April 2020.
