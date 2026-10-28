# Local development standards

Every service must be straightforward to run and test on a developer machine. These standards set out what "straightforward" means. They do not say which approach to take, because the right approach depends on the service. The [local development patterns guide](../guides/local_development_patterns.md) explains the options and our preferred defaults.

## Rationale

- **Developer mobility and agility.** Developers move between teams, services and devices. A setup that only works on one person's machine, one operating system or one team's laptop image slows everyone down.
- **Onboarding.** The time between a new developer joining and making a useful change is a direct cost. Most of that time is spent getting things running.
- **Device constraints are real.** Defra devices are restricted by default and developers need an exception profile and elevated rights to install software. Suppliers use their own devices. Every manual install we require is friction, multiplied by everyone who joins.
- **Debugging matters more than setup.** Setup happens once. The inner loop happens multiple times a day.
- **Confidence in tests.** If tests can only be run in a pipeline, they get run less, and failures are diagnosed from logs instead of a debugger.
- **Reducing "works on my machine".** Differences between developer machines cost time that is hard to attribute and easy to repeat.

## Terminology

`Inner loop` - the cycle a developer repeats many times a day: change code, run it, see the result
`Dependency` - infrastructure a service needs to run, such as a database, cache, message broker or another service
`Host-native` - running the application or its tests directly on the developer machine rather than inside a container
`Orchestration repository` - a non-deployable repository that holds the tooling to run several related services together

## Standards

### Every service can be run locally

Anyone with access to the repository can run the service on their own machine. Nothing needed to run it depends on undocumented knowledge, a specific person, or a manually configured machine.

Where a dependency genuinely cannot be run locally, the repository documents what it is, why, and what to do instead.

### Local development is not tied to a specific device or operating system

Teams must not constrain their local development setup to a specific device or operating system. Deployed services run on Linux, per the [container standards](container_standards.md), and local development should be consistent with that: on Windows, use Windows Subsystem for Linux rather than the native Windows filesystem and tooling; on macOS, use the native environment directly. Both give a Linux-like environment that matches how the service is built and deployed.

Only work directly on the Windows filesystem when it is unavoidable, for example a technology that does not work through WSL such as .NET Framework.

### Dependencies are provisioned, not installed by hand

Wherever it is possible to do so, databases, caches, message brokers and similar dependencies are provisioned automatically, normally as containers, rather than installed and configured by hand on each developer machine.

Some dependencies cannot be run this way, and instead need a local install or a dedicated cloud instance. That is not the standard we are aiming for, it is an accepted exception where automatic provisioning is genuinely unavoidable.

The only things a developer should have to install to meet the standard are the language runtime, a container runtime, an editor and standard command line tooling.

Manual installation is high friction, drifts between machines, and is a common cause of support demand.

### Local development does not depend on cloud resources

A service can be run and developed without a connection to a deployed environment, a shared database or a cloud account.

Where a service integrates with a cloud service, local development uses an emulator or a stub. Some integrations have no emulator and no practical stub, and a real cloud instance is unavoidable. That is an accepted exception rather than the standard.

Shared environments are not used as a substitute for local development except where this exception applies. They cannot be reset, they cannot be worked on by two people at once, and they make every developer's work depend on everyone else's.

### A service is simple to start, ideally with a single documented command

Starting a service, including whatever dependencies it needs, should require as few commands as possible. Ideally one command is named consistently across the team's repositories and is stated in the README.

If several services are normally run together, there is a documented way to start them all at once. That must not become the only way to run any individual service.

### Tests can be run locally in full

The whole test suite can be run on a developer machine before pushing.

Where the suite has tiers, such as unit, integration and journey tests, each tier can also be run on its own, and the README says how.

Tests must not depend on a developer having started something first, unless the README says so plainly. Tests that bring up their own dependencies are preferred.

### A debugger can be attached to the running service and to a failing test

Whatever approach a team takes, a developer must be able to set a breakpoint in the running service and in a failing test, and step through the code.

The configuration needed to do this is committed to the repository. It is not something each developer works out for themselves.

### A basic local run does not require real credentials

A developer can start the service and exercise its main paths without live credentials, production secrets or access to a protected system.

Some integrations, such as a third-party identity provider, genuinely cannot be exercised without real credentials. That is an accepted exception rather than the standard: it is kept to the specific flow that needs it, it is documented, and the rest of the service still runs without it. See [managing application credentials](../guides/application_credentials.md).

Secrets are never committed. Repositories provide an example configuration file with safe defaults.

### The local development approach is a deliberate, recorded choice

The team knows how the application runs locally, how the tests run, and why. That choice is written down in the README rather than inherited by accident from a template.

Two things are recorded: where the application runs and where its dependencies come from, and the same for the tests. They are separate decisions and are recorded separately.

### Setup is reproducible from a clean clone

Following the README from a fresh clone results in a working service. Setup steps are repeatable and safe to run again.

Any setup that cannot be scripted is listed explicitly in the prerequisites, and the list is kept short.

### The README explains how to run and test the service

Every repository documents how to run the service in development and how to run its tests, as required by the [README standards](readme_standards.md).

This is the check that makes all the standards above verifiable. If it is not written down, it does not count.

## Status

This standard was formally adopted August 2026.
