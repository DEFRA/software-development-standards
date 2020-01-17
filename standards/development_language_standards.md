# Application development languages

## Purpose
This position statement lays out the default technical approach as agreed by the DDTS digital development community.

It should be used as a guide for all new digital development within Defra and forms a technical standard for all new
development work undertaken by or on behalf of DDTS.
 
## Scope
This position statement covers the choice of development languages used for digital development.

It is based on an architectural pattern for Defra digital services that focuses on:
- Delivering highly user-focused online digital services to our customers
- Delivering common IT platforms to support pan-Defra alignment of services and maximise the value of our investment
- Following the Government Technology Code of Practice, in particular pursuing a Cloud first agenda and giving equal
  consideration to open source software
 
## Position

### We maintain capability in more than one application development language
Whilst there are benefits from standardising on a single technology platform, these are outweighed by the advantages to
be gained from having the ability to choose the right tool for the job.

Pros:
- Increased business agility
- Easier adoption of developments in the IT industry
- Less constrained vendor and product selection
- Stronger supplier management capability
- Reduced development cost
- Better opportunities for re-use of external code, libraries, products and best practice
- Happier developers!

Cons:
- More difficult resourcing
- Fewer opportunities to share internal code and best practice
- Difficult to achieve with only a small number of developers
- Complicates technology choices
 
### We build on open platforms whenever possible
The government technology code of practice mandates:
- giving equal consideration to free or open source software when you choose technology - taking account of the total
  cost of ownership of the service, including exit and transition costs
- making all new source code open by default
- using open standards, complying with any that are compulsory for use in government, unless you've been granted an
  exemption

The simplest way to achieve this is by considering open platforms first.
 
### Our primary development platforms are Microsoft's .Net framework and Node.js
Defra is engaging on a two-fold approach to its IT application architecture: the use of common commodity products and
the development of highly user-centric online digital services.

This creates a need to be able to engage with both commercial products, which are often based around Microsoft's
technology stack, and the open development community.

By focusing on these two key technologies, we benefit from the flexibility that it provides whilst also constraining
diversity to a level that is appropriate for a medium-sized team of developers.

Other technology options are available, but .Net (specifically C#) and Node.js are the two platforms that fit the need
best whilst also already having sufficient support in the Defra software development teams.

Because some aspects of certain problems require a small use of additional technologies or because of ongoing need to
support an existing service, DDTS still needs to maintain some limited capability in a number of other technologies,
such as Java, R, Python, Ruby, VBA, etc, but .Net and Node.js are preferred.
 
### We develop online digital services in Node.js
The online digital development community is largely comprised of developers from the open source community, who produce
and share many freely available frameworks, libraries and tools.

Consequently, development of this kind can best achieve the necessary levels of agility by making use of those same
technologies.
This can be seen across government as well, in particular the GDS front end community tend to publish their products
so that they can be easily used in Ruby and Node.js, in particular.
 
### We use the Hapi framework to develop in Node.js
Hapi is already in use in Defra digital services and has provided a productive level of standardisation across
development teams and has proven to be robust and reliable.
 
### We extend commodity platforms by building bespoke capability in such a way that it can be surfaced in the products
Although our target enterprise architecture is based around the use of commodity platforms, an equally important part
of that architecture is the part played by bespoke capabilities that those platforms do not provide, or could not
provide without inappropriate levels of customisation.

Where this is the case, we build that capability in such a way that it can be surfaced within those commodity products,
either as back end services or "at the glass" integration.

Doing this means that we decouple the bespoke capability from the product, thus making it easier to perform changes and
upgrades, but also make it possible to deliver a coherent user interface.
 
### We use .Net to customise and extend commodity products
Many of our commodity products come from Microsoft and so provide a .Net customisation platform.

In addition, they will often provide highly capable .Net libraries and SDKs that enable integration with the products,
including add-in functionality such as SharePoint Provider Hosted Add-Ins.
 
### We use C# as our .Net development language
C# is the de facto standard language for .Net development and owing to its similarity to Java provides a level of
familiarity and cross-fertilisation with other language communities.

It is also the language that is best supported in open source .Net frameworks.
 
### We use .Net Core wherever practical in preference to standard .Net
.Net Core is Microsoft's strategic direction for the .Net framework and gives all the benefits of being open source,
including growing community support.