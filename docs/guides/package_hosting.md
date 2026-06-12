# Package hosting

A reusable library is a versioned, packaged unit of code designed to be shared across multiple projects or consumers.

## What is a reusable library

Two package ecosystems align to Defra's primary technology choices.

**npm** packages are used in JavaScript and TypeScript projects. They are hosted on [npmjs.com](https://www.npmjs.com) and installed using the `npm` command. Packages can be scoped to an organisation, such as `@defra/your-package`.

**NuGet** packages are used in .NET projects. They are hosted on [nuget.org](https://www.nuget.org) and installed using the `dotnet add package` command. Packages are grouped under an organisation, such as `DefraDigital.YourPackage`.

## When a reusable library can be useful

A shared library makes sense when the code genuinely needs to be used in more than one place and has a clear, stable purpose.

Common use cases:

- **Public reuse** — sharing code openly so other teams, ALBs or the wider public can benefit from work already done
- **Supporting integrations** — publishing a client library or SDK for a Defra API or platform service, so consumers do not need to implement the integration themselves
- **Development kits** — bundling shared tooling such as linting configs, test utilities or scaffolding helpers that all teams can adopt consistently
- **Reusable components and config** — packaging common UI components, shared configuration schemas or middleware so they stay in sync across services
- **Abstracting sensitive code** — isolating code that contains sensitive logic into a private library, so the consuming service can remain open source without exposing that code
- **Cross-cutting concerns** — encapsulating common patterns such as audit publishing, messaging wrappers or authentication helpers that many services need but should not each implement independently

## When not to use a shared library

A shared library adds maintenance overhead. It introduces a versioning contract and requires consumers to manage upgrades. Before creating one, consider whether the benefit justifies that cost.

Avoid creating a shared library when:

- only one service will ever use the code — copy it instead, and revisit if a second consumer appears
- the code is tightly coupled to a specific service's business logic and would not make sense elsewhere
- you are sharing environment-specific configuration or secrets — use environment variables or a secrets manager instead
- the package would be a utilities dumping ground with no single clear responsibility
- the code changes frequently in breaking ways, creating an ongoing upgrade burden for consumers
- the sole reason to extract it is to avoid making the consuming application open source — this is not sufficient justification on its own

## Where to host a shared library

Use the ecosystem's native registry by default — npmjs.com for npm packages and nuget.org for NuGet packages. These registries are well supported, encourage good security practices and offer low-friction adoption for consumers. They also support Defra's commitment to working in the open and publishing code openly.

For libraries containing sensitive or private code, use GitHub Packages instead.

### npm

Publish npm packages to [npmjs.com](https://www.npmjs.com) under the `@defra` organisation scope.

For onboarding, contact `#npm-support` in Slack: https://defra-digital.slack.com/archives/C0BA4SW20NS. Defra npm org admins can be found there.

A Defra npm org admin must perform the first publish of any new `@defra`-scoped package. After that, your npm account can be made admin of the specific package. Teams can also be created within the organisation to manage access to one or more packages.

Use **Trusted Publishing** to publish from GitHub Actions without storing a long-lived npm access token in GitHub secrets. This uses OpenID Connect (OIDC) so the registry can verify the publish came from a specific GitHub Actions workflow.

See [fcp-audit-publisher](https://github.com/DEFRA/fcp-audit-publisher) as a working example.

#### Steps to set up a new npm package with Trusted Publishing

**1. Create a repository**

Create a new GitHub repository under the DEFRA organisation following the standard repository setup guidance.

**2. Initialise the package**

```bash
npm init
```

Set the `name` field in `package.json` to use the `@defra` scope:

```json
{
  "name": "@defra/your-package-name",
  "version": "1.0.0"
}
```

**3. Add a CI workflow to check pull requests**

Create `.github/workflows/check-pull-request.yml`. This workflow should build, test and enforce that the version in `package.json` has been incremented before a pull request can be merged.

Key version check steps:

```yaml
- name: Get package version
  id: package-version
  run: echo "version=$(node -p "require('./package.json').version")" >> $GITHUB_OUTPUT

- name: Get base branch version
  id: base-version
  run: |
    git fetch origin main --depth=1
    echo "version=$(git show origin/main:package.json | node -p "JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).version")" >> $GITHUB_OUTPUT

- name: Check version incremented
  run: |
    PR_VERSION="${{ steps.package-version.outputs.version }}"
    BASE_VERSION="${{ steps.base-version.outputs.version }}"
    node -e "
      const [a, b] = ['$PR_VERSION', '$BASE_VERSION'].map(v => v.split('.').map(Number));
      const isGreater = a[0] > b[0] || (a[0] === b[0] && a[1] > b[1]) || (a[0] === b[0] && a[1] === b[1] && a[2] > b[2]);
      if (!isGreater) {
        console.error('::error::Version in package.json ($PR_VERSION) must be greater than the base branch version ($BASE_VERSION)');
        process.exit(1);
      }
    "
```

**4. Add a publish workflow**

Create `.github/workflows/publish.yml`. The workflow needs `id-token: write` permission for OIDC authentication with npmjs.com:

```yaml
name: Publish to npm

on:
  push:
    branches:
      - main

permissions:
  id-token: write
  contents: read

jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      id-token: write
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-node@v4
        with:
          node-version: 24
          registry-url: "https://registry.npmjs.org"

      - run: npm ci
      - run: npm run build
      - run: npm test

      - name: Get package version
        id: package-version
        run: echo "version=$(node -p "require('./package.json').version")" >> $GITHUB_OUTPUT

      - name: Check if version exists on npm
        id: check-version
        run: |
          if npm view @defra/your-package-name@${{ steps.package-version.outputs.version }} version 2>/dev/null; then
            echo "exists=true" >> $GITHUB_OUTPUT
          else
            echo "exists=false" >> $GITHUB_OUTPUT
          fi

      - name: Publish to npm
        if: steps.check-version.outputs.exists == 'false'
        run: npm publish --access public
```

Replace `@defra/your-package-name` with your actual package name.

**5. Contact `#npm-support` to request onboarding**

Before the first publish, contact `#npm-support` in Slack with:

- your npm username
- the GitHub repository that will publish the package
- the proposed package name (for example `@defra/your-package-name`)
- confirmation the package is suitable for public publishing

A Defra npm org admin will configure the Trusted Publishing policy on npmjs.com and perform the first publish.

**6. First publish**

The first publish of any `@defra`-scoped package must be done by a Defra npm org admin. Once published, your account can be made admin of the package. After that, publishing happens automatically whenever a pull request is merged to `main`.

### NuGet

Publish NuGet packages to [nuget.org](https://www.nuget.org) under the [Defra NuGet organisation](https://www.nuget.org/profiles/Defra).

The `Defra` package ID prefix is reserved on NuGet.org and package IDs using it may be rejected. Use the `DefraDigital` prefix instead:

```text
DefraDigital.YourPackage
DefraDigital.Team.Component
```

For onboarding, contact `#nuget-support` in Slack. A Defra NuGet org admin will add you as a Collaborator to the Defra organisation on NuGet.org.

Use **Trusted Publishing** via the `NuGet/login` GitHub Action. This allows GitHub Actions to publish to NuGet.org without storing a long-lived API key in GitHub secrets.

See [defra-nuget-example](https://github.com/DEFRA/defra-nuget-example) for a full working example and detailed guidance.

#### Steps to set up a new NuGet package with Trusted Publishing

**1. Request access**

Contact `#nuget-support` in Slack with:

- your NuGet.org username
- your team name
- the GitHub repository that will publish the package
- the proposed package ID (for example `DefraDigital.YourPackage`)
- confirmation the package is suitable for public publishing

Make sure your NuGet.org account uses a secure Microsoft account with MFA enabled.

**2. Create a repository and project**

Create a new GitHub repository under the DEFRA organisation, then create a solution, class library and test project:

```bash
dotnet new sln --name DefraDigital.YourPackage

dotnet new classlib \
  --name DefraDigital.YourPackage \
  --output DefraDigital.YourPackage

dotnet new xunit \
  --name DefraDigital.YourPackage.Tests \
  --output DefraDigital.YourPackage.Tests

dotnet sln add DefraDigital.YourPackage/DefraDigital.YourPackage.csproj
dotnet sln add DefraDigital.YourPackage.Tests/DefraDigital.YourPackage.Tests.csproj

dotnet add DefraDigital.YourPackage.Tests/DefraDigital.YourPackage.Tests.csproj \
  reference DefraDigital.YourPackage/DefraDigital.YourPackage.csproj
```

Replace `DefraDigital.YourPackage` with your actual package ID.

**3. Add package metadata to the `.csproj`**

```xml
<PackageId>DefraDigital.YourPackage</PackageId>
<Version>0.1.0</Version>
<Authors>Authors</Authors>
<Company>Defra</Company>
<Description>A short description of what the package does.</Description>
<PackageTags>defra;dotnet</PackageTags>

<PackageProjectUrl>https://github.com/DEFRA/your-repo</PackageProjectUrl>
<RepositoryUrl>https://github.com/DEFRA/your-repo</RepositoryUrl>
<RepositoryType>git</RepositoryType>

<PackageLicenseFile>LICENCE</PackageLicenseFile>
<PackageReadmeFile>README.md</PackageReadmeFile>
<GenerateDocumentationFile>true</GenerateDocumentationFile>
```

Include the licence and README in the package:

```xml
<ItemGroup>
  <None Include="../LICENCE" Pack="true" PackagePath="\" />
  <None Include="../README.md" Pack="true" PackagePath="\" />
</ItemGroup>
```

NuGet package IDs are immutable once published. You cannot rename a package after publishing; you would need to publish a new package with a different ID.

**4. Add a CI workflow to check pull requests**

Create `.github/workflows/check-pull-request.yml`. This should build, test and verify the `<Version>` in the `.csproj` has been incremented before a pull request can be merged.

Key version check steps:

```yaml
- name: Get current version
  id: current-version
  run: |
    echo "version=$(grep -oP '(?<=<Version>)[^<]+' DefraDigital.YourPackage/DefraDigital.YourPackage.csproj)" >> $GITHUB_OUTPUT

- name: Get main branch version
  id: base-version
  run: |
    git fetch origin main --depth=1
    echo "version=$(git show origin/main:DefraDigital.YourPackage/DefraDigital.YourPackage.csproj | grep -oP '(?<=<Version>)[^<]+')" >> $GITHUB_OUTPUT

- name: Check version incremented
  run: |
    CURRENT="${{ steps.current-version.outputs.version }}"
    BASE="${{ steps.base-version.outputs.version }}"
    IFS='.' read -r -a CURRENT_PARTS <<< "$CURRENT"
    IFS='.' read -r -a BASE_PARTS <<< "$BASE"
    if [[ ${CURRENT_PARTS[0]} -gt ${BASE_PARTS[0]} ]] || \
       [[ ${CURRENT_PARTS[0]} -eq ${BASE_PARTS[0]} && ${CURRENT_PARTS[1]} -gt ${BASE_PARTS[1]} ]] || \
       [[ ${CURRENT_PARTS[0]} -eq ${BASE_PARTS[0]} && ${CURRENT_PARTS[1]} -eq ${BASE_PARTS[1]} && ${CURRENT_PARTS[2]} -gt ${BASE_PARTS[2]} ]]; then
      echo "Version $CURRENT is greater than base $BASE"
    else
      echo "::error::Version in .csproj ($CURRENT) must be greater than the base branch version ($BASE)"
      exit 1
    fi
```

Replace `DefraDigital.YourPackage` with your package ID and project path.

**5. Add a publish workflow**

Create `.github/workflows/publish.yml`:

```yaml
name: Publish NuGet package

on:
  workflow_dispatch:
  push:
    branches:
      - main

jobs:
  publish:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      id-token: write
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-dotnet@v4
        with:
          dotnet-version: '10.0.x'

      - run: dotnet restore
      - run: dotnet build --configuration Release --no-restore
      - run: dotnet test --configuration Release --no-build

      - name: Pack
        run: dotnet pack DefraDigital.YourPackage/DefraDigital.YourPackage.csproj --configuration Release --no-build --output artifacts

      - name: NuGet login
        id: login
        uses: NuGet/login-action@v1
        with:
          user: ${{ secrets.NUGET_USERNAME }}

      - name: Push to NuGet.org
        run: dotnet nuget push "artifacts/*.nupkg" --api-key "${{ steps.login.outputs.NUGET_API_KEY }}" --source https://api.nuget.org/v3/index.json --skip-duplicate
```

Replace `DefraDigital.YourPackage` with your package ID and project path.

**6. Add the `NUGET_USERNAME` secret**

Add a GitHub Actions secret named `NUGET_USERNAME`. The value must be the NuGet.org username of the person who will create the Trusted Publishing policy. It should be a NuGet.org username, not an email address, Microsoft account login or GitHub username.

**7. Set up Trusted Publishing on NuGet.org**

Sign in to NuGet.org as the user whose username you set in `NUGET_USERNAME`:

1. Go to **Trusted Publishing**.
2. Add a new policy.
3. Set the package owner to the **Defra** organisation.
4. Enter the GitHub repository details.
5. Enter the workflow file name — use only the file name, not the full path.

Example policy values:

```text
Package owner:      Defra
Repository owner:   DEFRA
Repository:         your-repo-name
Workflow file:      publish.yml
```

Leave the environment field blank if the publish workflow does not specify a GitHub environment.

**8. Merge to publish**

Publishing happens automatically when a pull request is merged to `main`. Increment the `<Version>` in the `.csproj` in every pull request that should result in a new published version. The CI check will block the merge if you have not.

### GitHub Packages

Use [GitHub Packages](https://docs.github.com/en/packages) when your library contains sensitive or private code that should not be published to a public registry.

GitHub Packages supports both npm and NuGet. Access is controlled by GitHub repository permissions, so packages remain private to your organisation by default.

#### npm

Add a `publishConfig` entry to `package.json` to point to the GitHub Packages registry:

```json
{
  "name": "@DEFRA/your-package-name",
  "publishConfig": {
    "registry": "https://npm.pkg.github.com"
  }
}
```

In your publish workflow, configure `actions/setup-node` to use the GitHub Packages registry and authenticate with `GITHUB_TOKEN`:

```yaml
- uses: actions/setup-node@v4
  with:
    node-version: 24
    registry-url: "https://npm.pkg.github.com"
    scope: "@DEFRA"

- run: npm publish
  env:
    NODE_AUTH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

Consumers must authenticate to install the package. They will need a GitHub personal access token with `read:packages` scope configured in their local `.npmrc`:

```text
//npm.pkg.github.com/:_authToken=YOUR_GITHUB_PAT
@DEFRA:registry=https://npm.pkg.github.com
```

#### NuGet

In your publish workflow, push to the GitHub Packages NuGet registry using `GITHUB_TOKEN`:

```yaml
- name: Push to GitHub Packages
  run: |
    dotnet nuget push "artifacts/*.nupkg" \
      --source "https://nuget.pkg.github.com/DEFRA/index.json" \
      --api-key ${{ secrets.GITHUB_TOKEN }} \
      --skip-duplicate
```

Consumers must add the GitHub Packages source before they can restore or install the package:

```bash
dotnet nuget add source \
  --username YOUR_GITHUB_USERNAME \
  --password YOUR_GITHUB_PAT \
  --store-password-in-clear-text \
  --name github \
  "https://nuget.pkg.github.com/DEFRA/index.json"
```

Replace `YOUR_GITHUB_PAT` with a GitHub personal access token with `read:packages` scope.
