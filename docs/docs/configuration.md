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

It contains one ARLAS configuration linked to a local deployment.

!!! warning 
    If you used the ARLAS Exploration Stack, it is possible that you already have a directory named `$HOME/.arlas`. 
    This directory has been created by docker as root. 

    The owner of the directory must be changed to the local user (`sudo chown ${USER}: $HOME/.arlas`).

## ARLAS Cloud configuration

If you have an ARLAS cloud account, you can directly create the configurations to access your space with `arlas_cli login`.

!!! note "Provided by Gisaïa"
    Gisaïa provides the following variables for your account:
    
    - `ORGANIZATION`: The name of your organization.
    - `ELASTIC_ENDPOINT`, `ELASTIC_USER`, `ELASTIC_PWD`: The elasticsearch credentials associated with your account.

!!! note "Personal ARLAS account"
    You will also need the credentials for your personal ARLAS account:

    - `ARLAS_USER`: Your login, typically your email address.
    - `ARLAS_PWD`: The password you created when setting up your account.

To create the `cloud.arlas.io.{USER_NAME}` configuration, replace the placeholder variables with your actual values and run the following command:

```shell
arlas_cli confs login ${ARLAS_USER} ${ELASTIC_USER} ${ELASTIC_ENDPOINT} --auth-password ${ARLAS_PWD} --auth-org ${MY_ORGANIZATION} --elastic-password ${ELASTIC_PWD} --allow-delete
```

Once the configuration is created, verify its existence by listing all configurations:

```shell
arlas_cli confs list
```

!!! note "Default configuration"
    The configuration linked to your ARLAS Cloud account is automatically used as the default. 

    You do not need to specify the `--config` option when using `arlas_cli`.

For example, to list the available collections, use the following command:

```shell
arlas_cli collections list
```

## Configurations file

### Default configurations file

By default, the command line uses the `${HOME}/.arlas/cli/configuration.yaml` configuration file.

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
- elastic: The link to the elasticsearch cluster
- persistence: The link to ARLAS persistence
- server: The link to ARLAS server

You can interact with this configuration file directly with the command line itself with the [`arlas_cli confs`](confs.md#configurations) commands:

- [confs list](confs.md#list): List the available configurations
- [confs describe](confs.md#describe): Describe the content of a configuration
- [confs create](confs.md#create): Create a new configuration
- [confs delete](confs.md#delete): Delete a configuration
- [confs login](confs.md#login): Create an ARLAS Cloud configuration (see [ARLAS Cloud configuration](#arlas-cloud-configuration))

### Custom configuration file path

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