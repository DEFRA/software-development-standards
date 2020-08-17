# Development languages

This standard defines the development languages we use.

The standard has come from delivering digital services that tend to follow this pattern:
- A bespoke online digital service that is specifically built to meet well-researched user needs
- One or more common Defra core IT systems that support our business
- Pursuing a Cloud first agenda and giving equal consideration to open source software
 
## We use more than one development language
We recognise the value of choosing the right tool for the job so we do not specify one single development language
for everything we deliver.

The advantages of this approach are:
- it increases our ability to rapidly respond to changing business needs
- we can more easily adopt new developments in the IT industry
- vendor and product selection is less constrained
- it strengthens our supplier management capability
- reduced development cost
- better opportunities for re-use of external code, libraries, products and best practice
- happier developers!

There are some disadvantages, such as the following, but these are out-weighed by the advantages:
- staff recruitment, retention and work allocation is more difficult
- there are fewer opportunities to share internal code and best practice
- it can be difficult to maintain enough capability with only a small number of developers
- it adds extra complexity to technology choices
 
## We build on open platforms whenever possible
The government
[Technology Code of Practice](https://www.gov.uk/government/publications/technology-code-of-practice/technology-code-of-practice)
states that you must:
- Be open and use open source
- Make use of open standards

The simplest way to achieve this is by using open platforms by default.
 
## Our primary development platforms are Microsoft's .NET and Node.js
There are two key areas within Defra where we need to write custom code.

We build bespoke online digital services using standard government libraries and frameworks.
For these we have identified Node.js as the most suitable platform.

We also build solutions on top of commercial software products, where we have to use the platform that the vendor
provides.
Many of those products are from Microsoft, which means that we use .NET for this.

These two platforms provide a wide range of capabilities so we can use them for most of the applications we
develop.  We benefit from the flexibility of having two distinct platforms to choose from but also limit the
diversity to a level that is appropriate for a medium-sized team of developers

However, these two technologies alone will not _always_ be the solution to every problem and we also have a range of
existing applications within Defra that are built using other platforms. So, we still need to maintain some limited
capability in many other technologies such as Java, Python, R, Ruby and VBA.
 
## We develop online digital services in Node.js
The world of online digital development is dominated by open source technologies so there are many freely available
frameworks, libraries and tools to support it.

These kind of services change rapidly, which has led to the rise of rapid development frameworks and a preference for
dynamic languages.

Building for the Web means that developers already need a knowledge of Javascript, so using Node.js eases the
burden on developers to maintain capability in multiple languages. Also, Node.js has proven to deliver good
application performance in most Web-facing scenarios.

This can be seen across government as well, in particular the GDS front end community tend to publish their products
so that they can be easily used in Ruby and Node.js, in particular.
 
## We use the Hapi framework to develop in Node.js
Hapi is already in use in Defra digital services and has provided a productive level of standardisation across
development teams and has proven to be robust and reliable.
 
## We minimise the customisation inside commodity platforms
Our enterprise architecture is based around commodity platforms, but these often require customisation
to meet our needs.

This customisation leads to a maintainability burden, so we prefer to deliver custom capability _outside_ of the
platform itself. To do this, we build bespoke functionality but provide a mechanism to include that functionality
in the user interface of the product. Most of the products we use have some way of doing this built in.

Taking this approach means that we decouple the bespoke capability from the core product, making it easier to perform
changes and upgrades, but we also provide a coherent user interface.
 
## We use .NET to customise and extend commodity products
Many of our commodity products come from Microsoft and so provide a .NET customisation platform.

In addition, they will often provide highly capable .NET libraries and SDKs that enable integration with the products,
including add-in functionality such as SharePoint Provider Hosted Add-Ins.
 
## We use C# as our .NET development language
C# is the de facto standard language for .NET development and owing to its similarity to Java provides a level of
familiarity and cross-fertilisation with other language communities.

It is also the language that is best supported in open source .NET managed frameworks.
 
## We use .NET Core wherever practical in preference to .NET Framework
.NET Core is Microsoft's strategic direction for .NET and gives all the benefits of being open source and cross platform,
including growing community support.
