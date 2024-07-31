# AuthorizationService Schema

```txt
airs_model#/$defs/AuthorizationService
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                   |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :--------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [model.schema.json\*](../../../out/model.schema.json "open original schema") |

## AuthorizationService Type

`object` ([AuthorizationService](model-defs-authorizationservice.md))

# AuthorizationService Properties

| Property                         | Type   | Required | Nullable       | Defined by                                                                                                                                                      |
| :------------------------------- | :----- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [token\_url](#token_url)         | Merged | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md "airs_model#/$defs/AuthorizationService/properties/token_url") |
| [client\_id](#client_id)         | Merged | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-client-id.md "airs_model#/$defs/AuthorizationService/properties/client_id")                               |
| [client\_secret](#client_secret) | Merged | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-client-secret.md "airs_model#/$defs/AuthorizationService/properties/client_secret")                       |
| [grant\_type](#grant_type)       | Merged | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-grant-type-eg-password.md "airs_model#/$defs/AuthorizationService/properties/grant_type")                 |
| [arlas\_iam](#arlas_iam)         | Merged | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md "airs_model#/$defs/AuthorizationService/properties/arlas_iam")              |

## token\_url



`token_url`

*   is optional

*   Type: merged type ([Token URL of the authentication service](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md "airs_model#/$defs/AuthorizationService/properties/token_url")

### token\_url Type

merged type ([Token URL of the authentication service](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md))

all of

*   [Resource](model-defs-resource.md "check type definition")

## client\_id



`client_id`

*   is optional

*   Type: merged type ([Client ID](model-defs-authorizationservice-properties-client-id.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-client-id.md "airs_model#/$defs/AuthorizationService/properties/client_id")

### client\_id Type

merged type ([Client ID](model-defs-authorizationservice-properties-client-id.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-client-id-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-client-id-anyof-1.md "check type definition")

## client\_secret



`client_secret`

*   is optional

*   Type: merged type ([Client secret](model-defs-authorizationservice-properties-client-secret.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-client-secret.md "airs_model#/$defs/AuthorizationService/properties/client_secret")

### client\_secret Type

merged type ([Client secret](model-defs-authorizationservice-properties-client-secret.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-client-secret-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-client-secret-anyof-1.md "check type definition")

## grant\_type



`grant_type`

*   is optional

*   Type: merged type ([Grant type (e.g. password)](model-defs-authorizationservice-properties-grant-type-eg-password.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-grant-type-eg-password.md "airs_model#/$defs/AuthorizationService/properties/grant_type")

### grant\_type Type

merged type ([Grant type (e.g. password)](model-defs-authorizationservice-properties-grant-type-eg-password.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-grant-type-eg-password-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-grant-type-eg-password-anyof-1.md "check type definition")

## arlas\_iam



`arlas_iam`

*   is optional

*   Type: merged type ([Is it an ARLAS IAM service?](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md "airs_model#/$defs/AuthorizationService/properties/arlas_iam")

### arlas\_iam Type

merged type ([Is it an ARLAS IAM service?](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md))

any of

*   [Untitled boolean in Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service-anyof-1.md "check type definition")

### arlas\_iam Default Value

The default value is:

```json
true
```
