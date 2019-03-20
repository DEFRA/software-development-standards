# Selecting packages and dependencies

We use a lot of packages and dependencies in our services. If you have a problem to solve or a feature to implement, it can often be easier to use an established package than to hand-crank your own solution - provided that package meets certain criteria.

When you are picking a package or a dependency to include in your project, there are a number of things to consider:

## What have other Defra services used?

Is there an agreed-upon standard package for this purpose? If there is, use it.

For example, Hapi is our Node.js framework of choice. So if you're starting a new Node project and need a web framework, you should use Hapi over alternatives like Express.

Even if there's no official standard, you should still consider what similar services have used in the past. Using the same packages across services makes our codebases more consistent and easier to maintain. You may also find it quicker to put the package into use because you can reuse code from our other services, or talk to developers who already know how to use it.

## What are the most popular solutions?

If you're looking for a package which performs a common function (like logging or user authentication), there will probably be a lot of packages that could meet your needs.

When in doubt, go for the most commonly used package, especially if it's so popular as to become the industry standard.

A well-established package will usually have a lot more guidance and support. There will be more blog posts, more questions on Stack Overflow, and other projects you can refer to.

If a package is an industry standard, it will also make it easier to introduce new developers to your service, as it's more likely they'll be familiar with it.

This isn't a hard rule - if the most popular package doesn't meet your needs, or has clear issues with security or maintainability, then it's OK to go for an alternative. But if you're choosing between one package with a thousand downloads and another with a million downloads, you should probably go for the second one.

## Is the package maintained?

Check the package history. How often is it updated? Who is updating it?

Poorly maintained packages are more likely to have security problems, or may not be upgraded to work with newer versions of your language, framework and other dependencies.

A package with a single maintainer is also a much riskier choice than one which is managed by a team.

If the package has a GitHub issues section, or a forum, have a look to see if the maintainers are responding to problems. If reported issues never get fixed, or even responded to, then it's probably time to consider alternatives.

## Is the package secure?

Check the package history. Is there evidence that the maintainers have applied security fixes, or regularly updated their dependencies?

Many GitHub repositories will have badges in their READMEs showing any security CI tools. Check to see if there are any warnings or known security issues.

## Is the package documented?

Is there a thorough README or a Wiki? It should be clear how you can install and configure the package, and how to use its features and API.

## Is the package compatible with our licence?

Our open source applications should use the [Open Government Licence](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/). So any packages they include should be compatible with this licence.
