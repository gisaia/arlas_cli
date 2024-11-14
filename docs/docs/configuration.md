# Configuration

`arlas_cli` uses a yaml file for storing various ARLAS and elasticsearch configurations. 

## Initial configuration

At its first launch, `arlas_cli` will create a first [configuration file](https://raw.githubusercontent.com/gisaia/arlas-cli/master/configuration.yaml) for you.

<!-- termynal -->
```shell
> arlas_cli --version
X.X.X
Warning : no configuration file found, we created an empty one for 
you (~/.arlas/cli/configuration.yaml).
```

By default, the file is located in `$HOME/.arlas/cli/configuration.yaml`.

It contains one ARLAS configurations pointing at a local deployment.

!!! warning 
    If you used the ARLAS Exploration Stack, it is possible that you already have a directory named `$HOME/.arlas`. 
    This directory has been created by docker as root. 

    The owner of the directory must be changed to the local user (`sudo chown ${USER}: $HOME/.arlas`).


## Configurations file

By default, the command line uses the `${HOME}/.arlas/cli/configuration.yaml` configuration file:

For example, the default configuration file with only the `local` configuration looks like: 
```yaml
arlas:
  local:
    allow_delete: true
    authorization: null
    elastic:
      location: http://localhost:9200
      ...
    persistence:
      location: http://localhost/persist
      ...
    server:
      location: http://localhost/arlas
      ...
```

The `arlas` section contains the different deployment configurations (here only `local`).

Each deployment configuration is defined by:

- authorization: The authentication system configuration
- elastic: The link to elasticsearch cluster
- persistence: The link to ARLAS persistence system
- server: The link to ARLAS server

You can interact with this configuration file directly with the command line itself with the [`arlas_cli confs`](confs.md#configurations) commands.

For exemple, you can list the available configuration contained in the file:

<!-- termynal -->
```shell
> arlas_cli confs list     
+-------+------------------------+
| name  | url                    |
+-------+------------------------+
| local | http://localhost/arlas |
+-------+------------------------+
```

## Custom configuration file path

It is possible to use a different configuration file than the one placed in your home directory (`$HOME/.arlas/cli/configuration.yaml`):

<!-- termynal -->
```shell
> arlas_cli --config-file /tmp/config.yaml        
Warning : no configuration file found, we created a default one with a 'local' confs accessing local ARLAS exploration stack (/tmp/config.yaml).
```

All the arlas_cli commands can then be run on this configuration file, for example to list the available confs:

<!-- termynal -->
```shell
> arlas_cli --config-file /tmp/config.yaml confs list
+-------+------------------------+
| name  | url                    |
+-------+------------------------+
| local | http://localhost/arlas |
+-------+------------------------+
```

## Manage configurations

 arlas_cli allows to manage configurations with `confs` sub-commands:

- [confs list](confs.md#list): List the available configurations
- [confs describe](confs.md#describe): Describe the content of a configuration
- [confs create](confs.md#create): Create a new configuration
- [confs delete](confs.md#delete): Delete a configuration

## ARLAS Cloud configuration

If you have an ARLAS cloud account, you can configure `cloud.arlas.io` and `cloud.arlas.io-admin` configurations to access your space with `arlas_cli`.

!!! note
    You can name your configuration as you want, but it is advised to create an "admin" configuration which is the only one to have the right to delete data.

First, set the environment variables provided by Gisaïa and change appropriately `SET_THIS_VALUE` with your own ARLAS user login/password:

=== "Linux/Mac"
    ```
    export MY_ORGANIZATION=<SET_THIS_VALUE>
    export ARLAS_USER=<SET_THIS_VALUE>
    export ARLAS_PWD=<SET_THIS_VALUE>
    export ELASTIC_ENDPOINT=<SET_THIS_VALUE>
    export ELASTIC_USER=<SET_THIS_VALUE>
    export ELASTIC_PWD=<SET_THIS_VALUE>
    ```

    Then run the command `arlas_cli confs create` with all the parameters to create the `cloud.arlas.io` and `cloud.arlas.io-admin` configurations:
    
    === "cloud.arlas.io"
        ```shell
        arlas_cli confs \
            create cloud.arlas.io \
            --server "https://cloud.arlas.io/arlas/server" \
            --headers "arlas-org-filter:${MY_ORGANIZATION}" \
            --headers "Content-Type:application/json" \
            --auth-token-url https://cloud.arlas.io/arlas/iam/session \
            --auth-login "${ARLAS_USER}" \
            --auth-password "${ARLAS_PWD}" \
            --auth-headers "Content-Type:application/json;charset=utf-8" \
            --auth-org "${MY_ORGANIZATION}" \
            --elastic "${ELASTIC_ENDPOINT}" \
            --elastic-headers "Content-Type:application/json" \
            --elastic-login "${ELASTIC_USER}" \
            --elastic-password "${ELASTIC_PWD}" \
            --persistence "https://cloud.arlas.io/arlas/persistence" \
            --persistence-headers "Content-Type:application/json" \
            --auth-arlas-iam \
            --no-allow-delete
        ```
    
    === "cloud.arlas.io-admin"
        ```shell
        arlas_cli confs \
            create cloud.arlas.io \
            --server "https://cloud.arlas.io/arlas/server" \
            --headers "arlas-org-filter:${MY_ORGANIZATION}" \
            --headers "Content-Type:application/json" \
            --auth-token-url https://cloud.arlas.io/arlas/iam/session \
            --auth-login "${ARLAS_USER}" \
            --auth-password "${ARLAS_PWD}" \
            --auth-headers "Content-Type:application/json;charset=utf-8" \
            --auth-org "${MY_ORGANIZATION}" \
            --elastic "${ELASTIC_ENDPOINT}" \
            --elastic-headers "Content-Type:application/json" \
            --elastic-login "${ELASTIC_USER}" \
            --elastic-password "${ELASTIC_PWD}" \
            --persistence "https://cloud.arlas.io/arlas/persistence" \
            --persistence-headers "Content-Type:application/json" \
            --auth-arlas-iam \
            --allow-delete
        ```

=== "Windows PowerShell"
    ```
    $env:MY_ORGANIZATION = "<SET_THIS_VALUE>"
    $env:ARLAS_USER = "<SET_THIS_VALUE>"
    $env:ARLAS_PWD = "<SET_THIS_VALUE>"
    $env:ELASTIC_ENDPOINT = "<SET_THIS_VALUE>"
    $env:ELASTIC_USER = "<SET_THIS_VALUE>"
    $env:ELASTIC_PWD = "<SET_THIS_VALUE>"
    ```

    Then run the command `arlas_cli confs create` with all the parameters to create the `cloud.arlas.io` and `cloud.arlas.io-admin` configurations:
    
    === "cloud.arlas.io"
        ```shell
        arlas_cli confs `
            create cloud.arlas.io `
            --server "https://cloud.arlas.io/arlas/server" `
            --headers "arlas-org-filter:$env:MY_ORGANIZATION" `
            --headers "Content-Type:application/json" `
            --auth-token-url https://cloud.arlas.io/arlas/iam/session `
            --auth-login "$env:ARLAS_USER" `
            --auth-password "$env:ARLAS_PWD" `
            --auth-headers "Content-Type:application/json;charset=utf-8" `
            --auth-org "$env:MY_ORGANIZATION" `
            --elastic "$env:ELASTIC_ENDPOINT" `
            --elastic-headers "Content-Type:application/json" `
            --elastic-login "$env:ELASTIC_USER" `
            --elastic-password "$env:ELASTIC_PWD" `
            --persistence "https://cloud.arlas.io/arlas/persistence" `
            --persistence-headers "Content-Type:application/json" `
            --auth-arlas-iam `
            --no-allow-delete
        ```
    
    === "cloud.arlas.io-admin"
        ```shell
        arlas_cli confs `
            create cloud.arlas.io `
            --server "https://cloud.arlas.io/arlas/server" `
            --headers "arlas-org-filter:$env:MY_ORGANIZATION" `
            --headers "Content-Type:application/json" `
            --auth-token-url https://cloud.arlas.io/arlas/iam/session `
            --auth-login "$env:ARLAS_USER" `
            --auth-password "$env:ARLAS_PWD" `
            --auth-headers "Content-Type:application/json;charset=utf-8" `
            --auth-org "$env:MY_ORGANIZATION" `
            --elastic "$env:ELASTIC_ENDPOINT" `
            --elastic-headers "Content-Type:application/json" `
            --elastic-login "$env:ELASTIC_USER" `
            --elastic-password "$env:ELASTIC_PWD" `
            --persistence "https://cloud.arlas.io/arlas/persistence" `
            --persistence-headers "Content-Type:application/json" `
            --auth-arlas-iam `
            --allow-delete
        ```

Check the configurations exist:

```shell
arlas_cli confs list
```

You can now for example list your available collections:

```shell
arlas_cli collections --config cloud.arlas.io list
```