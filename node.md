## Draft Node.js Guidelines

### General
* Use [Standard JS](https://standardjs.com/) to lint your code. A conistent approach to code layout, spacing and formatting to code makes it easier to switch between projects. By [adding it as a dev dependency](https://standardjs.com/index.html#install) it can be easily used in the terminal, [Webstorm](https://blog.jetbrains.com/webstorm/2017/04/using-javascript-standard-style/), and [Visual Studio](https://marketplace.visualstudio.com/items?itemName=chenxsan.vscode-standardjs).
* Session state should not be stored on the node app server
* Avoid blocking the [main event loop and the worker pool](https://nodejs.org/en/docs/guides/dont-block-the-event-loop/). In short "you shouldn't do too much work for any client in any single callback or task." and consider passing CPU intensive tasks off to another service.
* Prefer await over callbacks and avoid nested callbacks. This is easily done in [Node 8 and above](https://nodejs.org/api/util.html#util_util_promisify_original).

### Versions

* Be aware of the Node.js [support timeline](https://nodejs.org/en/about/releases).
* Aim to keep on Active LTS (10.x at the time of writing).
* Don't drop behind Maintenance LTS (8.x at the time of writing).
* Don't progress beyond Active LTS.

### Package Management
* Use NPM.
* Use a package.json and package-lock.json for repeatable builds.
* Use either a vulnerability scanner such as GreenKeeper or an update tool such as dependabot.
* Separate dependencies and dev dependencies.
* Update your version number inline with the [semantic versioning standard](https://semver.org/).

### Server framework
* Our preferred framework is currently [Hapi](https://hapijs.com/).
* As a minimum projects using Hapi should aim to be using Hapi 16 or higher.

### HTTP
* Make use of standard http operations e.g. post for create, get for read, put for update, delete for delete.
* Make use of HTTP codes e.g. 1xx informational, 2xx success, 3xx redirection, 4xx client errors, 5xx server errors.

### Security
* Use HTTPS.
* Validate inputs on the server, [even when you are performing validation on the client](https://stackoverflow.com/questions/15855770/why-do-we-need-both-client-side-and-server-side-validation#15855799).
* Understand your [cookie flags](https://techblog.topdesk.com/security/cookie-security/). Use secure cookie, use HTTP only when appropriate and consider the use of samesite.
* Be careful when using Cookies for authentication. Consider switching to another method or implementing additional security features such as a XSRF token submitted via a header or hidden field. Be aware that it isn't just POST and PUT endpoints that may be vulnerable to XSRF.
* For more guidance see the OWASP [cheat sheets](https://github.com/OWASP/CheatSheetSeries).
* Avoid publishing sensitive API keys in your code. Use environment variable sourced from a separate private repo.
* Use either a vulnerability scanner such as [GreenKeeper](https://greenkeeper.io/) or an update tool such as (dependabot)[https://dependabot.com/].

