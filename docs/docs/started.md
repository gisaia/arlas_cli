Install `arlas_cli` ([prerequisite](install.md#Prerequisite))
<!-- termynal -->
```shell
> pip install arlas_cli
```

!!! warning "Prerequisite"
    For running the various examples bellow, ARLAS and elasticsearch must be running on the local machine.

## Initial configuration
`arlas_cli` uses a yaml file for storing various ARLAS and elasticsearch configurations. By default, the file is located in `~/.arlas/cli/configuration.yaml`. [One is automatically created for your convinience at the first launch](https://raw.githubusercontent.com/gisaia/arlas-cli/master/configuration.yaml). It contains the ARLAS demo endpoint and the local ARLAS and elasticsearch endpoints.

The configuration can also contain references to collection models for creating collections. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.
It can also contain references to index mappings for creating indices. A default one is provided for ARLAS EO.

## Running

<!-- termynal -->
```shell
> arlas_cli --version
0.2.8
Warning : no configuration file found, we created an empty one for 
you (~/.arlas/cli/configuration.yaml).
```

## Examples

In the following examples, you will see how to:

- generate an elasticsearch mapping based on json objects
- add the mapping in elasticsearch
- list the elasticsearch indices
- add (index) data in the elasticsearch index
- get the structure of the mapping
- add a collection in ARLAS
- list the ARLAS collections
- get the structure of a ARLAS collection
- delete a collection from ARLAS
- delete a mapping from elasticsearch
- add, describe, get, list and delete an entry from ARLAS Persistence
- list, create, describe and delete a configuration for `arlas_cli`

... with the `arlas_cli` command line only!

We suppose you have an elasticsearch and arlas server running.

### Generate the elasticsearch mapping

Writing the elasticsearch mapping for an index can be laborious. `arlas_cli` does it for you. `arlas_cli` can inspect a NDJSON file (one json object per line) and generate the corresponding elasticsearch mapping file.

First, let's get a sample data file:
<!-- termynal -->
```shell
> curl -X GET https://raw.githubusercontent.com/gisaia/arlas-cli/master/tests/sample.json -o sample.json
```

Now we can generate the mapping file based on that sample:
<!-- termynal -->
```shell
> arlas_cli  indices \
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
- the field name contains `geohash`
- it is a string containing two float seperated by a comma

A date is identified as such if

- its name is one of `timestamp`, `date`, `start` or `end` and that it can be parsed as a date
- its name contains `timestamp`, `date`, `start` or `end` and its values are number within [631152000, 4102444800] or [631152000000, 4102444800000] (year 1990 to 2100)


### Generate the elasticsearch mapping

To add a specific mapping, it is possible to use the `create`` command:

<!-- termynal -->
```shell
> arlas_cli indices \
   --config local \
   create courses \
   --mapping mapping.json  
```

### List indices
<!-- termynal -->
```shell
> arlas_cli indices --config local list --config local 
+----------+--------+-------+--------+
| name     | status | count | size   |
+----------+--------+-------+--------+
| .arlas   | open   | 4     | 11.9kb |
| courses  | open   | 0     | 249b   |
+----------+--------+-------+--------+
```

### Add data
<!-- termynal -->
```shell
> arlas_cli indices --config local data courses sample.json --config local 
```

### Describe an index

<!-- termynal -->
```shell
> arlas_cli indices --config local describe courses --config local 
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
<!-- termynal -->
```shell
> arlas_cli collections \
   --config local \
    create courses \
    --index courses --display-name courses \
    --id-path track.id \
    --centroid-path track.location \
    --geometry-path track.trail \
    --date-path track.timestamps.center 
```


### List collections
<!-- termynal -->
```shell
> arlas_cli collections --config local list 
+---------+---------+
| name    | index   |
+---------+---------+
| courses | courses |
+---------+---------+
```

### Describe a collection

<!-- termynal -->
```shell
> arlas_cli collections --config local describe courses
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
<!-- termynal -->
```shell
> arlas_cli collections --config local delete courses
```

### Delete an index
<!-- termynal -->
```shell
> arlas_cli indices --config local delete courses
```

!!! Note Delete is not always allowed
    By default, it is not allowed to delete an index for a given configuration. To allow deleting, edit the configuration file and set `allow_delete` to `True`.


## ARLAS Persistence

### Add an entry

<!-- termynal -->
```shell
> arlas_cli persist --config local add ../arlas-stacks4tests/conf/config.json config.json --name courses_dashboard
32d2624b-d7cd-11ee-9a91-0242ac130004
```

### Describe an entry

<!-- termynal -->
```shell
> arlas_cli persist --config local describe 32d2624b-d7cd-11ee-9a91-0242ac130004
+------------------+--------------------------------------+
| metadata         | value                                |
+------------------+--------------------------------------+
| ID               | 6a415cec-d7cd-11ee-9a91-0242ac130004 |
| ispublic         | None                                 |
| last_update_date | 1709298774600                        |
| name             | courses_dashboard                    |
| organization     | None                                 |
| owner            | anonymous                            |
| updatable        | True                                 |
| zone             | config.json                          |
+------------------+--------------------------------------+
```

### Get an entry value

<!-- termynal -->
```shell
> arlas_cli persist --config local get 32d2624b-d7cd-11ee-9a91-0242ac130004
{
  "arlas": {
    "web": {
      "contributors": [
...
}
```

### List entries within a zone

<!-- termynal -->
```shell
> arlas_cli persist --config local zone config.json
+--------------------------------------+-------------------+-------------+------------------+-----------+
| id                                   | name              | zone        | last_update_date | owner     |
+--------------------------------------+-------------------+-------------+------------------+-----------+
| 66984014-d0a1-11ee-b41c-0242ac190004 | Courses           | config.json | 1708510231303    | anonymous |
...
+--------------------------------------+-------------------+-------------+------------------+-----------+
```


### List groups accessing a zone

<!-- termynal -->
```shell
> arlas_cli persist --config local groups config.json
+--------------+
| group        |
+--------------+
| group/public |
+--------------+
```


### Delete an entry

<!-- termynal -->
```shell
> arlas_cli persist --config local delete 32d2624b-d7cd-11ee-9a91-0242ac130004
Resource 32d2624b-d7cd-11ee-9a91-0242ac130004 deleted.
```



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
 Finally, the models are the templates for the collections. A [detailed description](model/README.md) of the configuration structure is provided.
 
### Create, describe and delete a configuration for `arlas_cli`

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
arlas_cli confs describe local 
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
