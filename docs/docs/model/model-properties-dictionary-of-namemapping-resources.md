# dictionary of name/mapping resources Schema

```txt
airs_model#/properties/mappings
```



| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                   |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :--------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [model.schema.json\*](../../../out/model.schema.json "open original schema") |

## mappings Type

`object` ([dictionary of name/mapping resources](model-properties-dictionary-of-namemapping-resources.md))

# mappings Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                                |
| :-------------------- | :------- | :------- | :------------- | :---------------------------------------------------------------------------------------- |
| Additional Properties | `object` | Optional | cannot be null | [Settings](model-defs-resource.md "airs_model#/properties/mappings/additionalProperties") |

## Additional Properties

Additional properties are allowed, as long as they follow this schema:



*   is optional

*   Type: `object` ([Resource](model-defs-resource.md))

*   cannot be null

*   defined in: [Settings](model-defs-resource.md "airs_model#/properties/mappings/additionalProperties")

### additionalProperties Type

`object` ([Resource](model-defs-resource.md))
