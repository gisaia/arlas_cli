# arlas_cli

ARLAS Command Line is for managing collections and indices.

## Prerequisite

- python 3.11
- pip

## Install

```shell
pip install arlas_cli
```

In a new terminal, you should be able to run it:
```shell
arlas_cli --help
```

### Initial configuration
The confiuration file `~/.arlas/cli/configuration.yaml` must contain the different ARLAS/elasticsearch endpoints you want to interact with. [One is automatically created for your convinience at the first launch](configuration.yaml). It contains the demo endpoint and the localhost endpoint.

The configuration can contain references to collection models for creating collections. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.
It can also contain references to index mappings for creating indices. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.

## Running

```shell
arlas_cli --version
```

## Examples

In the following examples, you will see how to:
- generate an elasticsearch mapping based on json objects
- add the mapping in elasticsearch
- list the elasticsearch indices
- add (index) data in the elasticsearch index
- get the structure of the mapping
- add a collection in arlas
- list the arlas collection
- get the structure of a arlas collection
- delete a collection from arlas
- delete a mapping from elasticsearch
- list, create, describe and delete a configuration for `arlas_cli`

... with the `arlas_cli` command line only!

We suppose you hava an elasticsearch and arlas server running.

### Generate the elasticsearch mapping

Writing the elasticsearch mapping for an index can be laborious. `arlas_cli` does it for you. `arlas_cli` can inspect a NDJSON file (one json object per line) and generate the corresponding elasticsearch mapping file.

Let's get a sample data file:
```shell
curl -X GET https://raw.githubusercontent.com/gisaia/arlas-cli/master/tests/sample.json -o sample.json
```

Now we can generate the mapping file based on that sample:
```shell
arlas_cli  indices \
   --config local \
   mapping sample.json \
   --field-mapping track.timestamps.center:date-epoch_second \
   --field-mapping track.timestamps.start:date-epoch_second \
   --field-mapping track.timestamps.end:date-epoch_second \
   --push-on courses 
```

The `--push-on` option registers the mapping in the specified index.

Note that the three timestamps are not identified as datetimes by `arlas_cli`. The `--field-mapping` allows to overwrite the detected type.

#### Type identification

A geometry is identified as such if
- it is a geojson
- it is a WKT string
- the fielf name contains `geohash`
- it is a string containing two float seperated by a comma

A date is identified as such if
- its name is one of `timestamp`, `date`, `start` or `end` and that it can be parsed as a date
- its name contains `timestamp`, `date`, `start` or `end` and its values are number within [631152000, 4102444800] or [631152000000, 4102444800000] (year 1950 to 2100)


### Generate the elasticsearch mapping

To add a specific mapping, it is possible to use the `create`` command:

```shell
arlas_cli indices \
   --config local \
   create courses \
   --mapping mapping.json  
```

### List indices
```shell
arlas_cli indices --config local list --config local 
```

returns:

```shell
+----------+--------+-------+--------+
| name     | status | count | size   |
+----------+--------+-------+--------+
| .arlas   | open   | 4     | 11.9kb |
| courses  | open   | 0     | 249b   |
+----------+--------+-------+--------+
```

### Add data
```shell
arlas_cli indices --config local data courses sample.json --config local 
```

### Describe an index

```shell
arlas_cli indices --config local describe courses --config local 
```

returns:

```shell
+----------------------------------------------------+-----------+
| field name                                         | type      |
+----------------------------------------------------+-----------+
| arrival.address.country                            | keyword   |
| arrival.address.port                               | keyword   |
| arrival.location                                   | geo_point |
...
| track.timestamps.start                             | date      |
| track.trail                                        | geo_shape |
| track.trail_geohashes_6                            | geo_point |
| track.visibility.proportion                        | double    |
+----------------------------------------------------+-----------+
```

### Add a collection
```shell
arlas_cli collections \
   --config local \
    create courses \
    --index courses --display-name courses \
    --id-path track.id \
    --centroid-path track.location \
    --geometry-path track.trail \
    --date-path track.timestamps.center 
```


### List collections
```shell
arlas_cli collections --config local list 
```

returns:

```shell
+---------+---------+
| name    | index   |
+---------+---------+
| courses | courses |
+---------+---------+
```

### Describe a collection

```shell
arlas_cli collections --config local describe courses
```

returns:

```shell
+----------------------------------------------------+-----------+
| field name                                         | type      |
+----------------------------------------------------+-----------+
| arrival.address.country                            | KEYWORD   |
| arrival.address.port                               | KEYWORD   |
| arrival.location                                   | GEO_POINT |
| arrival.stop_after.duration_s                      | LONG      |
...
| track.timestamps.start                             | DATE      |
| track.trail                                        | GEO_SHAPE |
| track.trail_geohashes_6                            | GEO_POINT |
| track.visibility.proportion                        | FLOAT     |
+----------------------------------------------------+-----------+
```

### Delete a collection
```shell
arlas_cli collections --config local delete courses
```

### Delete an index
```shell
arlas_cli indices --config local delete courses
```

Note: by default, it is not allowed to delete an index for a given configuration. To allow deleting, edit the configuration file and set `allow_delete` to `True`.



## Configurations

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

The `arlas` section contains the different deployment configurations. The mapping section lists the mapping template that you can use.
 Finaly, the models are the templates for the collections. A [detaild description](docs/model/README.md) of the configuration structure is provided.
 
 ### Create, describe and delete a configuration for `arlas_cli`

You can edit directly the `${HOME}/.arlas/cli/configuration.yaml` configuration file to update your configurations. You can also use the command line itself.

To list the configurations:
```shell
arlas_cli confs list 
```

returns:

```shell
+-----------+-----------------------------+
| name      | url                         |
+-----------+-----------------------------+
| local     | http://localhost:9999/arlas |
| test_conf | http://localhost:9999       |
+-----------+-----------------------------+
```

To describe a configuration:

```shell
arlas_cli confs describe local 
```

returns:

```yaml
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

To create a configuration:

```shell
arlas_cli confs create dev_conf \
  --server http://localhost:9999 \
  --headers "Content-Type:application/json" \
  --elastic http://localhost:9200 \
  --elastic-headers "Content-Type:application/json" \
  --no-allow-delete
```

To delete the configuration:

```shell
arlas_cli confs delete dev_conf
```

Also, it is possible to use a different configuration file than the one placed in your home directory (`$HOME/.arlas/cli/configuration.yaml`):

```shell
arlas_cli --config-file /tmp/config.yaml        
```

returns

```shell
Warning : no configuration file found, we created an empty one for you (/tmp/config.yaml).
```
