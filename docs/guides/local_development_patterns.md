# Local development patterns

This guide helps you decide how to run a service and its tests on a developer machine, and shows you how to set up each option with as little friction as possible.

There is no single right answer for every service, so the guide sets out the options, explains when each one is the better fit, and gives you a working implementation for whichever one you choose. Where we do have a preferred default, we say so up front:

- **run the application on the host, with its dependencies in containers**
- **run tests on the host, using in-process fakes for unit tests and testcontainers for integration tests**

Start from these defaults unless your service has a specific reason not to. The rest of the guide explains what those reasons look like, and how to implement each option well.

The examples use Node.js because it is our primary and most common tech stack, but the patterns generalise: the compose profile, the orchestration workspace and the testcontainers lifecycle all work the same way in other technologies.

For the rules that apply whichever option you pick, see the [local development standards](../standards/local_development_standards.md).

## Two key decisions

There are two key conscious decisions teams should make that dictate the local development experience:

1. **How does the application run?** On the host, or in a container. And where do its dependencies come from.
2. **How do the tests run?** On the host, or in a container. And where do their dependencies come from.

## Decision 1: how the application runs

| Approach | What it buys you | What it costs you | Best fit |
| --- | --- | --- | --- |
| **Native app, containerised dependencies** (recommended default) | Fast reload, a working native debugger, and real dependency behaviour. The most common compromise, for good reason. | Two worlds to keep in sync. Host runtime version can drift from the image. Docker is still required. | Services with real infrastructure dependencies where iteration speed matters. |
| **Native app, dependencies installed on the machine** | No Docker at all. Lowest resource use on a constrained laptop. | "Works on my machine" comes back. Version drift stays invisible until something breaks. Onboarding becomes a page of install steps. | Services with a single dependency, or teams with a mature and scripted local install. |
| **Native app, dependencies stubbed in process** | The fastest possible loop. No daemon, no images, no ports. | A fidelity gap. You are testing against your belief about the dependency. Stubs drift silently. | Frontends, thin API layers, anything where the dependency is someone else's HTTP contract. |
| **Native app, no dependencies** | Nothing to explain. One command and you are working. | Only honest for genuinely dependency-free services. Frequently claimed, more rarely true. | Libraries, pure transformation services, static frontends. |
| **App and dependencies in containers** | The highest environment parity. One command. Identical for everyone, including CI. | The slowest inner loop. Debugging needs an attach configuration, and most developers give up on it. Rebuilds on dependency changes. | Services with many or awkward dependencies, and teams who value parity over iteration speed. |
| **Virtual machine, Codespaces or a shared instance** | Solves a constraint the other options cannot, usually a corporate device or licensing restriction. | Invisible to everyone else. No shared tooling or troubleshooting. Rarely documented. | Where it is genuinely the only option. |

### The debugging trade

Container-first is usually chosen for onboarding speed and consistency, and the cost is almost always debugging. Developers who only ever run their service in a container are far more likely to fall back on logs and print statements than to attach a step debugger, even though remote attach to the inspector port is documented and works.

That cost does not show up on day one. It shows up every day after that, in the loop you run many times a day.

If you choose container-first, choose it knowing this, and make the attach configuration part of the repository rather than something each developer works out alone.

## Decision 2: how tests run

| Approach | What it buys you | What it costs you | Best fit |
| --- | --- | --- | --- |
| **Native tests, in-process fakes** (recommended default for unit tests) | No Docker. Millisecond feedback. Trivial to run a single test. Works on any machine. | Only as good as the fake. In-process fakes exist for very few dependencies. Passing tests can prove less than they appear to. | Unit tests. |
| **Native tests, testcontainers** (recommended default for integration tests) | The container lifecycle is owned by the test code, so there is no "did you start compose first?". Clean state on every run. Already the documented approach in .NET, Java and Python. | Slower per run. Containers are invisible when something fails, so diagnosis is harder. Needs a Docker daemon. | Integration tests that need isolation and reproducibility, locally and in CI. |
| **Native tests, compose dependencies** | Real dependency behaviour with a native runner, watch mode and a working debugger. | The compose stack has to be up first. State leaks between runs. Tests can pass against a stale container. | Integration tests against a database you already run in compose. |
| **Native tests, dependencies installed on the machine** | The fastest integration tests available. No container overhead. | Every developer's machine is a different test environment. The worst reproducibility of any option. | Rarely the right answer. Usually a legacy position. |
| **Native tests, no dependencies** | Nothing to arrange. Genuinely instant. | Only honest for pure logic. Often a sign that integration tests are missing rather than unnecessary. | Pure functions, formatters, validators. |
| **Tests and dependencies in containers** | Exact parity with CI. The same thing runs locally and in the pipeline. | Container start cost on every run. Running one test means a container round trip. Watch mode needs its own compose overlay, and debugging needs another. | Teams where local and CI divergence has actually burned them. |
| **Tests run in CI, using CI dependencies** | Zero local setup. The pipeline owns the dependencies. | The feedback loop is a push and a wait. Failures are diagnosed from logs. It encourages people not to run tests before pushing. | Expensive or licence-restricted dependencies. |
| **A deliberate mix** | Honest. Different test tiers legitimately want different things. | Almost nobody writes down what the mix is. | Most real services, if we are candid about it. |

### A mix is a legitimate answer

Many teams genuinely mix strategies: unit tests in process, integration tests in containers, journey tests against a deployed environment. That is not a failure to decide. It is usually the right answer for a service of any size.

What matters is that the mix is deliberate and written down, not the accidental result of three people solving three problems on three different days.

### Watch for the fidelity gap

A common combination is a service that starts a real database to develop against, then tests against a fake one.

Sometimes that is a sensible trade. Often it is nobody's decision.

The cause is usually tooling. In-process fakes are readily available for MongoDB, so teams using MongoDB get fast, dependency-free tests almost by accident. There is no equivalent shipped for PostgreSQL, SQS, S3 or Service Bus, so teams using those either reach for testcontainers themselves or defer the question to a deployed environment.

If your unit tests use an in-process fake, ask what proves the real dependency behaves the way you think. If nothing does, that is the gap testcontainers fills.

## Choosing an approach

Work through these questions. They are prompts for a team conversation, not a flowchart with one correct exit.

**Does the service have stateful infrastructure dependencies, such as a database, cache or message broker?**

- No, and it genuinely calls nothing external. Run it natively with no dependencies. Test it natively with no dependencies.
- No, but it calls other HTTP services. Run it natively with those calls stubbed in process. Add contract tests so the stubs cannot drift silently.
- Yes. Keep reading.

**Do you need a step debugger in your inner loop?**

- Yes, and most people do. Run the application natively with dependencies in containers.
- No, and you are genuinely happy debugging from logs. Container-first becomes viable.

**Has divergence between local and CI actually caused you problems?**

- Yes, repeatedly, and you can name the incidents. Container-first buys you real parity and the debugging cost may be worth paying.
- No. You are paying for insurance against a risk you have not experienced.

**Can your dependencies run in a container or an emulator?**

- Yes. Use containers. This is close to universal practice for infrastructure dependencies, and for good reason.
- No, because of licensing, cost or a cloud service with no emulator. Consider running those specific tests in CI, and stub the dependency locally. Do not let one awkward dependency dictate the approach for everything else.

**Does your team routinely run several services together?**

- Yes. Add an orchestration repository and a shared workspace, so "run everything" is one command regardless of which approach each service uses.
- No. Keep each repository self-contained.

**Whatever you choose, can a new developer get the service running from a clean clone using the commands in the README?**

If not, fix that before anything else. It is the one thing the standards have always required.

## Native application with containerised dependencies

This is the recommended default. The application runs on the host with hot reload and a native debugger. Its dependencies run in containers. The same compose file can also run the application itself when you need the full stack.

### One compose file, with the app behind a profile

Keep a single `compose.yaml` per repository. Put the application service behind a profile so it does not start by default.

```yaml
services:
  my-api:
    profiles: ["app"]
    build:
      context: .
      target: development
    ports:
      - "3001:3001"
      - "9229:9229"
    volumes:
      - ./src:/home/node/src
    env_file:
      - .env
    environment:
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - my-network

  postgres:
    image: postgres:16.6
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: ppp
      POSTGRES_DB: my_api
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 10
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - my-network

volumes:
  postgres-data:

networks:
  my-network:
    driver: bridge
```

That gives you two modes from one file:

```bash
docker compose up -d                  # dependencies only, for host-native development
docker compose --profile app up -d    # the full stack in containers
```

A single file that supports both modes is much easier to keep correct than a family of overlays that drift apart.

### Two layers of environment configuration

The application needs different hostnames depending on where it runs. On the host it talks to `localhost`. Inside a container it talks to the compose service name.

Handle that with two layers rather than two files. A single `.env` holds every developer-supplied value. When the application runs on the host, the runtime loads that file directly. When it runs in a container, compose loads the same file through `env_file:`, then the `environment:` block overrides only the values that have to differ, which in practice is little more than hostnames and ports.

That way there is one place to set a value, wherever the application ends up running. The [Docker guidance](docker_guidance.md) covers the compose syntax and precedence rules.

Commit a `.env.example` with safe defaults and never commit `.env`.

### The script surface

Use the same script names in every repository so developers moving between services do not have to relearn them.

| Script | Command | Purpose |
| --- | --- | --- |
| `dev` | `NODE_ENV=development node --env-file-if-exists=.env --watch --watch-path=./src src/index.js` | Run on the host with hot reload |
| `dev:debug` | as above, plus `--inspect` | Same, with the inspector on `127.0.0.1:9229` |
| `local` | `npm run services:up && npm run dev` | The one command a developer needs |
| `services:up` | `docker compose up -d` | Start dependencies only |
| `services:down` | `docker compose down` | Stop dependencies |
| `start` | `NODE_ENV=production node .` | Used inside the production image |
| `test` | `vitest run --coverage` | Unit and integration tests |
| `test:unit` | `vitest run --coverage --project unit` | Fast feedback |
| `test:integration` | `vitest run --coverage --project integration` | Real dependencies |
| `test:watch` | `vitest` | Test-driven inner loop |
| `docker:build` | `docker compose --profile app build` | Build the application image |
| `docker:dev` | `docker compose --profile app up` | Run the whole stack in containers |

Two details matter.

Use `--env-file-if-exists` rather than `--env-file`. The latter fails hard when the file is missing, which breaks every deployed environment where configuration comes from the platform instead of a file.

Use the runtime's own file watcher rather than a separate watch dependency. `node --watch --watch-path=./src` removes a dependency and behaves consistently across operating systems.

Prefix test scripts with `cross-env TZ=UTC` so date assertions behave the same on every machine.

### Make shutdown fast in development

If the service drains in-flight requests on shutdown, the timeout that protects production makes every hot reload feel slow. Use a short timeout in development and the full timeout in production.

```javascript
const shutdownTimeout = config.get('isDevelopment') ? 1000 : 10000
```

### VS Code configuration

Commit `.vscode/launch.json` so debugging works from a clean clone.

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dev: run server",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/index.js",
      "runtimeArgs": [
        "--env-file-if-exists=.env",
        "--watch",
        "--watch-path=./src",
        "--inspect"
      ],
      "env": { "NODE_ENV": "development" },
      "restart": true,
      "console": "integratedTerminal"
    },
    {
      "name": "Debug current test",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/node_modules/.bin/vitest",
      "args": ["run", "--inspect", "--no-file-parallelism", "${relativeFile}"],
      "env": { "TZ": "UTC", "NODE_ENV": "test" },
      "console": "integratedTerminal"
    }
  ]
}
```

Commit `.vscode/tasks.json` so the common commands are discoverable without reading the README.

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Services: Up",
      "type": "npm",
      "script": "services:up",
      "problemMatcher": []
    },
    {
      "label": "Dev",
      "type": "npm",
      "script": "dev",
      "isBackground": true,
      "problemMatcher": []
    },
    {
      "label": "Test",
      "type": "npm",
      "script": "test",
      "group": { "kind": "test", "isDefault": true },
      "problemMatcher": []
    }
  ]
}
```

## Integration tests with testcontainers

Testcontainers starts the containers your tests need from inside the test process, and stops them when the run finishes. There is no separate stack to remember to start, no shared state between runs, and no set of compose test overlays to keep in step.

### Split unit and integration tests into projects

Unit tests should not pay the container cost. Split them, so a developer can run either tier alone.

```javascript
import { defineConfig } from 'vitest/config'

const sharedEnv = {
  NODE_ENV: 'test'
}

export default defineConfig({
  test: {
    clearMocks: true,
    coverage: {
      include: ['src/**/*.js'],
      exclude: ['**/test/**', 'coverage'],
      reporter: ['lcov', 'text']
    },
    projects: [
      {
        test: {
          name: 'unit',
          include: ['test/unit/**/*.test.js'],
          clearMocks: true,
          env: {
            ...sharedEnv,
            POSTGRES_HOST: 'postgres',
            POSTGRES_PORT: '5432'
          }
        }
      },
      {
        test: {
          name: 'integration',
          include: ['test/integration/**/*.test.js'],
          clearMocks: true,
          globalSetup: ['./test/setup/global-db.js'],
          env: sharedEnv
        }
      }
    ]
  }
})
```

Pin the connection values in the unit project. Both projects can share a process, and without pinning, the dynamically mapped port set by the integration project can leak into the unit project and produce confusing failures.

### Start the dependency in global setup

Global setup runs once per test session, before any test. It starts the container, waits for it to be ready, writes the connection details into `process.env`, and returns a teardown function.

```javascript
import { PostgreSqlContainer } from '@testcontainers/postgresql'
import { GenericContainer, Network, Wait } from 'testcontainers'

export default async function setup () {
  const network = await new Network().start()

  const postgres = await new PostgreSqlContainer('postgres:16.6')
    .withNetwork(network)
    .withNetworkAliases('postgres')
    .withDatabase('my_api')
    .withUsername('postgres')
    .withPassword('ppp')
    .start()

  const migrations = await new GenericContainer('liquibase/liquibase:4')
    .withNetwork(network)
    .withBindMounts([{
      source: `${process.cwd()}/changelog`,
      target: '/liquibase/changelog'
    }])
    .withCommand([
      '--url=jdbc:postgresql://postgres:5432/my_api',
      '--username=postgres',
      '--password=ppp',
      '--changeLogFile=db.changelog.xml',
      'update'
    ])
    .withWaitStrategy(Wait.forOneShotStartup())
    .start()

  process.env.POSTGRES_HOST = postgres.getHost()
  process.env.POSTGRES_PORT = String(postgres.getMappedPort(5432))
  process.env.POSTGRES_USER = 'postgres'
  process.env.POSTGRES_PASSWORD = 'ppp'
  process.env.POSTGRES_DB = 'my_api'

  return async () => {
    await migrations.stop()
    await postgres.stop()
    await network.stop()
  }
}
```

Three things are happening here and they are the whole pattern.

**Migrations run in a container on the same network.** The migration tool connects to `postgres:5432` using the network alias, not a mapped port, because it is inside the network. `Wait.forOneShotStartup()` handles a container that runs to completion and exits, rather than one that stays up.

**Ports are mapped dynamically.** `getMappedPort(5432)` returns whatever high port Docker assigned on the host. Nothing is hardcoded, so parallel runs and busy machines do not collide.

**Configuration is injected through the environment.** The application reads its configuration from environment variables at startup, so writing to `process.env` before any test imports the application is enough to point it at the test container. This is the reason environment-based configuration matters: it is what makes the whole pattern work without a test-specific code path.

A cache or broker is usually simpler, with no network and no second container.

```javascript
import { GenericContainer, Wait } from 'testcontainers'

export default async function setup () {
  const redis = await new GenericContainer('redis')
    .withExposedPorts(6379)
    .withWaitStrategy(Wait.forLogMessage('Ready to accept connections'))
    .start()

  process.env.REDIS_HOST = redis.getHost()
  process.env.REDIS_PORT = String(redis.getMappedPort(6379))

  return async () => {
    await redis.stop()
  }
}
```

Choose the wait strategy deliberately. A log message, a health check or a port being open all mean different things, and picking the wrong one produces flaky tests that look like application bugs.

### Debugging a test

Run a single test file with parallelism disabled so the debugger can follow it.

```bash
npx vitest run --inspect --no-file-parallelism test/integration/payments.test.js
```

This is the "Debug current test" configuration shown earlier. Being able to set a breakpoint in a failing integration test, with a real database behind it, is the main practical advantage of running tests on the host.

## Running everything in containers

Choose this when parity matters more than iteration speed: many awkward dependencies, a history of local and CI divergence, or a team that genuinely prefers one command over a fast debugger.

Make the trade explicit in the README, and invest in the debugging setup, because that is where the cost lands.

The mechanics are in the [Docker guidance](docker_guidance.md): the multi-stage image with a `development` target, bind mounting source for reload, isolating compose projects so parallel work does not collide, and the attach configuration needed to debug a process inside a container. The [container standards](../standards/container_standards.md) set out what a Defra image must do.

Four things are worth calling out here, because they are specific to using containers as your inner loop rather than as a deployment artifact.

### Commit the debug configuration

This is the part that usually gets skipped, and it is why container-first developers stop using a debugger.

Two pieces have to line up. The container must start the process with the inspector listening on all interfaces, not just loopback, or it will not accept a connection from the host. The attach configuration must then map the editor's workspace folder to the path inside the container, or breakpoints silently never bind.

Neither is hard, but both are easy to get subtly wrong, and a developer who hits it once tends to fall back to logging rather than debug it. Work it out once and commit it, for every service in the repository.

### Keep the development stage writable

The production stage should remove write permissions from application files and run as a non-root user. Do not carry that into the development stage: watch mode, test runs and coverage reports all need to write to the container filesystem, and a read-only development image breaks the inner loop.

### Keep database volumes out of the test teardown

If tests and development share a compose project, tearing down after a test run destroys the database you were working with. Give the test run its own project name, or its own volume, so `docker compose down -v` after tests does not take your development data with it.

### Expect a rebuild when dependencies change

Source changes reach the container through the bind mount, but a lockfile change does not. This is the recurring cost of the approach, and the main thing that makes the container-first loop slower than a host-native one.

## Orchestrating multiple services

When a team owns several services that are usually run together, put the orchestration in one small repository rather than in each service's README. The pattern below is in use in Defra and works well.

The orchestration repository is not deployable. It exists only to make local development straightforward. Each service repository stays fully self-contained and can still be run on its own.

### Layout

Clone every repository as a sibling, with the orchestration repository alongside them.

```text
repos/
  my-api/
  my-web/
  my-worker/
  my-core/          <- the orchestration repository
```

### A multi-root workspace with shared tasks

The workspace file lists every repository, including the orchestration repository itself, and defines the tasks that run them.

```json
{
  "folders": [
    { "name": "my-api", "path": "../my-api" },
    { "name": "my-web", "path": "../my-web" },
    { "name": "my-worker", "path": "../my-worker" },
    { "name": "my-core", "path": "." }
  ],
  "tasks": {
    "version": "2.0.0",
    "tasks": [
      {
        "label": "Local: my-api",
        "detail": "Start my-api on the host with its dependency containers",
        "type": "shell",
        "command": "trap true INT; npm run local; exec bash",
        "options": { "cwd": "${workspaceFolder:my-api}" },
        "isBackground": true,
        "problemMatcher": [],
        "presentation": {
          "group": "local",
          "panel": "dedicated",
          "reveal": "always"
        }
      },
      {
        "label": "Local: my-web",
        "detail": "Start my-web on the host with its dependency containers",
        "type": "shell",
        "command": "trap true INT; npm run local; exec bash",
        "options": { "cwd": "${workspaceFolder:my-web}" },
        "isBackground": true,
        "problemMatcher": [],
        "presentation": {
          "group": "local",
          "panel": "dedicated",
          "reveal": "always"
        }
      },
      {
        "label": "Local: Start all",
        "detail": "Start every service on the host in parallel",
        "dependsOn": ["Local: my-api", "Local: my-web"],
        "dependsOrder": "parallel",
        "problemMatcher": []
      }
    ]
  }
}
```

A developer opens the workspace, runs **Tasks: Run Task** and picks **Local: Start all**. Every service starts in its own terminal, each bringing up its own dependency containers.

### Keep the terminal alive when you stop a service

This detail matters more than it looks.

```json
"command": "trap true INT; npm run local; exec bash"
```

By default, pressing Ctrl+C in a task terminal kills the shell, VS Code closes the terminal, and you lose the scrollback along with the working directory you had. In a workspace running four services that is a constant irritation.

The command above fixes it in two parts:

- `trap true INT` makes the task shell ignore the interrupt. The interrupt still reaches the application, which stops as expected, but the shell itself survives.
- `exec bash` replaces the shell once the command finishes, so the terminal stays open in the right directory, with its history intact, ready for you to run the service again or run a test.

The result is that Ctrl+C stops the service and leaves you a usable terminal, which is what everyone expects it to do.

Add plain terminal tasks alongside the service tasks so developers can open a shell in each repository without starting anything.

```json
{
  "label": "Terminal: my-api",
  "type": "shell",
  "command": "exec bash",
  "options": { "cwd": "${workspaceFolder:my-api}" },
  "isBackground": true,
  "problemMatcher": [],
  "presentation": { "group": "terminals", "panel": "dedicated" }
}
```

### Orchestration scripts

Keep a small set of scripts in the orchestration repository, all named for what they do.

| Script | Purpose |
| --- | --- |
| `clone` | Clone every service repository as a sibling, skipping any already present |
| `build` | Build the application image for every service |
| `start` | Start the stack, with flags for Docker mode, seeding and test suites |
| `stop` | Stop what `start` started, passing extra arguments through to compose |
| `seed` | Load test data, on the host or through a running container |
| `pull` | Pull the current branch in every repository |
| `update` | Switch every repository to the main branch and pull |
| `open` | Open every repository in the editor |
| `version` | Report the latest release tag for every service |
| `help` | List the available commands |

Every script resolves its own location first, so it works from any directory.

```bash
#!/bin/bash
set -e
projectRoot="$(a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; cd "$a/.." || return; pwd)"
cd "${projectRoot}"
```

Cloning is idempotent, so running it again after a new service is added is safe.

```bash
test -d my-api || git clone https://github.com/DEFRA/my-api.git
test -d my-web || git clone https://github.com/DEFRA/my-web.git
```

The `start` script parses flags rather than taking positional arguments, so options can be combined.

```bash
seed_database=false
use_docker=false

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --docker) use_docker=true ;;
    -s|--seed) seed_database=true ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done
```

Keep the list of services in one place near the top of each script, or in a shared file the scripts read. Repeating the service names in ten scripts means every new service is a ten-file change.

### Compose profiles do the work

The profile from the containerised dependencies pattern is what lets one set of scripts drive both modes.

```bash
docker compose up -d                  # dependencies only, host-native development
docker compose --profile app up -d    # the whole stack in containers
```

Each service's own `npm run local` starts only its dependencies, so a developer can run one service without the orchestration repository at all. The orchestration repository adds convenience, not a requirement.

### Waiting for something to be ready

Compose health checks handle container readiness. They do not tell you that an application has finished starting, which is what a seed script or a journey test actually needs.

For a port, poll it.

```bash
#!/bin/sh
# wait-for.sh host:port [-t timeout] [-- command args]
set -eu

target="${1:?host:port required}"
shift

host="${target%:*}"
port="${target##*:}"
timeout=30

if [ "${1:-}" = "-t" ]; then
  timeout="${2:?timeout value required}"
  shift 2
fi

if [ "${1:-}" = "--" ]; then
  shift
fi

i=0
while [ "$i" -lt "$timeout" ]; do
  if nc -z "$host" "$port" > /dev/null 2>&1; then
    [ "$#" -gt 0 ] && exec "$@"
    exit 0
  fi
  i=$((i + 1))
  sleep 1
done
echo "Timed out waiting for $host:$port" >&2
exit 1
```

For an application that is up but not yet useful, such as one warming a cache, poll the behaviour instead.

```bash
for i in $(seq 1 15); do
  if curl -sf "http://localhost:3001/health/ready" > /dev/null; then
    break
  fi
  sleep 1
done
```

Poll for the condition you actually depend on. A port being open rarely means what you want it to mean.
