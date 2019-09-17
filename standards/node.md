## Draft Node.js Standards

### General
* Node.js code is JS code and should follow the [JS standards](javascript.md)
* Session state should not be stored on the node app server. Don't tie a session to a particular node server instance. Usie a distributed cache or document storage database and not something like express-session. 
* Avoid blocking the [main event loop and the worker pool](https://nodejs.org/en/docs/guides/dont-block-the-event-loop/). In short "you shouldn't do too much work for any client in any single callback or task." and consider passing CPU intensive tasks off to another service.
* Prefer await over callbacks and avoid nested callbacks. This is easily done in [Node 8 and above](https://nodejs.org/api/util.html#util_util_promisify_original).

### Versions

* Be aware of the Node.js [support timeline](https://nodejs.org/en/about/releases).
* Keep on Active LTS (10.x at the time of writing).
* Don't drop behind Maintenance LTS (8.x at the time of writing).
* Don't progress beyond Active LTS.

### Package Management
* Use NPM.
* Use a package.json and package-lock.json for repeatable builds.
* Use either a vulnerability scanner such as GreenKeeper or an update tool such as dependabot.
* Separate dependencies and dev dependencies.
* Update your version number inline with the [semantic versioning standard](https://semver.org/).

### Server framework
* Our standard framework is currently [Hapi](https://hapijs.com/).
* Our current standard version is Hapi 18.
* At a minimum projects should be running Hapi 16.

### Security
* Use HTTPS.
* Validate inputs on the server, [even when you are performing validation on the client](https://stackoverflow.com/questions/15855770/why-do-we-need-both-client-side-and-server-side-validation#15855799).
* Understand your [cookie flags](https://techblog.topdesk.com/security/cookie-security/). Use secure cookie, use HTTP only when appropriate and consider the use of samesite.
* Be careful when using Cookies for authentication. Consider switching to another method or implementing additional security features such as a XSRF token submitted via a header or hidden field. Be aware that it isn't just POST and PUT endpoints that may be vulnerable to XSRF.
* For more guidance see the OWASP [cheat sheets](https://github.com/OWASP/CheatSheetSeries).
* Avoid publishing sensitive API keys in your code. Use environment variable sourced from a separate private repo.
* Use either a vulnerability scanner such as [GreenKeeper](https://greenkeeper.io/) or an update tool such as (dependabot)[https://dependabot.com/].

