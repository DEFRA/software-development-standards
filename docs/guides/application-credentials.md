# Managing Application Credentials

Credentials should never be stored in your application code. Depending on how your application is deployed and what is supported by the deployment environment, credentials should either be:

* Read from the environment via environment variables (see 12 factor)
* Pulled directly from cloud secret stores (AWS Secrets Manager or Azure Key Vault) using appropriate Azure and AWS SDKs

Note: you should continue to use environment variables for configuration that affects application behaviour, such as feature toggles. Pulling values from cloud secret stores should be limited to credentials.

## Changes to credentials

From time to time the credentials you application relies on may expire, requiring your application to obtain updated credentials.

Some SDKs provide tools to automatically refresh credentials (https://learn.microsoft.com/en-us/azure/azure-app-configuration/reload-key-vault-secrets-dotnet)

But in most cases credentials are read on application start-up, either via environment variables or pulled directly from secret stores.

The simplest method therefore is to restart you application when credentials have been updated either in the environment setup of you application or in the cloud secret store.

To reduce the risk that of expired credentials render you application kaput, you should:

**Work with Change Management to create a Standard Change for your application that allows you to restart the application with no code changes for the purpose of reloading updated credentials**
