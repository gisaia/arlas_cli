## Getting help

At any time, if you need some help on how to use the command line or one of its sub command, simply add `--help`.

Whether you are at the top level:
<!-- termynal -->
```shell
> arlas_cli --help
                                                                              
 Usage: arlas_cli [OPTIONS] COMMAND [ARGS]...                                 
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --config-file                       TEXT  Path to the configuration file   │
│                                           if you do not want to use the    │
│                                           default one:                     │
│                                           .arlas/cli/configuration.yaml.   │
│ --print-curl     --no-print-curl          Print curl command               │
│                                           [default: no-print-curl]         │
│ --version                                 Print command line version       │
│ --help                                    Show this message and exit.      │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ collections                                                                │
│ indices                                                                    │
│ persist                                                                    │
│ confs                                                                      │
│ iam                                                                        │
╰────────────────────────────────────────────────────────────────────────────╯

```

or within a sub command:

<!-- termynal -->
```shell
> arlas_cli indices --config local mapping --help
Using configuration 'local'
                                                                              
 Usage: arlas_cli indices mapping [OPTIONS] FILE                              
                                                                              
 Generate the mapping based on the data                                       
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    file      TEXT  Path to the file containing the data. Format: NDJSON  │
│                      [required]                                            │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --nb-lines             INTEGER  Number of line to consider for generating  │
│                                 the mapping. Avoid going over 10.          │
│                                 [default: 2]                               │
│ --field-mapping        TEXT     Override the mapping with the provided     │
│                                 field path/type. Example:                  │
│                                 fragment.location:geo_point. Important:    │
│                                 the full field path must be provided.      │
│ --no-fulltext          TEXT     List of keyword or text fields that should │
│                                 not be in the fulltext search. Important:  │
│                                 the field name only must be provided.      │
│ --no-index             TEXT     List of fields that should not be indexed. │
│ --push-on              TEXT     Push the generated mapping for the         │
│                                 provided index name                        │
│ --help                          Show this message and exit.                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```
