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
│ --quiet          --no-quiet               Remove non-essential printing    │
│                                           [default: no-quiet]              │
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
Warning : no configuration available
```
