# Managing Application Credentials

Following good security practice, you must never store credentials in your application code.

This guide provides some best practice to help you manage credentials safely and securely.

## Accessing credentials from your application

Credentials should be stored in cloud secret stores such as AWS Secrets Manager or Azure Key Vault. The Core Delivery Platform provide their own [mechanism for storing secrets](https://portal.cdp-int.defra.cloud/documentation/how-to/secrets.md).

Your application should read credentials in one of the following two ways:

- from environment variables
- directly from cloud secret stores

### Environment variables

You can configure your cloud services to inject the credentials from their secret stores directly into your application's execution environment.

From there, your application can read them exactly like other environment variables.

For more information on using environment variables, see [The Twelve-Factor App guidance on config](https://12factor.net/config).

### Cloud secret stores

You can configure your cloud services to allow your application's execution environment to have direct access to their secret stores.

You can then use the cloud service's native libraries in your code to read credentials directly from the secret store.

You should continue to use environment variables for configuration that affects application behaviour, such as feature toggles.
Pulling values from cloud secret stores should be limited to credentials.

## Changes to credentials

The credentials that your application relies on may expire or need to be changed for other reasons.
When this happens, your application will need to obtain the updated values.

Where provided by your cloud SDK, you should take advantage of automatically refreshing credentials to ensure no interruptions to application up-time.
For example [how to do this for .NET applications in Azure](https://learn.microsoft.com/en-us/azure/azure-app-configuration/reload-key-vault-secrets-dotnet).

In most cases, however, you will need to restart your application to re-read updated environment variables or values within the cloud secret store.
To ensure timely refreshing of credentials and reduce the risk of unnecessary downtime you should:

> Work with Change Management to create a Standard Change for your application. This Standard Change should as a minimum allow you to redeploy the application with no code changes, and can be used to update credentials and restart a crashed application.