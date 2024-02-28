# Settings Schema

```txt
airs_model
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                 |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [model.schema.json](../../../out/model.schema.json "open original schema") |

## Settings Type

`object` ([Settings](model.md))

# Settings Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                                            |
| :-------------------- | :------- | :------- | :------------- | :---------------------------------------------------------------------------------------------------- |
| [arlas](#arlas)       | `object` | Optional | cannot be null | [Settings](model-properties-dictionary-of-namearlas-configurations.md "airs_model#/properties/arlas") |
| [mappings](#mappings) | `object` | Optional | cannot be null | [Settings](model-properties-dictionary-of-namemapping-resources.md "airs_model#/properties/mappings") |
| [models](#models)     | `object` | Optional | cannot be null | [Settings](model-properties-dictionary-of-namemodel-resources.md "airs_model#/properties/models")     |

## arlas



`arlas`

*   is optional

*   Type: `object` ([dictionary of name/arlas configurations](model-properties-dictionary-of-namearlas-configurations.md))

*   cannot be null

*   defined in: [Settings](model-properties-dictionary-of-namearlas-configurations.md "airs_model#/properties/arlas")

### arlas Type

`object` ([dictionary of name/arlas configurations](model-properties-dictionary-of-namearlas-configurations.md))

## mappings



`mappings`

*   is optional

*   Type: `object` ([dictionary of name/mapping resources](model-properties-dictionary-of-namemapping-resources.md))

*   cannot be null

*   defined in: [Settings](model-properties-dictionary-of-namemapping-resources.md "airs_model#/properties/mappings")

### mappings Type

`object` ([dictionary of name/mapping resources](model-properties-dictionary-of-namemapping-resources.md))

## models



`models`

*   is optional

*   Type: `object` ([dictionary of name/model resources](model-properties-dictionary-of-namemodel-resources.md))

*   cannot be null

*   defined in: [Settings](model-properties-dictionary-of-namemodel-resources.md "airs_model#/properties/models")

### models Type

`object` ([dictionary of name/model resources](model-properties-dictionary-of-namemodel-resources.md))

# Settings Definitions

## Definitions group ARLAS

Reference this group by using

```json
{"$ref":"airs_model#/$defs/ARLAS"}
```

| Property                        | Type   | Required | Nullable       | Defined by                                                                                                                                    |
| :------------------------------ | :----- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| [server](#server)               | Merged | Required | cannot be null | [Settings](model-defs-arlas-properties-arlas-server.md "airs_model#/$defs/ARLAS/properties/server")                                           |
| [authorization](#authorization) | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/authorization")                                    |
| [elastic](#elastic)             | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-dictionary-of-namees-resources.md "airs_model#/$defs/ARLAS/properties/elastic")                        |
| [allow\_delete](#allow_delete)  | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md "airs_model#/$defs/ARLAS/properties/allow_delete") |

### server



`server`

*   is required

*   Type: merged type ([ARLAS Server](model-defs-arlas-properties-arlas-server.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-arlas-server.md "airs_model#/$defs/ARLAS/properties/server")

#### server Type

merged type ([ARLAS Server](model-defs-arlas-properties-arlas-server.md))

all of

*   [Resource](model-defs-resource.md "check type definition")

### authorization



`authorization`

*   is optional

*   Type: merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/authorization")

#### authorization Type

merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

any of

*   [AuthorizationService](model-defs-authorizationservice.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-keycloak-url-anyof-1.md "check type definition")

### elastic



`elastic`

*   is optional

*   Type: merged type ([dictionary of name/es resources](model-defs-arlas-properties-dictionary-of-namees-resources.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-dictionary-of-namees-resources.md "airs_model#/$defs/ARLAS/properties/elastic")

#### elastic Type

merged type ([dictionary of name/es resources](model-defs-arlas-properties-dictionary-of-namees-resources.md))

any of

*   [Resource](model-defs-resource.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-dictionary-of-namees-resources-anyof-1.md "check type definition")

### allow\_delete



`allow_delete`

*   is optional

*   Type: merged type ([Is delete command allowed for this configuration?](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md "airs_model#/$defs/ARLAS/properties/allow_delete")

#### allow\_delete Type

merged type ([Is delete command allowed for this configuration?](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md))

any of

*   [Untitled boolean in Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration-anyof-1.md "check type definition")

## Definitions group AuthorizationService

Reference this group by using

```json
{"$ref":"airs_model#/$defs/AuthorizationService"}
```

| Property                         | Type     | Required | Nullable       | Defined by                                                                                                                                                      |
| :------------------------------- | :------- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [token\_url](#token_url)         | Merged   | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md "airs_model#/$defs/AuthorizationService/properties/token_url") |
| [login](#login)                  | `string` | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-login.md "airs_model#/$defs/AuthorizationService/properties/login")                                       |
| [password](#password)            | `string` | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-password.md "airs_model#/$defs/AuthorizationService/properties/password")                                 |
| [client\_id](#client_id)         | Merged   | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-client-id.md "airs_model#/$defs/AuthorizationService/properties/client_id")                               |
| [client\_secret](#client_secret) | Merged   | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-client-secret.md "airs_model#/$defs/AuthorizationService/properties/client_secret")                       |
| [grant\_type](#grant_type)       | Merged   | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-grant-type-eg-password.md "airs_model#/$defs/AuthorizationService/properties/grant_type")                 |
| [arlas\_iam](#arlas_iam)         | Merged   | Optional | cannot be null | [Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md "airs_model#/$defs/AuthorizationService/properties/arlas_iam")              |

### token\_url



`token_url`

*   is optional

*   Type: merged type ([Token URL of the authentication service](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md "airs_model#/$defs/AuthorizationService/properties/token_url")

#### token\_url Type

merged type ([Token URL of the authentication service](model-defs-authorizationservice-properties-token-url-of-the-authentication-service.md))

all of

*   [Resource](model-defs-resource.md "check type definition")

### login



`login`

*   is optional

*   Type: `string` ([login](model-defs-authorizationservice-properties-login.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-login.md "airs_model#/$defs/AuthorizationService/properties/login")

#### login Type

`string` ([login](model-defs-authorizationservice-properties-login.md))

### password



`password`

*   is optional

*   Type: `string` ([password](model-defs-authorizationservice-properties-password.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-password.md "airs_model#/$defs/AuthorizationService/properties/password")

#### password Type

`string` ([password](model-defs-authorizationservice-properties-password.md))

### client\_id



`client_id`

*   is optional

*   Type: merged type ([Client ID](model-defs-authorizationservice-properties-client-id.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-client-id.md "airs_model#/$defs/AuthorizationService/properties/client_id")

#### client\_id Type

merged type ([Client ID](model-defs-authorizationservice-properties-client-id.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-client-id-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-client-id-anyof-1.md "check type definition")

### client\_secret



`client_secret`

*   is optional

*   Type: merged type ([Client secret](model-defs-authorizationservice-properties-client-secret.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-client-secret.md "airs_model#/$defs/AuthorizationService/properties/client_secret")

#### client\_secret Type

merged type ([Client secret](model-defs-authorizationservice-properties-client-secret.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-client-secret-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-client-secret-anyof-1.md "check type definition")

### grant\_type



`grant_type`

*   is optional

*   Type: merged type ([Grant type (e.g. password)](model-defs-authorizationservice-properties-grant-type-eg-password.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-grant-type-eg-password.md "airs_model#/$defs/AuthorizationService/properties/grant_type")

#### grant\_type Type

merged type ([Grant type (e.g. password)](model-defs-authorizationservice-properties-grant-type-eg-password.md))

any of

*   [Untitled string in Settings](model-defs-authorizationservice-properties-grant-type-eg-password-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-grant-type-eg-password-anyof-1.md "check type definition")

### arlas\_iam



`arlas_iam`

*   is optional

*   Type: merged type ([Is it an ARLAS IAM service?](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md))

*   cannot be null

*   defined in: [Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md "airs_model#/$defs/AuthorizationService/properties/arlas_iam")

#### arlas\_iam Type

merged type ([Is it an ARLAS IAM service?](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service.md))

any of

*   [Untitled boolean in Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-authorizationservice-properties-is-it-an-arlas-iam-service-anyof-1.md "check type definition")

#### arlas\_iam Default Value

The default value is:

```json
true
```

## Definitions group Resource

Reference this group by using

```json
{"$ref":"airs_model#/$defs/Resource"}
```

| Property              | Type     | Required | Nullable       | Defined by                                                                                                                                 |
| :-------------------- | :------- | :------- | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| [location](#location) | `string` | Optional | cannot be null | [Settings](model-defs-resource-properties-file-or-http-location.md "airs_model#/$defs/Resource/properties/location")                       |
| [headers](#headers)   | Merged   | Optional | cannot be null | [Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md "airs_model#/$defs/Resource/properties/headers") |

### location



`location`

*   is optional

*   Type: `string` ([file or http location](model-defs-resource-properties-file-or-http-location.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-file-or-http-location.md "airs_model#/$defs/Resource/properties/location")

#### location Type

`string` ([file or http location](model-defs-resource-properties-file-or-http-location.md))

### headers



`headers`

*   is optional

*   Type: merged type ([List of headers, if needed, for http(s) requests](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md "airs_model#/$defs/Resource/properties/headers")

#### headers Type

merged type ([List of headers, if needed, for http(s) requests](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md))

any of

*   [Untitled object in Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests-anyof-1.md "check type definition")
