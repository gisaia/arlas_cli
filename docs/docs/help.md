## Getting help

At any time, if you need some help on how to use the command line or one of its sub command, simply add `--help`.

Whether you are at the top level:
<!-- termynal -->
```shell
> arlas_cli --help
 Usage: arlas_cli [OPTIONS] COMMAND [ARGS]...                         
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --config-file        TEXT  Path to the configuration file if you   │
│                            do not want to use the default one:     │
│                            .arlas/cli/configuration.yaml.          │
│                            [default: None]                         │
│ --version                  Print command line version              │
│ --help                     Show this message and exit.             │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ collections                                                        │
│ confs                                                              │
│ indices                                                            │
╰────────────────────────────────────────────────────────────────────╯
```

or within a sub command:

<!-- termynal -->
```shell
> arlas_cli indices --config demo mapping --help
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    file      TEXT  Path to the file conaining the data. Format:  │
│                      NDJSON                                        │
│                      [default: None]                               │
│                      [required]                                    │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --nb-lines             INTEGER  Number of line to consider for     │
│                                 generating the mapping. Avoid      │
│                                 going over 10.                     │
│                                 [default: 2]                       │
│ --field-mapping        TEXT     Overide the mapping with the       │
│                                 provided field/type. Example:      │
│                                 fragment.location:geo_point        │
│ --push-on              TEXT     Push the generated mapping for the │
│                                 provided index name                │
│                                 [default: None]                    │
│ --help                          Show this message and exit.        │
╰────────────────────────────────────────────────────────────────────╯

```
