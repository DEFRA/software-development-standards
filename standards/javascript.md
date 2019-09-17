## Draft JavaScript Standards

### General
*  Use [Standard JS](https://standardjs.com/) to lint your code. A conistent approach to code layout, spacing and formatting to code makes it easier to switch between projects. By [adding it as a dev dependency](https://standardjs.com/index.html#install) it can be easily used in the terminal, [Webstorm](https://blog.jetbrains.com/webstorm/2017/04/using-javascript-standard-style/), and [Visual Studio](https://marketplace.visualstudio.com/items?itemName=chenxsan.vscode-standardjs).
* Test your code for compatibility with your target browsers using a tool such as [Browserstack](https://www.browserstack.com/?utm_medium=ppc&utm_source=bing&utm_term=browserstack&device=c&network=s&matchtype=e&campaign=Search-Brand-EMEA&utm_agn=BrowserStack-Alpha).
* Don't pollute the global state . I.e. Take steps such as using a build tool to combine related files or, at a minimum [write to window.somenamespace.x rather than window.x](https://www.zendesk.com/blog/keep-javascript-libraries-from-colliding/).
* Think about how you will collect information about errors on the client and consider the use of a tool such as [airbrake-js](https://github.com/airbrake/airbrake-js).

### Security
* Understand and mitigate the risks of XSS and XSI attacks on your service. See the OWASP [cheat sheets](https://github.com/OWASP/CheatSheetSeries) for an introduction to these issues.
* Protect against XSS attacks by ensuring that you encode inputs to your service on both the client and server. You should also perform additional validation on incoming parameters where necessary. Depending on the library you are using you may need to JS encode and HTML encode to do this.
* Validate inputs on the [client and the server](https://stackoverflow.com/questions/15855770/why-do-we-need-both-client-side-and-server-side-validation#15855799).
