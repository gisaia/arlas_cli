# Configurations


## ARLAS configurations

An ARLAS Configuration tells `arlas_cli` how to contact ARLAS Server and Elasticsearch.

See [more information about configuration](configuration.md).

It is possible, with the `arlas_cli confs` command lines, to manage the ARLAS configurations.

**List configurations (confs) management commands**

<!-- termynal -->
```shell
> arlas_cli confs --help
                                                                              
 Usage: arlas_cli confs [OPTIONS] COMMAND [ARGS]...                           
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ set        Set default configuration among existing configurations         │
│ default    Display the default configuration                               │
│ check      Check the services of a configuration                           │
│ list       List configurations                                             │
│ create     Add a configuration                                             │
│ login      Add a configuration for ARLAS Cloud                             │
│ delete     Delete a configuration                                          │
│ describe   Describe a configuration                                        │
╰────────────────────────────────────────────────────────────────────────────╯

```


## create

`arlas_cli` is meant to communicate with a deployed ARLAS. This link is configured by creating a new configuration.

<!-- termynal -->
```shell
> arlas_cli confs create --help
                                                                              
 Usage: arlas_cli confs create [OPTIONS] NAME                                 
                                                                              
 Add a configuration                                                          
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    name      TEXT  Name of the configuration [required]                  │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ *  --server                                      TEXT  ARLAS Server url    │
│                                                        [required]          │
│    --headers                                     TEXT  header (name:value) │
│    --persistence                                 TEXT  ARLAS Persistence   │
│                                                        url                 │
│    --persistence-head…                           TEXT  header (name:value) │
│    --elastic                                     TEXT  elasticsearch url   │
│    --elastic-login                               TEXT  elasticsearch login │
│    --elastic-password                            TEXT  elasticsearch       │
│                                                        password            │
│    --elastic-headers                             TEXT  header (name:value) │
│    --allow-delete         --no-allow-delete            Is delete command   │
│                                                        allowed for this    │
│                                                        configuration?      │
│                                                        [default:           │
│                                                        no-allow-delete]    │
│    --auth-token-url                              TEXT  Token URL of the    │
│                                                        authentication      │
│                                                        service             │
│    --auth-headers                                TEXT  header (name:value) │
│    --auth-org                                    TEXT  ARLAS IAM           │
│                                                        Organization        │
│    --auth-login                                  TEXT  login               │
│    --auth-password                               TEXT  password            │
│    --auth-client-id                              TEXT  Client ID           │
│    --auth-client-secr…                           TEXT  Client secret       │
│    --auth-grant-type                             TEXT  Grant type (e.g.    │
│                                                        password)           │
│    --auth-arlas-iam       --no-auth-arlas-iam          Is it an ARLAS IAM  │
│                                                        service?            │
│                                                        [default:           │
│                                                        auth-arlas-iam]     │
│    --help                                              Show this message   │
│                                                        and exit.           │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```


### Create a new configuration

The `arlas_cli confs create` command has to be filled with options specific to your ARLAS deployment.

Those options can be filled as described in the following sections.

#### ARLAS Authentication

Keycloak and ARLAS IAM authentications are supported. See [scripts/init_arlas_cli_confs.sh](https://github.com/gisaia/ARLAS-Exploration-stack/blob/develop/scripts/init_arlas_cli_confs.sh) script for different connection configuration examples.


##### ARLAS IAM

To create a configuration for ARLAS IAM, the following parameters have to be set with your values:

- The IAM session url `IAM_URL`
- Your IAM user `ARLAS_USER`
- Your IAM password `ARLAS_PWD`
- Your ARLAS organization `ARLAS_ORGANIZATION`

The following options are used by `confs create` sub-command to generate the configuration:
```
--auth-arlas-iam
--auth-token-url {IAM_URL}
--auth-login {ARLAS_USER}
--auth-password {ARLAS_PWD}
--auth-headers "Content-Type:application/json;charset=utf-8"
--auth-org {ARLAS_ORGANIZATION}
```

A full example once you have set `IAM_URL`, `ARLAS_ORGANIZATION`, `ARLAS_USER` and `ARLAS_PWD`:
```shell
arlas_cli --config-file /tmp/arlas-cli.yaml confs create local.iam.user \
    --server https://${ARLAS_HOST}/arlas \
    --headers "Content-Type:application/json" \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-token-url https://${ARLAS_HOST}/arlas_iam_server/session \
    --auth-headers "Content-Type:application/json" \
    --auth-login ${ARLAS_USER} \
    --auth-password ${ARLAS_PWD} \
    --auth-org ${ARLAS_ORGANIZATION} \
    --auth-arlas-iam 
```

##### Keycloak
To create a configuration for Keycloak, the following parameters have to be set with your values:

- The Keycloak token url `TOKEN_URL`
- Your user's login `ARLAS_USER`
- Your user's password `ARLAS_PWD`


The following options are used by `confs create` sub-command to generate the configuration:
```
--auth-grant-type password \
--auth-client-id arlas-front \
--auth-token-url ${TOKEN_URL} \
--auth-headers "Content-Type:application/x-www-form-urlencoded" \
--auth-login ${ARLAS_USER} \
--auth-password ${ARLAS_PWD} \
```

A full example once you have set `TOKEN_URL`, `ARLAS_USER` and `ARLAS_PWD`:
```shell
arlas_cli --config-file /tmp/arlas-cli.yaml \
    confs create local.kc.user \
    --server https://${ARLAS_HOST}/arlas \
    --persistence https://${ARLAS_HOST}/persist \
    --persistence-headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete  \
    --auth-grant-type password \
    --auth-client-id arlas-front \
    --auth-token-url https://${ARLAS_HOST}:9443/auth/realms/arlas/protocol/openid-connect/token \
    --auth-headers "Content-Type:application/x-www-form-urlencoded" \
    --auth-login ${ARLAS_USER} \
    --auth-password ${ARLAS_PWD} \
    --no-auth-arlas-iam
```

#### ARLAS Server and Persistence

The ARLAS server URL (`ARLAS_SERVER_URL`) and the ARLAS persistence server URL (`ARLAS_PERSISTENCE_URL`) have to be set in the configuration using the following options in the `confs create` sub-command:
```
--server {ARLAS_SERVER_URL}
--headers "Content-Type:application/json"
--persistence {ARLAS_PERSISTENCE_URL}
--persistence-headers "Content-Type:application/json"
```

#### Elasticsearch

The used Elasticsearch instance and your credentials has to be set in the configuration:

- `ELASTIC_ENDPOINT`: The used Elasticsearch endpoint (eg: http://localhost:9200)
- `ELASTIC_USER`: Your ES user name
- `ELASTIC_PWD`: Your ES user password

The link to the ES instance is configured by using the following options in the `confs create` sub-command:
```
--elastic {ELASTIC_ENDPOINT}
--elastic-headers "Content-Type:application/json"
--elastic-login {ELASTIC_USER}
--elastic-password {ELASTIC_PWD}
```

#### Allow data deletion

By default, it is not possible to run the `indices delete` command on an elasticsearch with `arlas_cli`.
This is to prevent accidental data loss.

!!! warning "--allow-delete"
    In order to allow to delete on a configuration, use the `--allow-delete` option.

## login

### Create configuration for ARLAS Cloud

The `confs longin` allows to create a configuration linked to an ARLAS Cloud account:

<!-- termynal -->
```shell
> arlas_cli confs login --help
                                                                              
 Usage: arlas_cli confs login [OPTIONS] AUTH_LOGIN ELASTIC_LOGIN ELASTIC      
                                                                              
 Add a configuration for ARLAS Cloud                                          
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    auth_login         TEXT  ARLAS login [required]                       │
│ *    elastic_login      TEXT  Elasticsearch login [required]               │
│ *    elastic            TEXT  Elasticsearch url [required]                 │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --auth-org                                 TEXT  ARLAS IAM Organization,   │
│                                                  default is your email     │
│                                                  domain name               │
│ --allow-delete        --no-allow-delete          Is delete command allowed │
│                                                  for this configuration?   │
│                                                  [default: allow-delete]   │
│ --auth-password                            TEXT  ARLAS password            │
│ --elastic-password                         TEXT  elasticsearch password    │
│ --help                                           Show this message and     │
│                                                  exit.                     │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

Only your own ES and ARLAS credentials have to be set, the configuration is directly linked to the ARLAS Cloud instance.

It creates a configuration based on your username (extracted from your ARLAS login)  : `cloud.arlas.io.{USER_NAME}`

!!! note
    This created configuration is used as default.

    You no longer need to declare the `--config` in the arlas_cli commands

See the [ARLAS Cloud configuration guide](configuration.md#arlas-cloud-configuration).

## delete

### Delete an existing configuration

An existing configuration can be deleted with the `confs delete` sub command:

<!-- termynal -->
```shell
> arlas_cli confs delete --help
                                                                              
 Usage: arlas_cli confs delete [OPTIONS] CONFIG                               
                                                                              
 Delete a configuration                                                       
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    config      TEXT  Name of the configuration [required]                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

To remove an existing configuration from the default configuration file, simply run the following command:

```shell
arlas_cli confs delete {conf_name}
```

The configuration will no longer appear in the configuration file.

!!! warning
    Once deleted, the configuration cannot be retrieved.

## describe

### Describe the content of a configuration

The content of a configuration can be detailed with `confs describe` sub command:

<!-- termynal -->
```shell
> arlas_cli confs describe --help
                                                                              
 Usage: arlas_cli confs describe [OPTIONS] CONFIG                             
                                                                              
 Describe a configuration                                                     
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    config      TEXT  Name of the configuration [required]                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

For example, the default local configuration looks like:

<!-- termynal -->
```shell
> arlas_cli confs describe local
allow_delete: true
authorization: null
elastic:
  headers:
    Content-Type: application/json
  location: http://localhost:9200
  login: null
  password: null
persistence:
  headers:
    Content-Type: application/json
  location: http://localhost/persist
  login: null
  password: null
server:
  headers:
    Content-Type: application/json
  location: http://localhost/arlas
  login: null
  password: null
```

We get the different elements of the configurations:

- authorization: The authentication system configuration
- elastic: The link to Elasticsearch cluster
- persistence: The link to ARLAS persistence
- server: The link to ARLAS server

See [more about the configuration](configuration.md).

## list

### List the available configurations

The list of available configurations can be obtained with `confs list` sub command:

<!-- termynal -->
```shell
> arlas_cli confs list --help
                                                                              
 Usage: arlas_cli confs list [OPTIONS]                                        
                                                                              
 List configurations                                                          
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

The `confs list` sub-command returns the list of available configuration names and their ARLAS server url.

For example:
<!-- termynal -->
```shell
> arlas_cli confs list
+-------+------------------------+
| name  | url                    |
+-------+------------------------+
| local | http://localhost/arlas |
+-------+------------------------+
```

## default

### Get the current default configuration

The default arlas_cli configuration can be obtained with the `confs default` subcommand:

<!-- termynal -->
```shell
> arlas_cli confs default --help
                                                                              
 Usage: arlas_cli confs default [OPTIONS]                                     
                                                                              
 Display the default configuration                                            
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

!!! note
    When a configuration is set as default, you do not need to specify `--config` option in `arlas_cli` commands.

To identify which configuration is currently set as the default, run:

```shell
arlas_cli confs default
```

## set

### Set the default configuration

The default arlas_cli configuration can be set with the `confs set` subcommand:

<!-- termynal -->
```shell
> arlas_cli confs set --help
                                                                              
 Usage: arlas_cli confs set [OPTIONS] NAME                                    
                                                                              
 Set default configuration among existing configurations                      
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    name      TEXT  Name of the configuration to become default           │
│                      [required]                                            │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

!!! note
    When a configuration is set as default, you do not need to specify `--config` option in `arlas_cli` commands.

To set a configuration `conf_name` as the default, run:

```shell
arlas_cli confs set {conf_name}
```

## check

### Check the services of a configuration

You can verify the services accessible through a specific configuration using the `confs check` subcommand:

<!-- termynal -->
```shell
> arlas_cli confs check --help
                                                                              
 Usage: arlas_cli confs check [OPTIONS] NAME                                  
                                                                              
 Check the services of a configuration                                        
                                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────╮
│ *    name      TEXT  Configuration to be checked [required]                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
                                                                              
 See full arlas_cli documentation at                                          
 https://docs.arlas.io/external_docs/arlas_cli/                               
                                                                              

```

This command validates that the addresses and credentials defined in the configuration are correct and ensures successful access to the services.

The following services are validated:

- ARLAS Server
- ARLAS Persistence
- ARLAS IAM
- Elasticsearch

!!! success
    Example:
    <!-- termynal -->
    ```shell
    > arlas_cli confs check cloud.arlas.io.user
    ARLAS Server: ...  ok
    ARLAS Persistence: ...  ok
    ARLAS IAM: ...  ok
    Elasticsearch: ...  ok
    ```
    All services are up and running, and the configuration is correctly set up.
    
