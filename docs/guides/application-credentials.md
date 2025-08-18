# Managing Application Credentials

Credentials should never be stored in your application code. Credentials should either be:

* Delivered to the environment where you application is hosted and read into environment variables (see The Twelve-Factor App [guidance on config](https://12factor.net/config))
* Pulled directly from cloud secret stores (AWS Secrets Manager or Azure Key Vault) within your application at start-up using appropriate Azure and AWS SDKs

You should continue to use environment variables for configuration that affects application behaviour, such as feature toggles. Pulling values from cloud secret stores should be limited to credentials.

## Changes to credentials

From time to time the credentials you application relies on may expire, requiring your application to obtain updated credentials.

Where provided by your cloud SDK, you should take advantage of automatically refreshing credentials (see [for example](https://learn.microsoft.com/en-us/azure/azure-app-configuration/reload-key-vault-secrets-dotnet)) to ensure no interruptions to application up-time.

In most cases, however, you will need to restart the application to re-read updated environment variables or values within the cloud secret store. To ensure timely refreshing of credentials and reduce the risk of unnecessary downtime you should:

> Work with Change Management to create a Standard Change for your application. This Standard Change should simply allow you to restart the application with no code changes, and be used solely for the purpose of reloading updated credentials and restarting a crashed application.
