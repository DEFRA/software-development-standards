# Choosing a cloud provider - Azure or AWS?

In Defra we have a strategic relationship with both Amazon and Microsoft, and we use both of their cloud platforms.

Many of the solutions we implement will use a combination of the two along with other government and commercial platforms.
However, we will often find ourselves asking the following question:

> For this particular workload should I be targeting Azure or AWS?

## Does it matter?

***Yes.***

Viewed from a certain level, the different cloud providers offer broadly similar services that are subject to
market competition, so the largest differentiator is simply cost.

Whilst there is some truth in this and it _is_ possible to acquire very similar services in some areas,
in reality there are far more differences than similarities.

Some of the main considerations to be aware of, and why it _really does matter_ are:

- Some things are just _much_ easier to do on one platform compared to the other.
  This is often underestimated as a deciding factor, partly because it requires detailed up front knowledge of all
  the complications of a certain implementation, which can be extremely difficult when the platforms are
  changing all the time. But this issue can translate into weeks of additional effort.
  
- Some platform features are entirely proprietary and do not translate to features available from the other provider.
  This means that choosing the wrong provider to start with will require a complete re-build and re-write.
  
- Vendor lock-in is real. Choosing to use a particular feature of one platform can easily _require_ you to use other
  features of the platform, even though you would ideally want to deploy a certain workload on the other provider's
  platform.
  
- The benefit of using cloud platforms is clear - they save us a lot of effort and enable us to do things quickly if
  we use them correctly. By choosing the right platform for the job, we can deliver better services.

## Key differences

It is worth establishing that, despite the many similarities, there are some key fundamental differences between
the two platforms.

### Philosophy

Amazon started as an Internet shopping platform, whereas Microsoft have always been a software vendor.
This difference in origin is reflected right through into their current cloud platforms in a number of ways:

- AWS has always been about providing a way for you to run services _at Internet scale_ - robustness and security
  are baked into the product from the outset.
  The advantage of this is that you can be pretty confident that your services are ready for production use in the
  real world on the public Internet. This also equates to greater reliability of the entire platform.
  The disadvantage is that it can require quite a lot of effort just to try something out.
  
- Azure, on the other hand, is all about getting software into the hands of your users as quickly as possible.
  In some ways you the developer are not really the customer for Azure, it's your end user.
  This tends to mean that Azure services are on the public Internet by default, so additional security aspects
  will need to be considered before something can be ready for production use.
  
- Microsoft are not just competing with Amazon for your cloud dollar - they are also looking for you to buy their
  other software, such as Office 365, where they are more directly in competition with the likes of Google.
  As a first-party software vendor, they can make it very easy for you to integrate your Azure-based services
  with their own software.
  
- AWS provides a very wide range of low-level services that you are free, as a developer, to configure as required
  and to assemble into solutions as you see fit.
  Azure has fewer services overall and they tend to provide more of an entire solution, with fewer options for
  low-level configuration of their behaviour.
  
- Microsoft will more readily implement new, experimental features into their platform, much like with their software,
  because new features sell products.
  This can provide opportunties but also means that features can quickly become deprecated or even never make it
  past public preview.
  By contrast, most features that are implemented in AWS tend to remain supported for longer and have longer change
  cycles with better backwards-compatibility.
  
- Microsoft will engage you with consultants and third-party providers to help identify opportunities to use their
  ~~software~~ products in your organisation.
  Amazon tends more towards providing fully-featured and comprehensively-documented APIs so that you can decide for
  yourself how best to use their platform.

### Technology

One of the key things to understand about the big three cloud platform suppliers is that
_they all use their own proprietary technology_.

Whilst smaller vendors might make use of the likes of OpenStack or vCloud on commodity hardware, this is not the
case with AWS and Azure.

Most of the time, this will be invisible to a developer, as a virtualised Linux distro on one platform looks much like
it does on another, but sometimes it can cause surprises and unexpected behaviours.

Sometimes the only implication of this is that some things are easier to do on one platform than the other, but the
key point is that something that is tested and shown to work on one platform cannot ever be considered as being able
to work on the other until proven to do so.

### Authorisation and access control

Coming from its Windows heritage, Azure expects you to use its Active Directory services to control access to the
workloads that you deploy on there.
Authorisation decisions will inevitably involve the use of Active Directory identities and associated roles and
permissions.
If the workload that you are deploying doesn't already integrate with Active Directory then you should expect to have
to do some work to make it aware of its Active Directory security context.

AWS has its own, very fine-grained permissions model that is defined and configured as part of the process of
commissioning its services.
This can free developers from needing to establish and manage the security context for every workload, but it does
mean that a certain amount of configuration work is required on the platform, as opposed to the Azure approach
where everything "just works" (when it does).

The implications of this are that some workloads will just fit better on one platform or the other because of their
authorisation needs and functionality, but also that any code written in this area is unlikely to be portable
across vendors.

### Proprietary higher-level platform services

It seems like an obvious point, but the higher up the stack of platform services you go, the more proprietary those
services become.
A workload built as an Azure Logic App will need to be entirely re-written and re-designed to be an AWS Step Function.

The key issue here being that skills and knowledge in this area on one platform don't necessarily translate onto
the other platform, so it can be difficult for a single team to maintain both.
