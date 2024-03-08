# ARLAS Schema

```txt
airs_model#/properties/arlas/additionalProperties
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                   |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :--------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [model.schema.json\*](../../../out/model.schema.json "open original schema") |

## additionalProperties Type

`object` ([ARLAS](model-defs-arlas.md))

# additionalProperties Properties

| Property                        | Type   | Required | Nullable       | Defined by                                                                                                                                    |
| :------------------------------ | :----- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| [persistence](#persistence)     | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-arlas-persistence-server.md "airs_model#/$defs/ARLAS/properties/persistence")                          |
| [server](#server)               | Merged | Required | cannot be null | [Settings](model-defs-arlas-properties-arlas-server.md "airs_model#/$defs/ARLAS/properties/server")                                           |
| [authorization](#authorization) | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/authorization")                                    |
| [elastic](#elastic)             | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-dictionary-of-namees-resources.md "airs_model#/$defs/ARLAS/properties/elastic")                        |
| [allow\_delete](#allow_delete)  | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md "airs_model#/$defs/ARLAS/properties/allow_delete") |

## persistence



`persistence`

*   is optional

*   Type: merged type ([ARLAS Persistence Server](model-defs-arlas-properties-arlas-persistence-server.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-arlas-persistence-server.md "airs_model#/$defs/ARLAS/properties/persistence")

### persistence Type

merged type ([ARLAS Persistence Server](model-defs-arlas-properties-arlas-persistence-server.md))

any of

*   [Resource](model-defs-resource.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-arlas-persistence-server-anyof-1.md "check type definition")

## server



`server`

*   is required

*   Type: merged type ([ARLAS Server](model-defs-arlas-properties-arlas-server.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-arlas-server.md "airs_model#/$defs/ARLAS/properties/server")

### server Type

merged type ([ARLAS Server](model-defs-arlas-properties-arlas-server.md))

all of

*   [Resource](model-defs-resource.md "check type definition")

## authorization



`authorization`

*   is optional

*   Type: merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/authorization")

### authorization Type

merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

any of

*   [AuthorizationService](model-defs-authorizationservice.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-keycloak-url-anyof-1.md "check type definition")

## elastic



`elastic`

*   is optional

*   Type: merged type ([dictionary of name/es resources](model-defs-arlas-properties-dictionary-of-namees-resources.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-dictionary-of-namees-resources.md "airs_model#/$defs/ARLAS/properties/elastic")

### elastic Type

merged type ([dictionary of name/es resources](model-defs-arlas-properties-dictionary-of-namees-resources.md))

any of

*   [Resource](model-defs-resource.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-dictionary-of-namees-resources-anyof-1.md "check type definition")

## allow\_delete



`allow_delete`

*   is optional

*   Type: merged type ([Is delete command allowed for this configuration?](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md "airs_model#/$defs/ARLAS/properties/allow_delete")

### allow\_delete Type

merged type ([Is delete command allowed for this configuration?](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md))

any of

*   [Untitled boolean in Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration-anyof-1.md "check type definition")
