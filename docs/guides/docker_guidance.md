# Docker

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably across multiple environments. Docker is a tool to build and run these containers.

## Local development principles

- Teams must not constrain their local development setup to a specific device or operating system to maintain developer mobility and agility.
- Local development should maximise the use of emulation and avoid tight coupling to cloud services where possible.
- Repositories should include full instructions for anyone to be able to easily run the service locally.
- Keep the local setup lean. Favour a single Compose file per repository over many overlapping variants, and prefer built-in tooling (for example Node's native watch and `--env-file`) over extra dependencies.

## More information

[Docker introduction on docker.com](https://www.docker.com/resources/what-container)

## Terminology

`Dockerfile` - set of instructions for building a Docker image  
`Image` - a constructed set of layered Docker instructions  
`Container` - a running instance of an image  
`Compose file` - a `compose.yaml` file describing how to build and run one or more services

> **Docker Compose v1 has reached end of life.** Use the Compose v2 plugin, invoked as `docker compose` (with a space), not the standalone `docker-compose` binary. The canonical Compose filename is `compose.yaml`, and the top-level `version:` key is obsolete and should be omitted.

## Base images

Defra publishes hardened base images that provide a non-root user, CA certificates, and the debugging tooling needed for local development. 

These images are scanned for vulnerabilities daily using [Trivy](https://github.com/aquasecurity/trivy) and [Grype](https://github.com/anchore/grype).

Build on these rather than the raw upstream images:

- [defra-docker-node](https://github.com/DEFRA/defra-docker-node) - Node.js (`defradigital/node` and `defradigital/node-development`)
- [defra-docker-dotnetcore](https://github.com/DEFRA/defra-docker-dotnetcore) - .NET (`defradigital/dotnetcore` and `defradigital/dotnetcore-development`)

Always pin the base image version. Never depend on `latest`, as an unpinned tag makes builds non-reproducible and can pull in unexpected changes.

## Multi stage builds

Dockerfiles should implement multi stage builds so that different stages can be targeted for specific purposes. A production image does not need dev dependencies, test files, or a watch command, whereas a development image does.

The example below uses the Defra Node.js base image. It has two stages: `development` (used locally, with dev dependencies and hot reload) and `production` (the lean deployable artifact).

```dockerfile
ARG PARENT_VERSION=3.1.1-node24.18.0
ARG PORT=3000
ARG PORT_DEBUG=9229

FROM defradigital/node-development:${PARENT_VERSION} AS development

ENV TZ="Europe/London"

ARG PORT
ARG PORT_DEBUG
ENV PORT=${PORT}
EXPOSE ${PORT} ${PORT_DEBUG}

COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .

CMD [ "npm", "run", "dev" ]

FROM defradigital/node:${PARENT_VERSION} AS production

ENV TZ="Europe/London"

USER root

COPY --from=development --chown=root:root /home/node/package*.json ./
COPY --from=development --chown=root:root /home/node/app/ ./app/

RUN npm ci --omit=dev

# Remove write permissions from application files
RUN chmod -R a-w /home/node

USER node

ARG PORT
ENV PORT=${PORT}
EXPOSE ${PORT}

CMD [ "node", "app" ]
```

Notes on this example:

- **Pin the base image** with `ARG PARENT_VERSION` and use the same version for both stages. `3.1.1-node24.18.0` is the current Node 24 (LTS) Defra base at the time of writing. Check [defra-docker-node](https://github.com/DEFRA/defra-docker-node) for the latest.
- **Use `npm ci`, not `npm install`.** `npm ci` installs exactly what is in `package-lock.json`, giving reproducible builds. Use `npm ci --omit=dev` in production to exclude dev dependencies.
- **Set `ENV TZ`** so container timestamps match the expected timezone.

## Security best practices

### Run as a non-root user

Containers must run as a non-root user. The Defra base images provide a `node` user (and a `dotnet` user for .NET). Switch to it with `USER node` before the container's `CMD` runs so the process has the least privilege it needs.

### File ownership and write permissions

Security scanners such as SonarQube flag application files that the running user can write to (see [SonarSource rule S6504](https://rules.sonarsource.com/docker/type/Security%20Hotspot/RSPEC-6504/)). A running process should not be able to modify its own application code, as this reduces the impact of a compromised process.

`COPY --chown=node:node` makes the running `node` user the owner, which grants write access. `COPY` also preserves the source file permissions, so changing ownership alone does not reliably remove write access. To guarantee read-only application files in the **production** stage:

1. Copy files as `root` with `COPY --chown=root:root`.
2. Explicitly remove write permissions with `RUN chmod -R a-w /home/node`.
3. Switch to the non-root user with `USER node`.

Because the `node` user neither owns the files nor has write permission, the application code is read-only at runtime. This is preferable to `chmod 755`, which still leaves the owner able to write.

```dockerfile
COPY --from=development --chown=root:root /home/node/app/ ./app/
RUN npm ci --omit=dev
RUN chmod -R a-w /home/node
USER node
```

> **Apply read-only ownership to the production stage only.** In the `development` stage keep `COPY --chown=node:node` and do **not** run `chmod -R a-w`. Watch mode, tests, and coverage reports all need to write to the container filesystem, so a read-only development image breaks the inner loop. Scanners may flag the development stage for the missing `chmod`; that is acceptable for a local-only image.

> **Some processes legitimately need to write at runtime.** A service might write to a mounted `tmp` directory or a cache such as `node_modules/.cache`. Where this is required, define and secure those specific writable locations (for example a dedicated mounted volume) rather than making the whole application tree writable. Consider whether your service has this need before applying blanket read-only permissions.

## Docker Compose

Use a single `compose.yaml` per repository. Older services may split configuration across many files (`docker-compose.override.yaml`, `docker-compose.test.yaml`, `docker-compose.test.watch.yaml`, and so on), which drift out of sync and are hard to reason about. Compose v2 profiles remove the need for most of these.

### One file with profiles

Put the application service behind a profile so that `docker compose up` starts only the backing dependencies, and the full stack starts on demand:

```yaml
services:
  my-service:
    profiles: ["app"]
    build:
      context: .
      target: development
    ports:
      - "3000:3000"
      - "9229:9229"
    env_file:
      - .env
    environment:
      REDIS_HOST: redis
    depends_on:
      redis:
        condition: service_healthy
    volumes:
      - ./app:/home/node/app
    networks:
      - my-network

  redis:
    image: redis
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 3s
      retries: 5
    networks:
      - my-network

networks:
  my-network:
    driver: bridge
    name: my-network
```

Start dependencies only, or the whole stack:

```bash
docker compose up -d                 # start dependencies only (Redis here)
docker compose --profile app up -d   # start dependencies and the application
```

Gating the app behind `profiles: ["app"]` supports the common local workflow of running the app itself on the host (or in your IDE) while its dependencies run in containers, and still lets an orchestration repo bring up the whole stack with `--profile app`.

### Layer environment variables

Use `env_file` for developer-supplied values and `environment` for the few values that must differ inside Docker (typically service hostnames). The `environment` block takes precedence over `env_file`:

```yaml
    env_file:
      - .env                       # e.g. REDIS_HOST=localhost for host-native dev
    environment:
      REDIS_HOST: redis            # inside Docker the dependency is on its service name
```

This removes the old pattern of duplicating every variable across a base file and an override file. Keep `.env` out of source control and out of images by listing it in both `.gitignore` and `.dockerignore`, and commit a `.env.example` instead.

### Health checks and start ordering

Give each dependency a `healthcheck` and make the app `depends_on` it with `condition: service_healthy`. Without this, the app can start before the dependency is ready and fail to connect:

```yaml
  postgres:
    image: postgres:16.6
    environment:
      POSTGRES_DB: my_database
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d my_database"]
      interval: 10s
      timeout: 10s
      retries: 5
```

### Set image and container names

If you do not set an image or container name, Compose derives one from the project and service names, which can be unpredictable. Set them explicitly where you need to reference the container later:

```yaml
services:
  my-service:
    image: my-service
    container_name: my-service
```

### Preserving database volumes

Integration tests that run against a containerised database write and delete data. To keep test data separate from local development data, declare the persistent volume only where you want persistence rather than in a shared base definition. For most repositories, prefer [Testcontainers](#running-tests) for integration tests, which gives each run a fresh, isolated database with no volume management at all.

### .dockerignore

A `.dockerignore` file prevents local files being copied into an image during build. This keeps images small and avoids copying artifacts such as `node_modules`, local `.env` files, and test files.

For a typical Node.js service:

```
node_modules
Dockerfile
.dockerignore
.git
.env
coverage
**/*.test.js
LICENCE
README.md
```

## Local development workflow

The recommended inner loop runs the application with hot reload while its dependencies run in containers. Running the app itself on the host (rather than in a container) gives the fastest feedback and the simplest debugging, because there is no rebuild or bind-mount sync on each change and the debugger attaches to a local process.

### Hot reload with Node's native watch

Node 24 has built-in watch mode, so a separate tool such as nodemon is no longer needed. Use `node --watch` (restart on change) and `--watch-path` to scope what triggers a restart:

```json
"scripts": {
    "dev": "node --watch --watch-path=./app --env-file-if-exists=.env app",
    "dev:debug": "node --watch --watch-path=./app --inspect --env-file-if-exists=.env app",
    "start": "node app",
    "test": "node --test",
    "test:watch": "node --test --watch"
}
```

`--env-file-if-exists=.env` loads a local `.env` when present and is a no-op when it is absent, so the same script works locally and in deployed environments where platform environment variables are provided directly. Use the `-if-exists` variant so a missing file does not error.

If you run the app inside a container instead, mount the source you want watched as a volume in the Compose file so changes are picked up without a rebuild:

```yaml
volumes:
  - ./app:/home/node/app
```

Bind only what needs watching. It is not beneficial to bind `node_modules` or a `README`.

### Avoiding port conflicts

When running multiple services locally, each must bind to a unique host port. Map container ports to different host ports per service, and do the same for dependency containers:

```yaml
# service 1
ports:
  - "3000:3000"
  - "9229:9229"

# service 2
ports:
  - "3001:3000"
  - "9230:9229"
```

Do not expose ports on containers used only in CI, as they may conflict with ports already in use on the build agent.

## Running tests

Prefer running unit tests on the host for speed. For integration tests that need real infrastructure (a database, cache, or message broker), use [Testcontainers](https://testcontainers.com/) to start that infrastructure programmatically from within the test process. This replaces the older approach of maintaining separate `docker-compose.test*.yaml` files.

Testcontainers gives each test run a fresh, isolated dependency, and the same code path runs locally and in CI (GitHub-hosted runners provide a Docker daemon). Because there are no test-specific Compose files to keep in sync, and no shared volumes to reset, tests are both simpler and more reliable.

```js
import { GenericContainer, Wait } from 'testcontainers'

const redis = await new GenericContainer('redis')
  .withExposedPorts(6379)
  .withWaitStrategy(Wait.forLogMessage('Ready to accept connections'))
  .start()

process.env.REDIS_HOST = redis.getHost()
process.env.REDIS_PORT = String(redis.getMappedPort(6379))
```

Tests need a running Docker daemon but do not need `docker compose up` first.

## Debugging in VS Code

The simplest option is to run the app on the host and debug it directly with a normal launch configuration (inspector bound to `127.0.0.1`). Where you need to debug the process running inside a container, use an attach configuration.

Add debug configurations to `.vscode/launch.json`.

### Attach to a Node process in a running container

The container must run the app with the inspector enabled (for example `node --inspect=0.0.0.0` on the debug port exposed in the Compose file).

```json
{
  "name": "Docker: Attach",
  "type": "node",
  "request": "attach",
  "restart": true,
  "port": 9229,
  "remoteRoot": "/home/node",
  "skipFiles": [
    "<node_internals>/**",
    "**/node_modules/**"
  ]
}
```

`restart: true` reattaches the debugger when watch mode restarts the app.

When running several services together, give each a unique host debug port (for example 9229, 9230, 9231) mapped to the container's inspector port, so you can attach to more than one at a time.

## Debugging .NET in a Linux container

.NET services running in Linux containers are debugged with the `vsdbg` remote debugger. `vsdbg` is not part of the .NET SDK, so it must be present in the image. The Defra .NET development base image ([defra-docker-dotnetcore](https://github.com/DEFRA/defra-docker-dotnetcore)) already installs it (at `/vsdbg`), so services built on `defradigital/dotnetcore-development` do not need to add it. This remains the case for .NET 10. If you build on the plain Microsoft SDK image instead, install it yourself in the development stage:

```dockerfile
ADD https://aka.ms/getvsdbgsh /tmp/getvsdbgsh
RUN /bin/sh /tmp/getvsdbgsh -v latest -l /vsdbg && rm /tmp/getvsdbgsh
```

### VS Code

```json
{
  "name": ".NET Core Docker Attach",
  "type": "coreclr",
  "request": "attach",
  "processId": "${command:pickRemoteProcess}",
  "pipeTransport": {
    "pipeProgram": "docker",
    "pipeArgs": ["exec", "-i", "my-service-container"],
    "debuggerPath": "/vsdbg/vsdbg",
    "pipeCwd": "${workspaceRoot}",
    "quoteArgs": false
  },
  "sourceFileMap": {
    "/home/dotnet": "${workspaceFolder}"
  }
}
```

### Visual Studio

Visual Studio does not integrate with the WSL filesystem, so WSL users must clone the repository in Windows to debug using Visual Studio. Set the following git configuration to preserve line endings:

```bash
git config --global core.autocrlf input
```

1. Start the container with `docker compose up --build`.
2. In Visual Studio, select `Debug -> Attach to process`.
3. Select `Docker (Linux Container)` for connection type.
4. Enter the container name in connection target.
5. Select the process matching the running application.
6. Select `Managed (.NET Core for Unix)` code type.

## Windows Git Bash

Git Bash may not correctly interpret volume paths when running Docker Compose on Windows. To avoid this, add the following to the `.bashrc` in the home directory of the user running Git Bash:

```bash
# --- Make Docker work nicely in Git Bash ---

# Prevent MSYS from mangling paths
__docker_env() {
  MSYS_NO_PATHCONV=1 MSYS2_ARG_CONV_EXCL='*' "$@"
}

# Wrapper for docker.exe
docker() {
  local needs_winpty=
  for a in "$@"; do
    [[ "$a" == "-it" || "$a" == "-i" || "$a" == "-t" ]] && needs_winpty=1
  done

  if [[ -n "$needs_winpty" ]] && command -v winpty >/dev/null 2>&1; then
    __docker_env winpty docker.exe "$@"
  else
    __docker_env docker.exe "$@"
  fi
}
```

## References

- [defra-docker-node](https://github.com/DEFRA/defra-docker-node) - Defra Node.js base images
- [defra-docker-dotnetcore](https://github.com/DEFRA/defra-docker-dotnetcore) - Defra .NET base images
- [local development refactoring playbook](https://github.com/johnwatson484/local-dev-refactoring) - host-native inner loop with Testcontainers
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [Testcontainers](https://testcontainers.com/)
