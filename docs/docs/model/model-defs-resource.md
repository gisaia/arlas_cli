# Resource Schema

```txt
airs_model#/properties/models/additionalProperties
```



| Abstract            | Extensible | Status         | Identifiable | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                   |
| :------------------ | :--------- | :------------- | :----------- | :---------------- | :-------------------- | :------------------ | :--------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | No           | Forbidden         | Allowed               | none                | [model.schema.json\*](../../../out/model.schema.json "open original schema") |

## additionalProperties Type

`object` ([Resource](model-defs-resource.md))

# additionalProperties Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                                                                                 |
| :-------------------- | :------- | :------- | :------------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| [location](#location) | `string` | Optional | cannot be null | [Settings](model-defs-resource-properties-file-or-http-location.md "airs_model#/$defs/Resource/properties/location")                       |
| [headers](#headers)   | Merged   | Optional | cannot be null | [Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md "airs_model#/$defs/Resource/properties/headers") |
| [login](#login)       | Merged   | Optional | cannot be null | [Settings](model-defs-resource-properties-user.md "airs_model#/$defs/Resource/properties/login")                                           |
| [password](#password) | Merged   | Optional | cannot be null | [Settings](model-defs-resource-properties-pasword.md "airs_model#/$defs/Resource/properties/password")                                     |

## location



`location`

*   is optional

*   Type: `string` ([file or http location](model-defs-resource-properties-file-or-http-location.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-file-or-http-location.md "airs_model#/$defs/Resource/properties/location")

### location Type

`string` ([file or http location](model-defs-resource-properties-file-or-http-location.md))

## headers



`headers`

*   is optional

*   Type: merged type ([List of headers, if needed, for http(s) requests](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md "airs_model#/$defs/Resource/properties/headers")

### headers Type

merged type ([List of headers, if needed, for http(s) requests](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests.md))

any of

*   [Untitled object in Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-resource-properties-list-of-headers-if-needed-for-https-requests-anyof-1.md "check type definition")

### headers Default Value

The default value is:

```json
{}
```

## login



`login`

*   is optional

*   Type: merged type ([user](model-defs-resource-properties-user.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-user.md "airs_model#/$defs/Resource/properties/login")

### login Type

merged type ([user](model-defs-resource-properties-user.md))

any of

*   [Untitled string in Settings](model-defs-resource-properties-user-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-resource-properties-user-anyof-1.md "check type definition")

## password



`password`

*   is optional

*   Type: merged type ([pasword](model-defs-resource-properties-pasword.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource-properties-pasword.md "airs_model#/$defs/Resource/properties/password")

### password Type

merged type ([pasword](model-defs-resource-properties-pasword.md))

any of

*   [Untitled string in Settings](model-defs-resource-properties-pasword-anyof-0.md "check type definition")

*   [Untitled null in Settings](model-defs-resource-properties-pasword-anyof-1.md "check type definition")
