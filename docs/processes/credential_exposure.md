# Credential exposure

Credentials are things like passwords or API keys. They are any values you wouldn't want exposed to the public but which your app or service needs to do its job.

We haven't settled on a specific standard for how we handle them e.g. [12 factor app](https://12factor.net/config). But the one thing we are all agreed on is that they should not be committed with your project's source code.

Yet mistakes happen and sometimes these secrets become exposed.

This process will take you through what to do if that happens. The key point is

> once out *always* consider your secret as compromised

No matter the speed with which you rectify the situation, or how little you think the chance is for people to see it. Treat it as compromised.

## Contact operations

The first step is to make contact with the team responsible for your production environment.

For example if your service is hosted in AWS, you should call someone from the AWS web-ops team ([David Blackburn](https://github.com/davidblackburn) or [Tom Tant](https://github.com/TTEA1990)).

We cannot post contact numbers here. But they are available using our internal systems.

Follow this up with an email that contains a link to the commit, and explains what was exposed.

## Fix your git

Next is fix your git tree. This involves removing the offending commit from your git history.

### On a branch

If the commit was on a branch the fix involves amending or removing the commit. You can use git commands such as `git commit --amend` or `git rebase -i` to amend the current branches history.

You will then follow this with a `git push -f`.

### On master

If it was the last commit on master, you can get away a `git commit --amend` and a `git push -f` if you have the rights.

Else you will need to follow a much more involved strategy. GitHub provide a [guide](https://help.github.com/en/github/authenticating-to-github/removing-sensitive-data-from-a-repository). If you are unsure contact the development community or speak to our principal developers.

## Remove caches

To quote GitHub's guide

> [..] *it's important to note that those commits may still be accessible in any clones or forks of your repository, directly via their SHA-1 hashes in cached views on GitHub, and through any pull requests that reference them.*

If someone manages to fork or update their fork before you push your fix there is little you can do. Try to reach out to them to explain the situtation, and ask them to update their fork.

### GitHub

You can get the cache of your commit removed by contacting [GitHub support](https://support.github.com/contact). As long as what you need removed meets GitHub's [criteria for sensitive data](https://help.github.com/en/github/site-policy/github-sensitive-data-removal-policy#what-is-sensitive-data) there will not be a problem.

The [Ruby services team](https://github.com/DEFRA/ruby-services-team) report a turn around of less than an hour when they made this request.

Inform the relevant operations team once the request is processed.
