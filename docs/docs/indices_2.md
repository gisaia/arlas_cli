```

## Generate mapping from a data file


To generate a mapping, you need to provide a NDJSON file (New line delimiter JSON). The first N lines are used for infering the mapping. If the mapping is wrong, you can overwrite the typing with the `--field-mapping` option. Once you're happy with the mapping, you can directly push it on elasticsearch (`--push-on`).

<!-- termynal -->
```shell
