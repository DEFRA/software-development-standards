# Deployment standards

## We use Docker containers for delivery of all bespoke software being deployed to AWS and Azure
Where we develop bespoke software, we default to using a Docker container as the deployable item.

Unless the technology does not support containerisation, all deviations from this standard will be treated as architectural exceptions.

### Rationale
Containerisation is _most_ applicable to certain specific scenarios, such as highly-available applications with varying demand or when using technologies that have a frequent update cycle.

However, running and managing a delivery pipeline and operational environment that supports _both_ containers and more traditional virtual machines results in a duplication of effort and technical solutions.

Therefore, we will seek to minimise or eliminate this duplication by _always_ preferring containerisation.

Containerisation also allows us to better manage a diverse application estate as it somewhat mitigates the need for across the board standardisation and large, coordinated upgrade projects, allowing instead for more nuanced decision-making.

## We deploy code rather than containers to AWS Lambda and Azure Functions where their use is formally justified
There are cases where it will make sense to use a serverless platform rather than a containerised solution, but these _must_ be individually justified and recorded as formal architectural decisions.

Additionally, justifications for using serverless platforms can _only_ be considered for JavaScript or C# functions.

### Rationale
Serverless platforms provide a greatly reduced operational burden, but are not so well represented in development and have certain limitations that can make their use inappropriate.
They also represent some vendor lock-in that, whilst minimal, is still not preferred.

## We regularly review our use of serverless platforms
In particular, we will ensure that:

- Vendor lock-in doesn't increase
- We identify opportunities to rationalise these standards to use, effectively, "serverless containers"

### Rationale
As serverless platforms are still relatively immature, we will need to ensure that our standards are still appropriate.
