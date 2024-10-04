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

It contains two ARLAS configurations, one pointing at a local deployment, one on ARLAS demo (without elasticsearch).

!!! Note
    The configuration can also contain references to collection models for creating collections. A default one is provided for ARLAS EO. 
    
    A reference can be an http url or a path to a local file.
    It can also contain references to index mappings for creating indices.

!!! warning 
    If you used the ARLAS Exploration Stack, it is possible that you already have a directory named `$HOME/.arlas`. This directory has been created by docker as root. 

    The owner of the directory must be changed to the local user (`sudo chown ${USER}: $HOME/.arlas`).


## Configurations file

The command line uses the `${HOME}/.arlas/cli/configuration.yaml` configuration file:

```yaml
arlas:
  local:
    allow_delete: true
    elastic:
      headers:
        Content-Type: application/json
      location: http://localhost:9200
    server:
      headers:
        Content-Type: application/json
      location: http://localhost:9999/arlas
mappings:
  arlas_eo:
    headers: null
    location: https://raw.githubusercontent.com/gisaia/ARLAS-EO/master/mapping.json
models:
  arlas_eo:
    headers: null
    location: https://raw.githubusercontent.com/gisaia/ARLAS-EO/master/collection.json
```

The [`arlas`](#arlas) section contains the different deployment configurations. The [mapping](#mappings) section lists the mapping template that you can use.
 Finally, the [models](#models) are the templates for the collections. A [detailed description](model/README.md) of the configuration structure is provided.

### arlas

#### ARLAS Authentication

- ARLAS server url
- organisation
- arlas-iam
- token-url
- auth-header
- login
- password
- client-id
- client-secret
- grant-type

#### Elasticsearch

- url
- login
- password
- header

### mappings

### models
 
## Create, describe and delete a configuration for `arlas_cli`

You can edit directly the `${HOME}/.arlas/cli/configuration.yaml` configuration file to update your configurations. You can also use the command line itself.

To list the configurations:
<!-- termynal -->
```shell
> arlas_cli confs list 
+-----------+-----------------------------+
| name      | url                         |
+-----------+-----------------------------+
| local     | http://localhost:9999/arlas |
| test_conf | http://localhost:9999       |
+-----------+-----------------------------+
```

To describe a configuration:

<!-- termynal -->
```shell
> arlas_cli confs describe local 
allow_delete: true
authorization: null
elastic:
  headers:
    Content-Type: application/json
  location: http://localhost:9200
server:
  headers:
    Content-Type: application/json
  location: http://localhost:9999/arlas
```

To create a simple configuration:

<!-- termynal -->
```shell
> arlas_cli confs create dev_conf \
  --server http://localhost:9999 \
  --headers "Content-Type:application/json" \
  --elastic http://localhost:9200 \
  --elastic-headers "Content-Type:application/json" \
  --no-allow-delete
```

For an arlas configuration with authentication:

<!-- termynal -->
```shell
> arlas_cli --config-file /tmp/configuration.yaml confs \
    create myarlas_as_user \
    --server http://myserver/arlas \
    --headers "arlas-org-filter:my_org_name" \
    --headers "Content-Type:application/json" \
    --no-allow-delete \
    --auth-token-url http://myserver/arlas_iam_server/session \
    --auth-login user \
    --auth-password my_password \
    --auth-headers "Content-Type:application/json;charset=utf-8"\
    --auth-arlas-iam
```

To delete the configuration:

<!-- termynal -->
```shell
> arlas_cli confs delete dev_conf
```

Also, it is possible to use a different configuration file than the one placed in your home directory (`$HOME/.arlas/cli/configuration.yaml`):

<!-- termynal -->
```shell
> arlas_cli --config-file /tmp/config.yaml        
Warning : no configuration file found, we created an empty one for you (/tmp/config.yaml).
```

## Configure arlas_cli for ARLAS Cloud

To configure `arlas_cli` for your cloud.arlas.io account:

First, set the following environment variables by changing appropriately `SET_THIS_VALUE`:
```shell
export MY_ORGANIZATION=SET_THIS_VALUE
export ARLAS_USER=SET_THIS_VALUE
export ARLAS_PWD=SET_THIS_VALUE
export ELASTIC_ENDPOINT=SET_THIS_VALUE
export ELASTIC_USER=SET_THIS_VALUE
export ELASTIC_PWD=SET_THIS_VALUE
```

Then run the command `arlas_cli confs create cloud.arlas.io` with all the parameters:

```shell
arlas_cli confs \
    create cloud.arlas.io \
    --server "https://cloud.arlas.io/arlas/server" \
    --headers "arlas-org-filter:${MY_ORGANIZATION}" \
    --headers "Content-Type:application/json" \
    --no-allow-delete \
    --auth-token-url https://cloud.arlas.io/arlas/iam/session \
    --auth-login "${ARLAS_USER}" \
    --auth-password "${ARLAS_PWD}" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --auth-org "${MY_ORGANIZATION}" \
    --elastic "${ELASTIC_ENDPOINT}" \
    --elastic-headers "Content-Type:application/json" \
    --elastic-login "${ELASTIC_USER}" \
    --elastic-password "${ELASTIC_PWD}" \
    --elastic-headers "Content-Type:application/json" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --persistence "https://cloud.arlas.io/arlas/persistence" \
    --persistence-headers "Content-Type:application/json" \
    --auth-arlas-iam
```

Check the configuration exists:

```shell
arlas_cli confs list
```

You can now list the collections:

```shell
arlas_cli collections --config cloud.arlas.io list
```

List the indices:

```shell
arlas_cli indices --config cloud.arlas.io list
```

List the persisted elements:

```shell
arlas_cli persist --config cloud.arlas.io groups config.json
```
