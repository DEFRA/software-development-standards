# Selecting packages and dependencies

We use a lot of packages and dependencies in our services. Using an established package can be a great way to fix a problem or add a feature. It can be quicker and easier than writing the code from scratch. And it can make your application more consistent with other Defra services and industry standards.

When you are picking a package or a dependency to include in your project, there are some things to consider:

## What have other Defra services used?

Is there an agreed-upon standard package for this purpose? If there is, use it.

For example, Hapi is our Node.js framework of choice. So if you're starting a new Node project and need a web framework, use Hapi over alternatives like Express.

If there's no official standard, you should still consider what similar services use. Codebases can be more consistent and easier to maintain if they use the same packages.

It can also be quicker to introduce an already-used package to your project. You can reuse code from our other services, or learn from developers who have worked with it.

## What are the most popular solutions?

If you're looking for a package for a common function (like logging or user authentication), there may be many potential candidates.

When in doubt, go for the most used package, especially if it's become the industry standard.

You can compare how popular packages are by looking at the number of downloads they have on package manager sites (like [NPM](https://www.npmjs.com/) or [RubyGems](https://rubygems.org/)). You can also check how many times the repository has been watched or starred on GitHub.

A well-established package will usually have a lot more guidance and support. There will be more blog posts, more questions on Stack Overflow, and other projects you can refer to.

It also makes it easier to introduce new developers to your service, as it's more likely they'll be familiar with an industry standard.

This isn't a hard rule. If the most popular package doesn't meet your needs, or has clear issues with security or maintainability, then it's OK to go for an alternative. But if you're choosing between one package with a thousand downloads and another with a million downloads, you should go for the second one.

## Is the package maintained?

Check the package history. How often is it updated? Who is updating it?

Poorly maintained packages are more likely to have security problems. They may not be upgraded to work with newer versions of your language, framework and other dependencies.

A package with a single maintainer is also a much riskier choice than one managed by a team.

If the package has a GitHub issues section, or a forum, check if the maintainers respond to problems. If reported issues never get fixed, then it's time to consider alternatives.

## Is the package secure?

Check the package history. Is there evidence that the maintainers have applied security fixes? Do they regularly update their dependencies?

Many GitHub repositories will have READMEs with badges for their security CI tools. Check to see if there are any warnings or known security issues.

## Is the package documented?

Is there a thorough README or a Wiki? It should be clear how you can install and configure the package, and how to use its features and API.

## Is the package compatible with our licence?

Our open source applications should use the [Open Government Licence](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/). So any packages they include should be compatible with this licence.

The National Archives has more [guidance about open software licences](http://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/open-government-licence/open-software-licences/).
