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
      headers:
        Content-Type: application/json
      location: http://localhost:9200
      ...
    persistence:
      headers:
        Content-Type: application/json
      location: http://localhost/persist
      ...
    server:
      headers:
        Content-Type: application/json
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

You can also use the command line itself.

!!! tip
    Carefully, you can also edit directly the `${HOME}/.arlas/cli/configuration.yaml` configuration file to update your configurations.

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
