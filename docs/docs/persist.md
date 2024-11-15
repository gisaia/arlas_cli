## Manage persistence

ARLAS Persistence allows you to place files within zones. A zone is visible by groups. It is also possible to set the access: writers, readers and whether it is public or not.

<!-- termynal -->
```shell
> arlas_cli persist --help
                                                                      
 Usage: python -m arlas.cli.cli persist [OPTIONS] COMMAND [ARGS]...   
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --config        TEXT  Name of the ARLAS configuration to use from  │
│                       your configuration file                      │
│                       (/Users/gaudan/.arlas/cli/configuration.yam… │
│                       [default: None]                              │
│ --help                Show this message and exit.                  │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ add           Add an entry, returns its ID                         │
│ delete        Delete an entry                                      │
│ describe      Describe an entry                                    │
│ get           Retrieve an entry                                    │
│ groups        List groups allowed to access a zone                 │
│ zone          List entries within a zone                           │
╰────────────────────────────────────────────────────────────────────╯

```
