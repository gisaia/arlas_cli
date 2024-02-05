# Settings Schema

```txt
airs_model
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                              |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [model.schema.json](../../out/model.schema.json "open original schema") |

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

| Property                       | Type   | Required | Nullable       | Defined by                                                                                                                                    |
| :----------------------------- | :----- | :------- | :------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| [server](#server)              | Merged | Required | cannot be null | [Settings](model-defs-arlas-properties-arlas-server.md "airs_model#/$defs/ARLAS/properties/server")                                           |
| [iam](#iam)                    | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-arlas-iam-url.md "airs_model#/$defs/ARLAS/properties/iam")                                             |
| [keycloak](#keycloak)          | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/keycloak")                                         |
| [elastic](#elastic)            | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-dictionary-of-namees-resources.md "airs_model#/$defs/ARLAS/properties/elastic")                        |
| [allow\_delete](#allow_delete) | Merged | Optional | cannot be null | [Settings](model-defs-arlas-properties-is-delete-command-allowed-for-this-configuration.md "airs_model#/$defs/ARLAS/properties/allow_delete") |

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

### iam



`iam`

*   is optional

*   Type: merged type ([ARLAS IAM URL](model-defs-arlas-properties-arlas-iam-url.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-arlas-iam-url.md "airs_model#/$defs/ARLAS/properties/iam")

#### iam Type

merged type ([ARLAS IAM URL](model-defs-arlas-properties-arlas-iam-url.md))

any of

*   [Resource](model-defs-resource.md "check type definition")

*   [Untitled null in Settings](model-defs-arlas-properties-arlas-iam-url-anyof-1.md "check type definition")

### keycloak



`keycloak`

*   is optional

*   Type: merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas-properties-keycloak-url.md "airs_model#/$defs/ARLAS/properties/keycloak")

#### keycloak Type

merged type ([Keycloak URL](model-defs-arlas-properties-keycloak-url.md))

any of

*   [Resource](model-defs-resource.md "check type definition")

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
