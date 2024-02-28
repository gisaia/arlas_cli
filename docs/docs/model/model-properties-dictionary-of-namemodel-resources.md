# dictionary of name/model resources Schema

```txt
airs_model#/properties/models
```



| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                   |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :--------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [model.schema.json\*](../../../out/model.schema.json "open original schema") |

## models Type

`object` ([dictionary of name/model resources](model-properties-dictionary-of-namemodel-resources.md))

# models Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                              |
| :-------------------- | :------- | :------- | :------------- | :-------------------------------------------------------------------------------------- |
| Additional Properties | `object` | Optional | cannot be null | [Settings](model-defs-resource.md "airs_model#/properties/models/additionalProperties") |

## Additional Properties

Additional properties are allowed, as long as they follow this schema:



*   is optional

*   Type: `object` ([Resource](model-defs-resource.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource.md "airs_model#/properties/models/additionalProperties")

### additionalProperties Type

`object` ([Resource](model-defs-resource.md))
