## Node.js standards

### General
- Node.js code is JavaScript code and should follow the [JavaScript standards](javascript_standards.md).
- Don't use TypeScript without an approved exemption.
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
- Use npm.
- Use a package.json and package-lock.json for repeatable builds.
- Use `npm ci` instead of `npm install` in automated production builds to ensure  the exact versions in `package-lock.json` are installed.  It will also fail if the `package-lock.json` and `package.json` are out of sync, which can help catch mistakes.
- Use an automated checker such as Dependabot or npm audit to ensure that your dependencies are up to date with the
  latest patches.
- Separate dependencies and dev dependencies.
- Update your version number inline with the [semantic versioning standard](https://semver.org/).
- Vet third-party packages before adding them as dependencies by following this [guide](../guides/choosing_packages.md).

#### .npmrc security settings

Create an `.npmrc` file at the root of each repository with the following settings:

```ini
save-exact=true
ignore-scripts=true
min-release-age=7
```

| Setting | Purpose |
|---|---|
| `save-exact=true` | Saves exact dependency versions rather than version ranges. Prevents version-range drift from silently pulling in a later, potentially vulnerable release. |
| `ignore-scripts=true` | Prevents npm from running lifecycle scripts such as `preinstall` and `postinstall` during package installation. This blocks a common vector for arbitrary code execution from malicious or compromised packages. Note: some packages that compile native bindings require lifecycle scripts to function. If any packages genuinely need it, then `--ignore-scripts=false` can be passed to the relevant `npm install` command. |
| `min-release-age=7` | Refuses to install packages published fewer than 7 days ago. This provides a window to detect package takeover or typosquatting attacks before they reach your codebase. Studies have shown that most malicious packages are detected within this timeframe. |

To apply these settings globally across all projects on your machine, run the following commands to ensure you are protected from any repository you interact with, even if you don't own it.

```sh
npm config set save-exact=true
npm config set ignore-scripts=true
npm config set min-release-age=7
```

Or add the three lines directly to your global npm configuration file at `~/.npmrc`.

### Server framework
- Our standard framework is [Hapi](https://hapijs.com/).
- Be aware of the [Hapi support timeline](https://hapi.dev/support/#plans).
- Keep on the current major Hapi version.
- Don't drop behind the lowest version available through Hapi commercial support. Projects older than this will be
  considered unmaintainable and unsupportable until brought up to an appropriate version.

### CommonJS vs ES modules
- ES modules should be used by default over CommonJS modules.
- For scenarios where ES modules are not appropriate then CommonJS may be used.

> Note: Some Node.js packages such as [Jest](https://jestjs.io/) are not fully compatible with ES modules and it may be more pragmatic to use CommonJS.

### Status

This standard was formally adopted on 8 January 2020.

### Significant changes

Clarification on preference between CommonJS and ESM added 29 July 2024.
Add .npmrc security settings added 1 May 2026.
