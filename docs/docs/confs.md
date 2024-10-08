# Configurations


## ARLAS configurations

The configuration file (default is `$HOME/.arlas/cli/configuration.yaml`) contains 3 sections:

- the list of ARLAS configurations
- the list of mappings
- the list of collection models

An ARLAS Configuration tells `arlas_cli` how to contact ARLAS Server and elasticsearch.

It supports the addition of http headers.

It is possible, with the `arlas_cli` command line, to manage the ARLAS configurations, but not the two last ones.

**List configurations (confs) management commands**

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


## create

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
│    --headers                               TEXT  header            │
│                                                  (name:value)      │
│    --persistence                           TEXT  ARLAS Persistence │
│                                                  url               │
│                                                  [default: None]   │
│    --persistence-h…                        TEXT  header            │
│                                                  (name:value)      │
│    --elastic                               TEXT  dictionary of     │
│                                                  name/es resources │
│                                                  [default: None]   │
│    --elastic-login                         TEXT  elasticsearch     │
│                                                  login             │
│                                                  [default: None]   │
│    --elastic-passw…                        TEXT  elasticsearch     │
│                                                  password          │
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
│    --auth-org                              TEXT  ARLAS IAM         │
│                                                  Organization      │
│                                                  [default: None]   │
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

A configuration is meant to communicate with a deployed ARLAS. 


For ARLAS, keycloak and ARLAS IAM authentications are supported. 

!!! note "--auth-arlas-iam "
    Default is ARLAS IAM, use `--no-auth-arlas-iam` for keycloak.


## delete

!!! danger  
    By default, it is not possible to run the `delete` command on an elasticsearch with `arlas_cli`. This is to prevent accidental data loss. In order to allow delete on a configuration, use the `--allow-delete` option.


## describe


## list