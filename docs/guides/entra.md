# Entra

Entra is a Microsoft identity and access management platform that provides secure access to applications and resources. It allows organizations to manage user identities, enforce access policies, and protect sensitive data.

It is used to securely authenticate and authorise internal users, enabling them to access applications and resources based on their roles and permissions.

## App Registration

To use Entra, an Azure App Registration needs to be created in the Azure Portal by CCoE.

An App Registration is a representation of an application within the Azure Active Directory (Azure AD) tenant.

Within the App Registration, the following can be configured to enable secure authentication and authorisation:

- **Redirect URIs**: The URLs where users are redirected after authentication and sign out. These URIs must be registered in the App Registration to ensure that the authentication response is sent to the correct location.

- **Client ID**: A unique identifier for the application. It is used to identify the application during the authentication process.

- **Client Secret**: A secret key used to authenticate the application. It should be kept confidential and not exposed in client-side code.

- **Federated Credentials**: An alternative to using a client secret, federated credentials allow the application to authenticate using a certificate or other secure method.  This is the preferred method when using the Core Delivery Platform (CDP) as it avoids the need to store a client secret in the application code.

- **Token Configuration**: The App Registration can be configured to specify the types of tokens (ID tokens, access tokens, refresh tokens) and claims that the application can request and receive during the authentication process.

- **Roles and Permissions**: The App Registration can define roles and permissions that control access to the application. This allows for fine-grained access control based on user roles and responsibilities.

### Enterprise application

When creating a new App Registration, an Enterprise Application is automatically created in the Azure AD tenant. The Enterprise Application represents the application instance and is used to manage access and permissions for users and groups.  eg adding users to roles.

### Tenants

There are two Azure tenants where App Registrations can be created:

#### `O365_DefraDev`

This tenant is used for experimentation, local development and lower environments.

Teams can request/amend an App Registration in this tenant by raising a request with CCoE with this [ServiceNow ticket](https://defragroup.service-now.com/esc?id=sc_cat_item&table=sc_cat_item&sys_id=496b9d931b2cce90848b8594e34bcbe5&recordUrl=com.glideapp.servicecatalog_cat_item_view.do%3Fv%3D1&sysparm_id=496b9d931b2cce90848b8594e34bcbe5).

#### `Defra`

This tenant is used for higher environments including production.

It has a tighter level of control and requires an approved Change Request in ServiceNow to enable CCoE to make a requested change.

A Series of Standard Changes have been created for common App Registration configuration requests.  This allows teams to request changes without needing to raise a Normal Change with the eight day lead time.

> If the configuration required is not covered by a Standard Change, then a Normal Change will need to be raised.

| Standard Change | Description |
|-----------------|-------------|
| [Create App Registration](https://defragroup.service-now.com/change_request.do?sys_id=-1&sysparm_query=chg_model%3de55d0bfec343101035ae3f52c1d3ae49^std_change_producer_version%3decb13db83bf17ed81560dca985e45a54&sysparm_link_parent=d401364f1b7861101fd8337f034bcbf9&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_Service_Catalog&sysparm_view=catalog_Service_Catalog) | Add a new redirect URI to an existing App Registration |
| [Configure redirect URI](https://defragroup.service-now.com/change_request.do?sys_id=-1&sysparm_query=chg_model%3de55d0bfec343101035ae3f52c1d3ae49^std_change_producer_version%3d8b61e8a5fbdd3650ff02f46daeefdc5a&sysparm_link_parent=d401364f1b7861101fd8337f034bcbf9&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_Service_Catalog&sysparm_view=catalog_Service_Catalog) | Configure redirect URI for sign in and sign out |
|[Configure roles](https://defragroup.service-now.com/change_request.do?sys_id=-1&sysparm_query=chg_model%3de55d0bfec343101035ae3f52c1d3ae49^std_change_producer_version%3d247ace93c38f2e5082ee354c050131fd&sysparm_link_parent=d401364f1b7861101fd8337f034bcbf9&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_Service_Catalog&sysparm_view=catalog_Service_Catalog)| Configure roles for the App Registration |
| [Add/remove user/Security Group to role](https://defragroup.service-now.com/change_request.do?sys_id=-1&sysparm_query=chg_model%3de55d0bfec343101035ae3f52c1d3ae49^std_change_producer_version%3deff16ce9fbdd3650ff02f46daeefdcce&sysparm_link_parent=d401364f1b7861101fd8337f034bcbf9&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_Service_Catalog&sysparm_view=catalog_Service_Catalog) | Add or remove a user or Security Group to a role |
| [Configure Graph API Permissions](https://defragroup.service-now.com/change_request.do?sys_id=-1&sysparm_query=chg_model%3de55d0bfec343101035ae3f52c1d3ae49^std_change_producer_version%3d9ba264a5fb117650ff02f46daeefdc19&sysparm_link_parent=d401364f1b7861101fd8337f034bcbf9&sysparm_catalog=e0d08b13c3330100c8b837659bba8fb4&sysparm_catalog_view=catalog_Service_Catalog&sysparm_view=catalog_Service_Catalog) | Configure Graph API permissions for the App Registration **Important:** Admin consent on `User.Read` permission is required and must be requested, otherwise users will not be able to complete authentication. |

## Sign in flow

1. User accesses a service
2. User is redirected to the Entra login page
3. User logs in
4. User is redirected back to the consuming service with an authorisation code
5. Consuming service exchanges the authorisation code for an access token
6. Consuming service stores JWT token in session

## Example

An example repository has been created to demonstrate how to integrate with Entra using Node.js.

The example includes a detailed explanation of the pattern and required code to implement a secure implementation of the pattern.

[https://github.com/DEFRA/fcp-entra-example](https://github.com/DEFRA/fcp-entra-example)

