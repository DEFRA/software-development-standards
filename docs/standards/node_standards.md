## Node.js standards

### General
- Node.js code is JS code and should follow the [JavaScript standards](javascript_standards.md)
- Session state should not be stored on the node app server. Don't tie a session to a particular node server instance. Use a distributed cache or document storage database and not something like express-session. 
- Avoid blocking the [main event loop and the worker pool](https://nodejs.org/en/docs/guides/dont-block-the-event-loop/). In short "you shouldn't do too much work for any client in any single callback or task." and consider passing CPU intensive tasks off to another service.
- Prefer await over callbacks and avoid nested callbacks. This is easily done in [Node 8 and above](https://nodejs.org/api/util.html#util_util_promisify_original).

### Versions

- Be aware of the [Node.js support timeline](https://nodejs.org/en/about/releases).
- Keep on Active LTS versions.
- Don't drop behind Maintenance LTS versions. Projects older than this will be considered unmaintainable and
  unsupportable until brought up to an appropriate version.
- Don't progress beyond Active LTS versions.

### Package Management
- Use NPM.
- Use a package.json and package-lock.json for repeatable builds.
- Use an automated checker such as GreenKeeper or Dependabot to ensure that your dependencies are up to date with the
  latest patches.
- Separate dependencies and dev dependencies.
- Update your version number inline with the [semantic versioning standard](https://semver.org/).

### Server framework
- Our standard framework is [Hapi](https://hapijs.com/).
- Be aware of the [Hapi support timeline](https://hapi.dev/support/#plans).
- Keep on the current major Hapi version.
- Don't drop behind the lowest version available through Hapi commercial support. Projects older than this will be
  considered unmaintainable and unsupportable until brought up to an appropriate version.

### CommonJS vs ES modules
- ES modules should be used by default over CommonJS modules
- For scenarios where ES modules are not appropriate then CommonJS may be used

> Note: Some Node.js packages such as [Jest](https://jestjs.io/) are not fully compatible with ES modules and it may be more pragmatic to use CommonJS.

### Status

This standard was formally adopted on 8 January 2020.

### Significant changes

Clarification on preference between CommonJS and ESM added 29 July 2024.
