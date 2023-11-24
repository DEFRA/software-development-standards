# Reuse

## Introduction
We talk a lot about reuse: how much we want it; the value it can deliver for us; what we need to do to ensure that we
achieve it and so on.

In comparison, however, we talk a lot less about what we _mean_ by reuse.

This causes problems, because the term "reuse" is itself reused to describe a range of quite different activities,
which leads to difficulties in our communication, particularly between people with different backgrounds or specialisms.

In an attempt to raise awareness of the issue and hopefully shine a light on some of the different interpretations of
reuse, I've provided some descriptions and names for different types of reuse.  This is by no means an exhaustive or
standardised list but rather is simply intended as an aid to communication.

## 1. One single thing
### Description
"One single thing" refers to the situation where have, quite simply, only one instance of something and everybody uses
it.
This approach is sometimes referred to as a "shared service" or "common service" although those terms are themselves
used somewhat ambiguously.
### Why would we do this?
The benefits to this approach are both cost saving and consistency.  Having a single source of the truth can deliver
significant value in terms of data quality and also only having a single instance of something saves money on
infrastructure costs.
### Why wouldn't we do this?
It's hard work.  When everyone is using the same instance of something it requires careful design and management to
ensure that people don't inadvertently or even deliberately impact each other.  This requires considerable time and
effort.
By seeking to be all things to all people, the one single thing inevitably has to cater to the most basic common need
rather than being adapted for specific uses.
### Where do we do this?
This kind of reuse is typically employed where we have a highly generic capability that is common all across the
organisation and likely across industry.  In these cases, the cost and effort involved in running a truly shared
facility are mitigated by the sheer volume of places where the functionality will be reused.
Very often, the one single thing is so generic that it can be acquired as a commodity item in the marketplace rather
than needing to be built within the organisation.  Also, the one single thing may represent a common need across
government and so might be delivered centrally.
#### Examples
OS Places address lookup, Companies House lookup, GOV.UK Registers, GOV.UK Pay, GOV.UK Notify

## 2. Many of the same thing
### Description
"Many of the same thing" is really about defining a standard product and deploying it in multiple business scenarios.
Some might argue that this represents "leverage" of existing investment rather than "reuse" but that seems like a
trivial semantic distinction.
### Why would we do this?
There are clearly cost savings to be made from consolidating investment in standard products, but even more than that
there is value in being able to reuse people's knowledge and experience.
Having multiple instances of the same thing allows those instances to be configured and adapted for the specific
business scenario without adversely impacting other business areas.
### Why wouldn't we do this?
Deploying many instances of a product makes for a more complex IT estate, which in turn leads to additional cost and
effort in managing that estate, so it may sometimes be more desirable to have one single thing instead.  Much of the
same effort is involved in running many of the same thing as in just running one single thing.
Conversely, there will be business scenarios that are not a good fit for the standard product and so efforts to
crowbar it into such cases should be resisted.
### Where do we do this?
This type of reuse is mostly employed where the required functionality is quite common across the organisation or
industry, but it needs to be adapted for specific business processes that are owned by distinct business functions.
Careful consideration needs to be given to the effort of managing standard products versus simply allowing business
functions to develop their own capability.  Quite often the balance tips in favour of having many of the same thing
once the first instance of the thing is already up and running.  Consequently, this reuse approach lends itself more
towards the use of existing products in the marketplace rather than bespoke capability, although not exclusively.
#### Examples
Microsoft Dynamics 365, SOP

## 3. Doing things the same way
### Description
This refers to using the same approaches to deliver business functionality, in particular it relates to using common
tools and technologies to build software solutions.
### Why would we do this?
Taking this approach allows us to build up the right level of capacity and capability, both within and across
development teams, to allow people upon sight of a business problem to say "Ah I know how to solve this because I've
built something similar with this technology before!"  This allows them to arrive at the correct solution more quickly,
saving time and effort.
### Why wouldn't we do this?
Because:
> "I suppose it is tempting, if the only tool you have is a hammer, to treat everything as if it were a nail."
> -- <cite>Abraham Maslow</cite>

Having standard tools and technologies does not negate the need for careful problem analysis and the considered
application of the most appropriate technical solution.
### Where do we do this?
Wherever we are building bespoke capability, as far as possible.
#### Examples
Waste Permits, I Want to Fish

## 4. Pinching things (possibly needs a better name)
### Description
This involves taking some prior work and modifying it to fit a new business problem.
In technical terms it primarily means copying or forking code or designs.
No actual theft is required, encouraged or condoned.
### Why would we do this?
There is sufficient similarity of IT needs across the organisation that not all business problems are entirely unique.
This affords opportunities to save time and effort by reusing work done previously.
This is very much the modus operandi of a functioning development team and is likely to be second nature to most
developers
### Why wouldn't we do this?
It can equally be the case that prior work is not fit for reuse due to issues such as naive implementation or very
tight coupling to specific business problems.
There is also the regrettable but real "not invented here" syndrome, where a development team can expend more effort
becoming familiar with an existing solution than they save by reusing it.
### Where do we do this?
This approach is most readily applied where "doing things the same way" has already been implemented, as using
different technologies is almost certainly a barrier to being able to directly steal things.
One of the greatest benefits of the wide open source community, particularly within government, is actually this
pinching of code and ideas rather than direct use of donated code.
#### Examples
Flood Risk Activities Exemptions

## 5. Donating things
### Description
This involves creating a piece of "framework" or "component" code that provides specific functionality that is
intended to be directly reused by development teams.
### Why would we do this?
Not every problem in IT is entirely unique and there is no need to solve the same problems over and over again.
All modern business IT development is based on the use of pre-existing frameworks, libraries and components.
Very little is developed entirely from scratch, and these facilities provide development teams with an enormous
head start, thus reducing the overall delivery effort.
### Why wouldn't we do this?
Because the road to hell is paved with good intentions.
Nine times out of ten a genius framework or component turns out not to be useful for the next business problem to
which it is being applied as the original author had no knowledge of that business problem and so was unable to design
for it.  Therefore the additional effort of trying to build something reusable was entirely wasted, as was the effort
in assessing whether the framework was applicable to the new business problem.
Somebody has to continue to own and maintain the things that are donated.
### Where do we do this?
Largely this tends to happen within a functioning development team as they move between products or iterations of
products, but we expect to get value from donating things _between_ teams.
The Rule of Three for code refactoring provides a general guide for when to consider donating things rather than
pinching things.
#### Examples
Address Facade

## In conclusion
There are quite different ways of doing reuse and we are applying a number of them across the organisation.

The word "reuse" means different things to different people, so it is probably worth clarifying exactly what you
mean when discussing the subject with others as they may be thinking of something completely different.
