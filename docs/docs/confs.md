# Configurations


## ARLAS configurations

An ARLAS Configuration tells `arlas_cli` how to contact ARLAS Server and elasticsearch.

See [more information about configuration](confs.md).

It is possible, with the `arlas_cli confs` command lines, to manage the ARLAS configurations.

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

`arlas_cli` is meant to communicate with a deployed ARLAS. This link is configured by creating a new configuration.

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


### Create a new configuration

The `arlas_cli confs create` command has to be filled with options specific to your ARLAS deployment.

Those options can be filled as describe in the following sections.

!!! note

    For ARLAS cloud deployment, a pre-filled variables file is furnished with a simple command to copy/paste.

#### ARLAS Authentication
For ARLAS, keycloak and ARLAS IAM authentications are supported. 

=== "ARLAS IAM"
    
    To create a configuration using ARLAS IAM, the following parameters have to be set with your values:

    - The IAM session url `IAM_URL`
    - Your IAM user `ARLAS_USER`
    - Your IAM password `ARLAS_PWD`
    - Your ARLAS organization `ARLAS_ORGANIZATION`

    The following options are used by `confs create` sub-command to generate the conf:
    ```
    --auth-arlas-iam
    --auth-token-url {IAM_URL}
    --auth-login {ARLAS_USER}
    --auth-password {ARLAS_PWD}
    --auth-headers "Content-Type:application/json;charset=utf-8"
    --auth-org {ARLAS_ORGANIZATION}
    ```

=== "Keycloak"
    Default is ARLAS IAM, use `--no-auth-arlas-iam` for keycloak.

    Keycloak authentication details coming soon...

#### ARLAS Server and Persistence

The ARLAS server url (`ARLAS_SERVER_URL`) and the persistence server URL (`ARLAS_PERSISTENCE_URL`) has to be set in the configuration using the following options in the `confs create` sub-command:
```
--server {ARLAS_SERVER_URL}
--headers "Content-Type:application/json"
--persistence {ARLAS_PERSISTENCE_URL}
--persistence-headers "Content-Type:application/json"
```


#### Elasticsearch 

The used elasticsearch instance and your credentials has to be set in the configuration:

- `ELASTIC_ENDPOINT`: The used elasticsearch endpoint (eg: http://localhost:9200)
- `ELASTIC_USER`: Your ES user name
- `ELASTIC_PWD`: Your ES user password

The link to ES instance is configured by using the following options in the `confs create` sub-command:
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

### ARLAS Cloud

If you want to connect `arlas_cli` to an existing ARLAS Cloud account, follow the [ARLAS Cloud configuration guide](configuration.md#arlas-cloud-configuration).

## delete

An existing configuration can be deleted with `confs delete` sub command:.

<!-- termynal -->
```shell
> arlas_cli confs delete --help
Usage: arlas_cli confs delete [OPTIONS] NAME

  Delete a configuration

Arguments:
  NAME  Name of the configuration  [required]

Options:
  --help  Show this message and exit.

```

### Delete an existing configuration

To remove an existing configuration from the default configuration file, simply run the following command:

```shell
arlas_cli confs delete {conf_name}
```

The configuration will no longer appear in the configuration file.

!!! warning
    The configuration deletion cannot be undone, make sure to not lost contained information

## describe

The content of a configuration can be detailed with `confs describe` sub command:

<!-- termynal -->
```shell
> arlas_cli confs describe --help
Usage: arlas_cli confs describe [OPTIONS] NAME

  Describe a configuration

Arguments:
  NAME  Name of the configuration  [required]

Options:
  --help  Show this message and exit.

```

### Describe the content of a configuration

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
- elastic: The link to elasticsearch cluster
- persistence: The link to ARLAS persistence system
- server: The link to ARLAS server

See [more about the configuration](configuration.md).

## list

The list of available configurations can be obtained with `confs list` sub command:

<!-- termynal -->
```shell
> arlas_cli confs list --help
Usage: arlas_cli confs list [OPTIONS]

  List configurations

Options:
  --help  Show this message and exit.
```

### List the available configurations

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
