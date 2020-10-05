# RESTful API Standards
This document defines the standards to be followed when implementing RESTful APIs.

## Introduction
This document defines the standards to be followed when implementing RESTful APIs.

 > TBC - something about the purpose of these standards?  Is this necessary or just a waste of the reader's time?

## Design Principles
This section provides the design principles to be applied when building RESTful APIs.  They are presented broadly in
order of importance.

### Principle 1 - User Need
Service APIs will be designed around a proper understanding of the user need.  Specifically, there is an explicit
distinction made between public Open Data services, services where the user needs to transact with Government directly
and services that support re-use.

This document will refer to four different types, or levels, of service API:

* Level 1 - Entity Services.
    These provide a simple Create-Read-Update-Delete API over a data persistence mechanism or third-party service and
    are implemented where appropriate to provide decoupling and technology-independence.

* Level 2 - Business Services.
    These provide actual business logic, potentially encapsulating and aggregating a number of Level 1 services.
    Such services will be implemented where there is identified re-usable business logic.

* Level 3 - Open Services.
    These are similar to Level 2 services but are specifically intended for direct public transaction with Government.
    As such, they will have very different security characteristics and may aggregate several Level 2 services so as to
    present simpler or more controlled interfaces.

* Level 4 - Open Data.
    These are truly open services, providing unrestricted access to Open Data in support of the Government's openness
    agenda.

It should be noted that none of these levels of service API are mandatory - best-practice architectural blueprints
should be followed, and APIs implemented where they provide best value.

Benefits:

 - Services will be tailored appropriately for their intended use rather
   than putting blockers in the way of adoption due to slavish adherence
   to technical design standards (such as this document).

Implications:

 - This directly opposes the consistency principle, so the standards
   outlined in this document specifically account for different styles
   of implementation so as to provide consistency without uniformity.

### Principle 2 - Open Services
Services will be as open as possible by default.

Benefits:

 - Adoption and use of the APIs is maximised.

Implications:

 - The information security requirements of the service must be properly understood.
 - User needs must clearly articulate the balance between openness and security.
 - Additional effort will be required in order to make services more open.

### Principle 3 - Secure
Services will be precisely as secure as necessary and will use industry standard security mechanism and protocols.

Benefits:

 - Adoption and use of the APIs is maximised.

Implications:

 - The information security requirements of the service must be properly understood.

### Principle 4 - RESTful
Services will be RESTful, not REST-ish.  Specifically, correct use of hypermedia is an essential part of the service
implementation.

Whilst there is much debate about what constitutes "true" REST, "pragmatic REST" versus "RESTafarianism" and the like,
following core RESTful principles rather than diverging into implementation-specific approaches and the need for
significant "out of band" information delivers the key robustness and maintainability that a RESTful architecture
promises.

The only cases where divergence from core standards would be appropriate are where:

 - The relevant specifications have gaps or insufficient detail, for example non-standard media types.
 - There are known technical issues where the specification has not been fully implemented, for example where
   particularly stringent firewalls do not permit PUT or DELETE operations.

In these cases, solutions should be implemented that do not conflict with core standards until such time as the
specifications are enhanced or the technical issues are resolved.

Benefits:

 - Services are easier to maintain over the long term.

Implications:

 - Services require more implementation effort in the short term.

### Principle 5 - Consistent
Services will be consistent in their implementation.  This is, essentially, the purpose of this standards document and
forms the basis for the remaining principles.

Benefits:

 - Adoption and use of the APIs is maximised.
 - Services are easier to maintain over the long term.

Implications:

 - Services require more implementation effort in the short term.

## Design Standards

### Standard 0 - Start with Best Practice Standards
Read this document:

https://github.com/tfredrich/RestApiTutorial.com/raw/master/media/RESTful%20Best%20Practices-v1_2.pdf

As it is principally a catalogue of current industry practice, it is almost exactly what our technical standards
should be.  There are some areas of difference, however, particularly where the industry remains divided in terms
of *best* practice.

### Standard 1 - Authentication
Level 4 Open Data services must not require authentication or identification of any sort, whereas Level 3 Open Services
must require exactly one of shared token or user-principal authentication, depending on the identified user need.

Level 1 and 2 services, being inherently private, will have implicit trust relationships with their clients so no
authentication is required.

It is essential that any API that has no such implicit trust arrangement implements a Level 3 Open Service with all the
necessary security controls.

### Standard 2 - Identification
Where actor identification is required, this will be in line with standard Government identification mechanisms.
In practice, this means the use of email addresses for unverified identities and use of the Government Verify service
where verification is required.

>Details TBD

### Standard 3 - OAuth 2.0
See https://tools.ietf.org/html/rfc6749

Secured APIs take the role of an OAuth 2.0 Resource Server and mandate the use of the **Authorization** header with
a **Bearer** token (see https://tools.ietf.org/html/rfc6750 and http://self-issued.info/docs/draft-ietf-oauth-v2-bearer.html).

> Further details TBD - what are we doing about client authentication, beyond Verify?

### Standard 4 - API Keys

> Details TBD - how can API keys be securely managed?  How do we use API keys on non-secured resources?

### Standard 5 - Naming
To avoid coupling API implementation with technology constraints, API names will appear as the root in the URI path
rather than necessarily as a domain name, i.e.:

> http://api.gov.uk/permitservice

rather than

> http://permitservice.gov.uk

Use of domain names, however, is still encouraged for technical reasons such as avoidance of unnecessary redirects.
This standard simply means that the API name must *also* appear in the path.

So, the following are all acceptable:

> http://api.gov.uk/permitservice
> http://permitservice.gov.uk/permitservice
> http://permitservice.gov.uk/applicationservice
> http://permitservice.gov.uk/renewalservice

### Standard 6 - Versioning
Level 2 Business Services and Level 3 Open Services will provide versioned URIs, whereas Level 1 Entity Services and
Level 4 Open Data will not.

This is to distinguish between simply accessing resources and performing modification operations on resources,
which have different implications for breaking changes.  The robustness of the Web, as underpinned by its RESTful
nature, has largely come about due to the flexibility of clients being able to handle varying content rather than
servers being forced to process unacceptable content.

Versioned APIs will use the path under the API root:

> http://api.gov.uk/permitservice/v1
> http://permitservice.gov.uk/permitservice/v1
> http://permitservice.gov.uk/renewalservice/v1

and will, additionally, provide a redirect from an unversioned request to the latest version, allowing for clients that
may be unaffected by changes to continue working.

HATEOAS hypermedia references will always refer to versioned endpoints.

In addition a **_version** query parameter will be supported so as to enable a client to select an initial version.

As an example, assuming that v2 is the current version of an API, all the following requests would eventually resolve
into the same resource:

> http://permitservice.gov.uk/renewalservice/permits/1234
> http://permitservice.gov.uk/renewalservice/v2/permits/1234
> http://permitservice.gov.uk/renewalservice/permits/1234?_version=v2

Note that this approach directly contradicts the latest best practice document, which instead recommends versioning
resources through the use of content types.  (Which is wrong in so many ways.)

 > TODO: Should Open Data APIs also look to implement support for the _version parameter?  Arguably a significant
 > breaking change on one of these APIs should result in a new URI with a new name as it's no longer the same type of
 > resource?

 > TODO: What about indicating the version number to the client, either in resource metadata or headers?  Is there any
 > value in this?  It might be useful for the Open Data APIs if they were to support the _version parameter and for
> consistency you'd want to have it in the transactional APIs as well.

Digression:

There is no *good* way of versioning RESTful APIs, ideally we would never have to do it and the unversioned approach
for Open Data APIs specified here makes that explicit.  This is particularly important where persistent URIs are
required, which is typically the case for read-only resources such as open data or Web pages.

Additionally, although it is inevitable that transactional APIs will change over time, every effort should be made to
ensure that changes are backwardly-compatible.  Where this is not possible, a full version change of the entire API is
the safest, simplest and most easily understood way of achieving this.

Having version numbers in parameterised content types is inappropriate unless custom vendor content-types are used and
the version number is genuinely an indication of the version of that content type.  However, using vendor-specific
content types such as **vnd/environmentagency.permit+json; version=1** would significantly undermine the usability of
the API, as clients would have no way of understanding these custom content types without out of band information.

/End digression

 > TODO: Ongoing support for multiple versions, transition periods, etc...  There may not be any standards in this
 > area, but perhaps some guidelines would be helpful?

 > Guidance Note: Adopt v1 at public beta, maintain n-2 versions.

### Standard 7 - HTTP Methods
HTTP methods will be correctly implemented and available according to the specification.

Open Data services will only support GET, HEAD and OPTIONS methods.

Transactional services will additionally support the DELETE method, with an indication through hypermedia where its use
is available.

POST and PUT methods will be supported in transactional services following the HTTP specification rather than an
erroneous convention of using POST for "create" and PUT for "update".

PATCH will be supported on particular resources as appropriate and its availability will be indicated by hypermedia.

 > TBC: This whole following section could well be removed - I'm not really convinced that it's actually necessary.
 > If remote clients are using TLS (which they will be) then I'm not sure that the infrastructure concerns apply.
 > The only case where TLS might not be used is for Open Data APIs, which will only use GET anyway.

Allowance will be made for environments where firewalls, proxies and similar infrastructure may limit the set of
available HTTP methods, by supporting an override header **X-HTTP-Method-Override** and a request parameter **_method**
when the POST method is used, but primacy will always sit with the specification so that a PUT/PATCH/DELETE method
will always perform the expected operation.

|HTTP Method|X-HTTP-Method-Override Header|_method Parameter|Actual Method|
|-----------|-----------------------------|-----------------|-------------|
|PUT        | Any value                   |Any value        |PUT          |
|PATCH      | Any value                   |Any value        |PATCH        |
|DELETE     | Any value                   |Any value        |DELETE       |
|POST       | Not present                 |Not present      |POST         |
|POST       | Any value                   |POST             |POST         |
|POST       | Any value                   |PUT              |PUT          |
|POST       | Any value                   |PATCH            |PATCH        |
|POST       | Any value                   |DELETE           |DELETE       |
|POST       | POST                        |Any other value  |POST         |
|POST       | PUT                         |Any other value  |PUT          |
|POST       | PATCH                       |Any other value  |PATCH        |
|POST       | DELETE                      |Any other value  |DELETE       |
|POST       | Any other value             |Any other value  |POST         |



### Standard 8 - Resource Identifiers
Resource identifiers will follow best practice naming conventions, compliant with Environment Agency data standards.

Resource identifiers for Open Data services will be persistent and specifically are expected to persist beyond
the *version* of the service.

Resource identifiers for transactional services may be transient between service versions.

 > TODO: Find the identifier standard! (Does it exist yet?)

Resource names will consistently use plural nouns.

### Standard 9 - Representations
Services will provide a default representation appropriate to the resource, which for APIs will always be JSON.

Services will provide alternative representations according to user need.

Specific representations will be requested using the HTTP standard, i.e. Accept header.

To support easy discovery and exploration of Level 3 Open Services and Level 4 Open Data APIs, an alternative to the
Accept header will be implemented using a custom **_format** query parameter, which should correspond to the
equivalent Accept header value.

So:
> http://permitservice.gov.uk/renewalservice/v1/permits/1234?_format=application/xml

NOT:
> http://permitservice.gov.uk/renewalservice/v1/permits/1234?_format=XML
> http://permitservice.gov.uk/renewalservice/v1/permits/1234.xml

Note that this approach directly contradicts the latest best practice document, which instead recommends providing a
file-extension-style format specifier.

The _format parameter is not a drop-in replacement for the Accept header, but is a request for a specific
representation.  If the service does not support the specified representation then it will return a JSON representation.

Where an Accept header indicates acceptance of multiple content types and no _format parameter is included in the
request, the service will attempt to provide a representation matching the stated preferences.  Where there is no
single preferred representation then the following priorities will be used:

 1. If a content type of application/json is one of the preferred options use this, otherwise
 2. If a content type of text/xml is one of the preferred options use this, otherwise
 3. Use the first available preferred option.

Note that there will be no interactive content-type "negotiation" for APIs - the client is assumed to need a specific
representation and these server rules are purely to provide a consistent response to varying client requests.

Benefits:

 - Clients can receive the most useful representation without worrying about content negotiation.
 - APIs can be easily adopted and investigated through the use of a standard browser.
 - There is no confusion between hypermedia links and representations.

Implications:

 - Data that already has an established non-JSON representation will need to be mapped to JSON.
 - Services will need to implement appropriate logic for content negotiation.
 - Clients will have to implement mechanisms to support content negotiation.

### Standard 10 - JSON
API services will always return and expect a single JSON object.

Where lists of values are required, these will be encapsulated inside a container object.

So, for example:

 > { "resultCount": 2, "results": [ { "name": "John" },{ "name": "Phil" } ] }

NOT:

> [ { "name": "John" }, { "name": "Phil" } ]

The content type for JSON representations will be:

> application/json

i.e. there will be no use of custom content types or novel parameters such as version numbers.

 > TODO: Is there any need to support Content-Language headers?

### Standard 11 - XML
XML should be considered a non-preferred representation and only provided where there is a demonstrable user need.

Where a specific XML representation is required from an API then this must be namespace and context free, in the manner
of a JSON representation.

The content type for XML representations will be:

> application/xml

i.e. there will be no use of custom content types or novel parameters such as version numbers or text encoding.
Additionally, this content type is preferred to "text/xml" so that specification of the character encoding is always
deferred to the XML document itself.

 > TODO: Is there any need to support Content-Language headers?

Where there is a clear user need for XML that is applied to a pre-defined namespace, i.e. out of band information,
then this will be included as embedded content within the non-namespaced document.

So, a document such as:

    <?xml version="1.0" encoding="UTF-8"?>
    <tns:FileUpload xmlns:tns="http://www.environment-agency.gov.uk/XMLSchemas/GOR/WaterQualityMultiReturn/01">
    	<tns:Source>CUSTOM</tns:Source>
    	<tns:Sample>
    		<tns:SampleType>C</tns:SampleType>
    		<tns:CustomerSamplePointName>BASS</tns:CustomerSamplePointName>
    		<tns:SampleDateTime>2009-04-01T15:01:00</tns:SampleDateTime>
    		<tns:PurposeTypeName>EM</tns:PurposeTypeName>
    		<tns:MaterialName>Treated Sewage Effluent</tns:MaterialName>
    		<tns:Mechanism>Spot</tns:Mechanism>
    		<tns:Measurement>
    			<tns:DeterminandName>pH</tns:DeterminandName>
    			<tns:ResultType>E</tns:ResultType>
    			<tns:ResultValue>7</tns:ResultValue>
    			<tns:ResultUnits>pH</tns:ResultUnits>
    		</tns:Measurement>
    		<tns:Measurement>
    			<tns:DeterminandName>BOD 5 Day ATU as O</tns:DeterminandName>
    			<tns:ResultType>E</tns:ResultType>
    			<tns:ResultValue>2345</tns:ResultValue>
    			<tns:ResultUnits>mg/l</tns:ResultUnits>
    		</tns:Measurement>
    	</tns:Sample>
    	<tns:Sample>
    		<tns:SampleType>C</tns:SampleType>
    		<tns:CustomerSamplePointName>BLEL</tns:CustomerSamplePointName>
    		<tns:SampleDateTime>2009-04-02T12:53:00</tns:SampleDateTime>
    		<tns:PurposeTypeName>EM</tns:PurposeTypeName>
    		<tns:MaterialName>Trade Effluent</tns:MaterialName>
    		<tns:Measurement>
    			<tns:DeterminandName>pH</tns:DeterminandName>
    			<tns:ResultType>E</tns:ResultType>
    			<tns:ResultValue>9.567</tns:ResultValue>
    			<tns:ResultUnits>pH</tns:ResultUnits>
    		</tns:Measurement>
    		<tns:Measurement>
    			<tns:DeterminandName>BOD 5 Day ATU as O</tns:DeterminandName>
    			<tns:ResultType>E</tns:ResultType>
    			<tns:ResultValue>26.4</tns:ResultValue>
    			<tns:ResultUnits>mg/l</tns:ResultUnits>
    		</tns:Measurement>
    	</tns:Sample>
    	<tns:RegulatedCustomerIdentifier>2</tns:RegulatedCustomerIdentifier>
    </tns:FileUpload>

Would be represented as:

    <?xml version="1.0" encoding="UTF-8"?>
    <WaterQualityMultiReturn>
      <DateTimeMade>2009-05-01T12:45:00Z</DateTimeMade>
      <ReturnBody>
        <tns:FileUpload xmlns:tns="http://www.environment-agency.gov.uk/XMLSchemas/GOR/WaterQualityMultiReturn/01">
        	<tns:Source>CUSTOM</tns:Source>
        	<tns:Sample>
        		<tns:SampleType>C</tns:SampleType>
        		<tns:CustomerSamplePointName>BASS</tns:CustomerSamplePointName>
        		<tns:SampleDateTime>2009-04-01T15:01:00</tns:SampleDateTime>
        		<tns:PurposeTypeName>EM</tns:PurposeTypeName>
        		<tns:MaterialName>Treated Sewage Effluent</tns:MaterialName>
        		<tns:Mechanism>Spot</tns:Mechanism>
        		<tns:Measurement>
        			<tns:DeterminandName>pH</tns:DeterminandName>
        			<tns:ResultType>E</tns:ResultType>
        			<tns:ResultValue>7</tns:ResultValue>
        			<tns:ResultUnits>pH</tns:ResultUnits>
        		</tns:Measurement>
        		<tns:Measurement>
        			<tns:DeterminandName>BOD 5 Day ATU as O</tns:DeterminandName>
        			<tns:ResultType>E</tns:ResultType>
        			<tns:ResultValue>2345</tns:ResultValue>
        			<tns:ResultUnits>mg/l</tns:ResultUnits>
        		</tns:Measurement>
        	</tns:Sample>
        	<tns:Sample>
        		<tns:SampleType>C</tns:SampleType>
        		<tns:CustomerSamplePointName>BLEL</tns:CustomerSamplePointName>
        		<tns:SampleDateTime>2009-04-02T12:53:00</tns:SampleDateTime>
        		<tns:PurposeTypeName>EM</tns:PurposeTypeName>
        		<tns:MaterialName>Trade Effluent</tns:MaterialName>
        		<tns:Measurement>
        			<tns:DeterminandName>pH</tns:DeterminandName>
        			<tns:ResultType>E</tns:ResultType>
        			<tns:ResultValue>9.567</tns:ResultValue>
        			<tns:ResultUnits>pH</tns:ResultUnits>
        		</tns:Measurement>
        		<tns:Measurement>
        			<tns:DeterminandName>BOD 5 Day ATU as O</tns:DeterminandName>
        			<tns:ResultType>E</tns:ResultType>
        			<tns:ResultValue>26.4</tns:ResultValue>
        			<tns:ResultUnits>mg/l</tns:ResultUnits>
        		</tns:Measurement>
        	</tns:Sample>
        	<tns:RegulatedCustomerIdentifier>2</tns:RegulatedCustomerIdentifier>
        </tns:FileUpload>
      </ReturnBody>
    </MultiReturn>



### Standard 12 - Other Representations
Representations other than JSON or XML will only be provided where there is a clear user need, in practice this is
likely to mean binary representations.

Other text representations such as CSV are not generally considered appropriate for RESTful APIs as they undermine the
service's inherent discoverability and usability.

Again, standard content type identifiers will be used, with no custom parameters.

### Standard 13 - Hypermedia
Resources will provide standard hypermedia references through an embedded **links** element, each with a **rel** and
**href** element.

As a minimum each resource should have a **self** link.

 > TODO: Any others?

 > TODO: What about content types that aren't JSON or XML?

### Standard 14 - Error Handling and HTTP Response Codes
Standard HTTP response codes will be used to indicate success or failure of an operation.

Where an operation has failed, the server may return a response that provides additional information on the nature of
the error, in either a JSON or XML representation, depending on the content type requested by the client, where once
again JSON will be the default.

Error responses will generally only be provided for error codes 400, 409 and 500 as other response codes are considered
to be self-explanatory.

 > TODO: Full list of response codes to support?

DELETE requests should preferably result in a 200 (OK) response with a body confirmation rather than a 204 (NO CONTENT)
response, although this latter is acceptable if technical constraints make it necessary.

The responses should contain the elements identified in the best practice document.

 > TODO: Copy these in here?

### Standard 15 - HTTP Headers
Only standard HTTP headers will be used in API implementations.

 > TODO: Specify these here?

 > TODO: What headers will the authorisation facilities require? Do these need to be stated here?

### Standard 16 - Pagination
Where large result sets are returned by a service, they will be paginated.

Pagination will be automatically applied and included in hypermedia links, so a standard isn't strictly necessary.
However, for reasons of consistency and "least surprise" the standards outlined here will be followed.

Pagination will be controlled through two custom request parameters, _offset and _limit.

A hard pagination limit will be defined as appropriate to the service.  Given that pagination is a device used
primarily to support human interaction whilst maintaining service performance, a hard limit of around 50 to 100 would
generally be appropriate.

Where a known client need exists for larger, unpaginated result sets then this may be implemented but will be carefully
assessed beforehand to ensure that a RESTful API is the most appropriate technical solution.

### Standard 17 - Querying
Query string structure will be defined according to user need.

Where resource querying or filtering is required, then a simple mechanism using URI query parameters will be provided,
such as:

 > http://permitservice.gov.uk/renewalservice/v1/permits?holder=John&location=London

For transactional APIs this is likely to be sufficient, as clients will largely be interested in a known subset of
resources with pre-understood characterstics.

Open Data APIs and transactional APIs with more complex querying requirements will provide a **_query** parameter
whose value will contain a URL-encoded string describing a full query expression.

There is no industry standard for the syntax of resource query expressions and implementing generic searching and
querying capability can be a complex, time-consuming and resource-hungry exercise.
The need for such a capability should be carefully assessed before being implemented.

### Standard 18 - Caching

 > TBC - this probably only needs covering for Open Data APIs

### Standard 19 - API Definitions
There are competing standards for REST API definition, the most convincing rationale for selection of any one of them
being that it is built into an API management product that you use.

So, this shall be decided by selection of an API product, rather than vice versa.

For now, it is not an area worth standardising.



Implementation Checklist
------------------------
This section provides a summary list of features to be provided in an API.

### All APIs

 1. Root path: http://hostname.gov.uk/{my-api-name}
 2. GET, HEAD, OPTIONS methods
 3. Supported content types defined
 4. Accept header
 5. _format parameter: http://hostname.gov.uk/{my-api-name}/{my-resource-name}/{id}?_format=text/xml
 6. Logic to determine best representation
 7. Resource names and hierarchy defined
 8. Querying supported using query parameters
 9. Hypermedia "self" links
 10. Error response messages

### Open Data APIs

 1. Pagination using _offset and _limit parameters, with hypermedia "first", "last", "previous" and "next" links
 2. Defined pagination hard limit
 3. Querying supported using _query parameter
 4. ETags and cache control headers

### Transactional APIs

 1. Versioned path: http://hostname.gov.uk/{my-api-name}/v1
 2. _version parameter: http://hostname.gov.uk/{my-api-name}/{my-resource-name}/{id}?_version=v1
 3. Redirect for unversioned path requests
 4. OAuth implementation
 5. API key implementation
