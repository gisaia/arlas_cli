
!!! tip  
    At its first launch, `arlas_cli` will create a first configuration file for you (`$HOME/.arlas/cli/configuration.yaml`), with two ARLAS configurations, one pointing at a local deployment, one on ARLAS demo (without elasticsearch).

!!! bug 
    If you used the ARLAS Exploration Stack, it is possible that you already have a directory named `$HOME/.arlas`. This directory has been created by docker as root. The owner of the directory must be changed to the local user (`sudo chown ${USER}: $HOME/.arlas`).

## List configuration management commands

<!-- termynal -->
```shell
> arlas_cli confs --help
                                                                      
 Usage: python -m arlas.cli.cli confs [OPTIONS] COMMAND [ARGS]...     
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                        │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ create             Add a configuration                             │
│ delete             Delete a configuration                          │
│ describe           Describe a configuration                        │
│ list               List configurations                             │
╰────────────────────────────────────────────────────────────────────╯

```

## Create a configuration

The configuration file (default is `$HOME/.arlas/cli/configuration.yaml`) contains 3 sections:

- the list of ARLAS configurations
- the list of mappings
- the list of collection models

It is possible, with the `arlas_cli` command line, to manage the ARLAS configurations, but not the two last ones.

An ARLAS Configuration tells `arlas_cli` how to contact ARLAS Server and elasticsearch. It supports the addition of http headers. For ARLAS, keycloak and ARLAS IAM authentications are supported. Default is keycloak, use `--auth-arlas-iam` for ARLAS IAM.

!!! danger  
    By default, it is not possible to run the `delete` command on an elasticsearch with `arlas_cli`. This is to prevent accidental data loss. In order to allow delete on a configuration, use the `--allow-delete` option.

<!-- termynal -->
```shell
> arlas_cli confs create --help
                                                                      
 Usage: python -m arlas.cli.cli confs create [OPTIONS] NAME           
                                                                      
 Add a configuration                                                  
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    name      TEXT  Name of the configuration [default: None]     │
│                      [required]                                    │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ *  --server                                TEXT  ARLAS Server url  │
│                                                  [default: None]   │
│                                                  [required]        │
│    --persistence                           TEXT  ARLAS Persistence │
│                                                  url               │
│                                                  [default: None]   │
│    --headers                               TEXT  header            │
│                                                  (name:value)      │
│    --elastic                               TEXT  dictionary of     │
│                                                  name/es resources │
│                                                  [default: None]   │
│    --elastic-heade…                        TEXT  header            │
│                                                  (name:value)      │
│    --allow-delete      --no-allow-dele…          Is delete command │
│                                                  allowed for this  │
│                                                  configuration?    │
│                                                  [default:         │
│                                                  no-allow-delete]  │
│    --auth-token-url                        TEXT  Token URL of the  │
│                                                  authentication    │
│                                                  service           │
│                                                  [default: None]   │
│    --auth-headers                          TEXT  header            │
│                                                  (name:value)      │
│    --auth-login                            TEXT  login             │
│                                                  [default: None]   │
│    --auth-password                         TEXT  password          │
│                                                  [default: None]   │
│    --auth-client-id                        TEXT  Client ID         │
│                                                  [default: None]   │
│    --auth-client-s…                        TEXT  Client secret     │
│                                                  [default: None]   │
│    --auth-grant-ty…                        TEXT  Grant type (e.g.  │
│                                                  password)         │
│                                                  [default: None]   │
│    --auth-arlas-iam    --no-auth-arlas…          Is it an ARLAS    │
│                                                  IAM service?      │
│                                                  [default:         │
│                                                  auth-arlas-iam]   │
│    --help                                        Show this message │
│                                                  and exit.         │
╰────────────────────────────────────────────────────────────────────╯

```
