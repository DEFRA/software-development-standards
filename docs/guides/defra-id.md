# Defra Identity

Defra Identity is Defra's common customer authentication and identity-management platform that provides external user authentication and authorisation for Defra services. It is based on the OAuth 2.0 and OpenID Connect standards and is backed by Azure B2C.

Defra Identity supports authentication through a Government Gateway, GOV.UK One Login or Rural Payments account.

## Sign in flow

1. User accesses a service
2. User is redirected to the Defra Identity login page
3. User logs in
4. User selects an organisation
5. User is redirected back to the consuming service with an authorisation code
6. Consuming service exchanges the authorisation code for an access token
7. Consuming service stores JWT token in session

Services using the Rural Payments account need an additional step to retrieve the user's permissions for the selected organisation from Siti Agri as they are not included in the JWT token.

## Example

An example repository has been created to demonstrate how to integrate with Defra Identity using Node.js.

The example includes a detailed explanation of the pattern and required code to implement a secure implementation of the pattern.

Although written from the perspective of Farming, the example is applicable to any service that needs to integrate with Defra Identity.

[https://github.com/DEFRA/fcp-defra-id-example](https://github.com/DEFRA/fcp-defra-id-example)
