# Choosing a cloud provider - Azure or AWS?

In Defra we have a strategic relationship with both Amazon and Microsoft, and we use both of their cloud platforms.

Many of the solutions we implement will use a combination of the two along with other government and commercial platforms.
However, we will often find ourselves asking the following question:

> For this particular workload should I be targeting Azure or AWS?

## Does it matter?

**_Yes_.**

Viewed from a certain level, the different cloud providers offer broadly similar services that are subject to
market competition, so the largest differentiator is simply cost.

Whilst there is some truth in this and it _is_ possible to acquire very similar services in some areas,
in reality there are far more differences than similarities.

Some of the main considerations to be aware of, and why it _really does matter_ are:

- Some things are just _much_ easier to do on one platform compared to the other.
  This is often underestimated as a deciding factor, partly because it requires detailed knowledge up front of all
  the complications of a certain implementation, which can be extremely difficult when the platforms are
  changing all the time. But this issue can translate into weeks of additional effort.
  
- Some platform features are entirely proprietary and do not translate to features available from the other provider.
  This means that choosing the wrong provider to start with will require a complete re-build and re-write.
  
- Vendor lock-in is real. Choosing to use a particular feature of one platform can easily _require_ you to use other
  features of the platform, even though you would ideally want to deploy a certain workload on the other provider's
  platform.
  

