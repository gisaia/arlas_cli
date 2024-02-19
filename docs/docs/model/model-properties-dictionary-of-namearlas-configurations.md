# dictionary of name/arlas configurations Schema

```txt
airs_model#/properties/arlas
```



| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [model.schema.json\*](../../out/model.schema.json "open original schema") |

## arlas Type

`object` ([dictionary of name/arlas configurations](model-properties-dictionary-of-namearlas-configurations.md))

# arlas Properties

| Property              | Type     | Required | Nullable       | Defined by                                                                          |
| :-------------------- | :------- | :------- | :------------- | :---------------------------------------------------------------------------------- |
| Additional Properties | `object` | Optional | cannot be null | [Settings](model-defs-arlas.md "airs_model#/properties/arlas/additionalProperties") |

## Additional Properties

Additional properties are allowed, as long as they follow this schema:



*   is optional

*   Type: `object` ([ARLAS](model-defs-arlas.md))

*   cannot be null

*   defined in: [Settings](model-defs-arlas.md "airs_model#/properties/arlas/additionalProperties")

### additionalProperties Type

`object` ([ARLAS](model-defs-arlas.md))
