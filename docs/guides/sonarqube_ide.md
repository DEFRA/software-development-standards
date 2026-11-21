# SonarQube for IDE

[SonarQube for IDE](https://www.sonarsource.com/products/sonarlint/) is an IDE extension that identifies code quality issues as you code, providing immediate feedback before committing.

Running analysis locally, rather than waiting for a CI pipeline or a reviewer to flag issues, means you can:

- fix bugs, code smells and security vulnerabilities as you introduce them, when the context is still fresh in your mind
- avoid pull requests being blocked or sent back for issues that a quick local check would have caught
- spend review time on design and logic, rather than on issues a linter could have found
- learn the reasoning behind each rule from inline explanations, rather than just being told something is wrong

All Defra projects are required to set up their repositories within the [SonarQube Cloud Defra organisation](https://sonarcloud.io/organizations/defra/projects). Using the IDE extension in connected mode ensures you get the same rules and quality gates locally as in CI, so there are no surprises when your code reaches the pipeline.

## Dependencies

- Java Runtime Environment v21+

With Ubuntu (including WSL), install the open source JRE:

```bash
sudo apt-get install openjdk-21-jre
```

## VS Code setup

1. Install the [SonarQube for IDE](https://marketplace.visualstudio.com/items?itemName=SonarSource.sonarlint-vscode) extension.

2. Set the JRE location in VS Code settings:

```json
{
  "sonarlint.ls.javaHome": "/usr/lib/jvm/java-21-openjdk-amd64"
}
```

This gives you Sonar code analysis using default quality gates for supported languages.

## Connected mode

Connected mode binds the extension to your actual project in SonarQube Cloud. This ensures the IDE uses the same rules, quality gates, and exclusions as the SonarQube project configured for your repository.

Follow the [connected mode setup documentation](https://docs.sonarsource.com/sonarqube-for-ide/vs-code/team-features/connected-mode-setup/#connection-setup) to connect your SonarQube for IDE extension to the SonarQube Cloud project.
