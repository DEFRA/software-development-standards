# Using Ordnance Survey APIs

Ordnance Survey (OS) publishes address, place name and mapping data through the [OS Data Hub](https://osdatahub.os.uk/). Defra services normally access this data under the [Public Sector Geospatial Agreement (PSGA)](https://www.ordnancesurvey.co.uk/customers/public-sector/public-sector-geospatial-agreement), which gives public sector organisations access to both open and premium OS data.

Some of that data is premium and licensed. If your service leaks a credential that can reach a premium API, someone can harvest a licensed dataset at Defra's expense. This guide explains how to choose the right API, how to get a key, and how to build your service so that this cannot happen.

## Choosing an API

| API | Data source | Licence | Typical use |
| --- | --- | --- | --- |
| [OS Places](https://docs.os.uk/os-apis/accessing-os-apis/os-places-api) | AddressBase Premium | Premium | Address lookup, postcode and UPRN search, geocoding and reverse geocoding |
| [OS Names](https://docs.os.uk/os-apis/accessing-os-apis/os-names-api) | OS Open Names | Open Government Licence | Finding towns, roads, postcodes and named places |
| [OS Maps](https://docs.os.uk/os-apis/accessing-os-apis/os-maps-api) | Mixed open and premium layers | Mixed | Pre-rendered raster basemap tiles |
| [OS Vector Tile](https://docs.os.uk/os-apis/accessing-os-apis/os-vector-tile-api) | Mixed open and premium layers | Mixed | Customisable vector basemap tiles |

Use the least sensitive API that meets your need. If you only need to find a town, a road or a postcode, OS Names is open data and is a much safer choice than OS Places.

OS Places is the one to treat with most care. It is built on AddressBase Premium, it is updated daily, and it is the most valuable dataset to an attacker.

The OS Vector Tile API is expected to reach end of life in Autumn 2028. New services should use [OS NGD API – Tiles](https://docs.os.uk/os-apis/accessing-os-apis/os-ngd-api-tiles) instead.

## Getting access

Check whether your organisation is already a PSGA member using the [PSGA member finder](https://www.ordnancesurvey.co.uk/customers/public-sector/psga-member-finder).

Request API keys through your arm's length body's OS Data Hub account owner, usually its geospatial or data team. Keys must belong to the organisation's Data Hub account.

Do not sign up for a personal or team OS Data Hub account to get a key for a Defra service. Keys obtained that way have no licensing cover for the service, no usage oversight, and are lost when the person who created them moves on.

Record in your service runbook who owns the Data Hub account, who can rotate the key, and which API projects your service uses.

## Separating API projects

A key belongs to an [API project](https://docs.os.uk/os-apis/core-concepts/getting-started-with-an-api-project) in the Data Hub, and a project can contain several APIs.

This matters more than it first appears. OS access tokens are scoped to the project, not to an individual API. As the OS documentation notes, you cannot restrict which data layers can be accessed using an access token, and once an end user holds a token you can no longer monitor or control how they use it.

**The set of APIs in a project is your blast radius.** A project containing both OS Maps and OS Places will issue tokens that can call OS Places, no matter what your application intended them for.

So:

- Create a separate project for each trust tier. Never put OS Places in the same project as an API whose credential is used in the browser.
- Add only the APIs a project actually needs.
- Use separate projects for live and non-live environments, so a key exposed in a test service can be revoked without taking production down.

## Protecting keys and tokens

Treat OS API keys and secrets like any other application credential. Store them in a cloud secret store and read them from there, as described in [Managing application credentials](application_credentials.md).

Never put a key or secret in client-side JavaScript, a mobile app bundle, source control, configuration served to the browser, or build logs. The OS documentation is explicit that the user's browser is not a trusted environment and that project API keys should not be embedded in application code.

If a key is exposed, follow the [credential exposure process](../processes/credential_exposure.md). Regenerate the key in the Data Hub first, then report it.

### Use a proxy

The default pattern for calling OS APIs is a server-side proxy. The browser calls your backend, and your backend adds the credential and calls OS.

```text
Browser  ──►  Your backend  ──►  OS API
              (adds key or short-lived token)
```

Your backend should:

- check the caller is entitled to make the request
- validate the request against an allow list of permitted operations and parameters
- cap the number of results per request and reject bulk or wildcard queries
- rate limit per user or session
- return only the fields your interface needs, rather than the whole record
- log and monitor usage

Do not build a transparent pass-through that forwards whatever query string it receives. That gives an attacker the same capability as a leaked key, just with an extra hop.

### If a credential has to reach the browser

Sometimes it is impractical to proxy every request, most often for map tiles. In that case:

- expose a credential only for open data APIs, and only for a project that contains exactly the APIs the browser needs, such as tiles only or OS Names only
- prefer a short-lived [OAuth 2](https://docs.os.uk/os-apis/accessing-os-apis/oauth-2-api) access token, minted by your backend, over a long-lived project API key
- accept that the project scope is the limit of your control, and size the project accordingly

## Protecting premium data

Premium data needs protecting from harvesting as well as from key theft. A proxy that anyone can call without limit is still a route to bulk extraction.

### Services behind a login

Put premium lookups behind the service's existing user authentication. Apply per-user rate limits and alert on users whose query volume looks automated rather than human.

### Public services

If a public service without a login consumes premium data, it must take active steps to stop the data being scraped. This is where a recent internal review of a Defra service found a problem: a credential capable of calling OS Places was available in the browser, so premium address data could have been harvested directly.

As a baseline:

- Put a low-friction or invisible captcha in front of the lookup (eg [Friendly Captcha](https://friendlycaptcha.com/)). It should be verified server-side and exchange for a short-lived session token held by your backend.
- Rate limit per session and per source address, and set a global daily ceiling with alerting when it is approached.
- Require a minimum query length and reject enumeration patterns, such as single-character searches or sequential postcode walking.
- Return only the fields the interface needs.
- Use edge bot protection or a web application firewall, and watch for slow distributed scraping that stays under individual limits.

Before adding any of this, ask whether the service actually needs premium data. OS Names or a postcode-only lookup is often enough, and carries none of this overhead.

## Licensing and attribution

Your use of OS data is governed by the PSGA terms. Check them before caching, storing or passing OS responses on to anyone else, as the rules differ between open and premium products.

Display the OS attribution required for the products you use on maps and on outputs derived from them. Open data served through OS Names comes from OS Open Names under the Open Government Licence and still requires attribution.

## Monitoring and rotation

Review the usage dashboards in the OS Data Hub regularly and set up alerts for step changes in premium transactions. A sudden rise in OS Places calls is often the first sign that a credential has been misused.

Rotate keys periodically and whenever someone with access to them leaves the team. Write the rotation steps into your runbook and practise them, so that rotating a key during an incident is routine rather than risky.

## Before you go live

- Premium APIs are reached only through your backend, never directly from the browser.
- The API project used by any browser-exposed credential contains open data APIs only.
- Live and non-live environments use different projects and keys.
- Keys come from your organisation's Data Hub account and are held in a secret store.
- Your proxy validates and rate limits requests rather than passing them through.
- A public service using premium data has bot protection and throttling in place.
- Usage alerting is configured and the runbook names a key owner and rotation steps.

## Further reading

- [Introduction to OS APIs](https://docs.os.uk/os-apis)
- [Authenticating OS API requests](https://docs.os.uk/os-apis/core-concepts/authentication)
- [OS OAuth 2 API](https://docs.os.uk/os-apis/accessing-os-apis/oauth-2-api)
- [Public Sector Geospatial Agreement](https://www.ordnancesurvey.co.uk/customers/public-sector/public-sector-geospatial-agreement)
- [Ordnance Survey on GitHub](https://github.com/OrdnanceSurvey)
- [Security standards](../standards/security_standards.md)
