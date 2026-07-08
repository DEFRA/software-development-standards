# Cookie banner

An example repository has been created to correctly implement the GOV.UK Design System cookie banner with Google Tag Manager (GTM).

This demonstrates how to address the common pain points teams encounter when implementing a cookie banner, including:

- Immediately setting GA cookies on acceptance - GTM loads client-side the moment the user accepts, no page reload required for GA to start collecting
- Removing all GA cookies when the user rejects - from both the banner and the cookie preferences page
- Working without JavaScript - progressive enhancement via form submission
- Working with Content Security Policy (CSP) - nonces and domain whitelisting
- CSRF protection - on all cookie consent forms

[https://github.com/DEFRA/cookie-banner-example](https://github.com/DEFRA/cookie-banner-example)
