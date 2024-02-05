# arlas_cli

ARLAS Command Line is for managing collections and indices.

## Prerequisite

- python 3.11
- pip

## Install

```shell
pip install arlas_cli
```

In a new terminal, you should be able to see the version:
```shell
arlas_cli
```

### Initial Cconfiguration
The confiuration file `~/.arlas/cli/configuration.yaml` must contain the different ARLAS/elasticsearch endpoints you want to interact with. [One is automatically created for your convinience at the first launch](configuration.yaml). It contains the demo endpoint and the localhost endpoint.

The configuration must contain references to collection models for creating collections. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.
It must also contain references to index mappings for creating indices. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.

## Running

```shell
arlas_cli --help
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
arlas_cli local indices \
   mapping sample.json \
   --field-mapping track.timestamps.center:date-epoch_second \
   --field-mapping track.timestamps.start:date-epoch_second \
   --field-mapping track.timestamps.end:date-epoch_second \
   --push-on courses
```

The `--push-on` option registers the mapping in the specified index.

Note that the three timestamps are not identified as datetimes by `arlas_cli`. The `--field-mapping` allows to overwrite the detected type.

### Generate the elasticsearch mapping

To add a specific mapping, it is possible to use the `create`` command:

```shell
arlas_cli local indices \
   create courses \
   --mapping mapping.json 
```

### List indices
```shell
arlas_cli local indices list
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
arlas_cli local indices \
   data courses sample.json
```

### Describe an index

```shell
arlas_cli local indices describe courses
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
arlas_cli local collections \
    create courses \
    --index courses --display-name courses \
    --id-path track.id \
    --centroid-path track.location \
    --geometry-path track.trail \
    --date-path track.timestamps.center
```


### List collections
```shell
arlas_cli local collections list
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
arlas_cli local collections describe courses
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
arlas_cli local collections delete courses
```

### Delete an index
```shell
arlas_cli local indices delete courses
```

Note: by default, it is not allowed to delete an index for a given configuration. To allow deleting, edit the configuration file and set `allow_delete` to `True`.

## Cconfiguration

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
 