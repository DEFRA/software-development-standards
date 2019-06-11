# Version control standards

These standards define how version control is applied to our code.

Wherever possible these standards follow built-in versioning facilities for the languages, tools or frameworks we are using.

## Rationale

- Underpins a consistent, robust and repeatable release strategy
- Ensures that we can have reliable dependency management between components even if they use different technologies

## Standards

### All code is held in a centrally managed Git repository

The primary repository is in the Defra GitHub organisation.

Azure DevOps Git or hosted GitLab may be used to provide mirrors of GitHub repositories.

### Every repository has a protected master branch with required status checks and approving reviews

This ensures that no change can be directly applied to production without appropriate test and review.

### All releases are tagged in the version control system before deployment

This enables easy identification of the specific commits that form a release and a simple way for developers to checkout the code for a specific release for fault analysis purposes.

### All releases have their version number included in the source code

All releases must include a commit that updates the version number (language dependent) in the source code. This ensures that the correct version can be identified in any published code.

### Releases use semantic versioning

Apply [semantic versioning](https://semver.org/) when choosing a tag
