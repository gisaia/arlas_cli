# Getting started with ARLAS CLI

## Install arlas_cli

To install `arlas_cli`, run the following command from the command line:

```shell
pip install arlas_cli
```

For more details, in particular for installation on Microsoft Windows, see the [Installation Guide](install.md#installation).


## Configuration

!!! warning "Prerequisite"
    For running the various examples below, ARLAS and Elasticsearch must be running on the local machine: 
    
    Clone the [ARLAS Stack Exploration](https://github.com/gisaia/ARLAS-Exploration-stack) project and run `./start.sh` at project root.

!!! tip
    If you want to connect `arlas_cli` to an existing ARLAS Cloud account, simply follow the [configuration guide](configuration.md#arlas-cloud-configuration).

By default, the local configuration is created during the installation. 

To list the available configurations, run the following command from the command line:

<!-- termynal -->
```shell
> arlas_cli confs list
+----------------------+------------------------------------------+
| name                 | url                                      |
+----------------------+------------------------------------------+
| local                | http://localhost/arlas                   |
+----------------------+------------------------------------------+
```

!!! success
    At least the `local` configuration has to be here

It will be used in the tutorial as `--config local`

For more details, see the [Configuration Guide](configuration.md#configuration).

## Tutorial

In the following tutorial, you will see how to:

- Generate an Elasticsearch mapping based on json objects
- Add the mapping in Elasticsearch
- List the Elasticsearch indices
- Add (index) data in the Elasticsearch index
- Get the structure of the mapping
- Add a collection in ARLAS
- List the ARLAS collections
- Get the structure of a ARLAS collection
- Delete a collection from ARLAS
- Delete a mapping from Elasticsearch
- Add, describe, get, list and delete an entry from ARLAS Persistence
- List, create, describe and delete a configuration for `arlas_cli`

... with the `arlas_cli` command line only!

!!! warning "Prerequisite"
    First, let's get a sample data file:
    <!-- termynal -->
    ```shell
    > curl -X GET https://raw.githubusercontent.com/gisaia/arlas-cli/master/tests/sample.json -o sample.json
    ```
    The downloaded `sample.json` contains a sample of processed AIS data.


### Generate the Elasticsearch mapping

Writing the elasticsearch mapping for an index can be laborious. `arlas_cli` does it for you. 
`arlas_cli` can inspect a NDJSON file (one json object per line) and generate the corresponding elasticsearch mapping file.

To generate the mapping file based on that sample, run the following command:
<!-- termynal -->
```shell
> arlas_cli indices \
   --config local \
   mapping sample.json
```

By inspecting the mapping, we notice that the three timestamps are not identified as datetime by `arlas_cli`.

!!! info "--field-mapping"
    The `--field-mapping` option allows to overwrite the detected type.

To generate the mapping with forced types, run the following command:
<!-- termynal -->
```shell
> arlas_cli  indices \
   --config local \
   mapping sample.json \
   --field-mapping track.timestamps.center:date-epoch_second \
   --field-mapping track.timestamps.start:date-epoch_second \
   --field-mapping track.timestamps.end:date-epoch_second \
   --nb-lines 20
```

The three timestamps are now well identified as datetime.

For more details, see the [Indices Mapping Guide](indices.md#mapping).


### Create an empty index from inferred mapping

Once the inferred mapping is fine, an elasticsearch index based on this mapping has to be created.

!!! info "--push-on"
    In the previous `arlas_cli indices mapping` command, the `--push-on` option registers the mapping in the specified index.

    An empty index is created with the inferred mapping

To create the associated empty index `ais_courses` with the `--push-on` option, run the following command:
<!-- termynal -->
```shell
> arlas_cli  indices \
   --config local \
   mapping sample.json \
   --field-mapping track.timestamps.center:date-epoch_second \
   --field-mapping track.timestamps.start:date-epoch_second \
   --field-mapping track.timestamps.end:date-epoch_second \
   --push-on ais_courses
```

For more details, see the [Indices Mapping Guide](indices.md#mapping).

### Inspect the created indices

To check that the index has been created, list the existing index:

<!-- termynal -->
```shell
> arlas_cli indices --config local list
+--------------+--------+-------+--------+
| name         | status | count | size   |
+--------------+--------+-------+--------+
| .arlas       | open   | 4     | 11.9kb |
| ais_courses  | open   | 0     | 249b   |
+--------------+--------+-------+--------+
```

!!! success
    The `ais_courses` index exists and contains 0 elements

To describe the fields of the index, use the `arlas_cli indices describe` command:

<!-- termynal -->
```shell
> arlas_cli indices --config local describe ais_courses
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

It corresponds to the inferred mapping.

### Add data to index

To add data to the created `ais_courses` index, use the `arlas_cli indices data` command with the data file `sample.json`
<!-- termynal -->
```shell
> arlas_cli indices --config local data ais_courses sample.json
```

To check that data has been correctly indexed, inspect the indices with:

<!-- termynal -->
```shell
> arlas_cli indices --config local list
+--------------+--------+-------+--------+
| name         | status | count | size   |
+--------------+--------+-------+--------+
| .arlas       | open   | 4     | 11.9kb |
| ais_courses  | open   | 100   | 1mb    |
+--------------+--------+-------+--------+
```

!!! success
    The `ais_courses` index now contains 100 elements.

### Create a collection

To explore the data in ARLAS, a collection has to be defined on top of an index.

To create an `ais_courses` collection based on the `ais_courses` index, run the following command:

<!-- termynal -->
```shell
> arlas_cli collections \
    --config local \
    create ais_courses \
    --index ais_courses \
    --display-name "AIS Courses" \
    --id-path track.id \
    --centroid-path track.location \
    --geometry-path track.trail \
    --date-path track.timestamps.center
```

The `--index` option define the index to use and the `--display-name` define a pretty name used for collection in ARLAS.

Several elements define the data structure:

- `--id-path`: The data field used as unique id of each element

- `--centroid-path`: The data field containing a point geometry summarizing the location of each element (used for aggregation) 

- `--geometry-path`: The data field containing a geometry to represent the element (can be point, linestring, polygon)

- `--date-path`: The data field containing the date associated to each element (used for timeline)

For more details, see the [Collection Creation Guide](collections.md#create-an-arlas-collection).

### Inspect the created collections

To list the available collections, run the following command:

<!-- termynal -->
```shell
> arlas_cli collections --config local list 
+-------------+-------------+
| name        | index       |
+-------------+-------------+
| ais_courses | ais_courses |
+-------------+-------------+
```

!!! success
    The `ais_courses` collection is now created

To describe the fields of the collection, use the `arlas_cli collections describe` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local describe ais_courses
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

It corresponds to the mapping of the data within the collection

### Delete an index

To remove the indexed data from the local Elasticsearch instance, remove the index with the following command:
<!-- termynal -->
```shell
> arlas_cli indices --config local delete ais_courses
```

Check that `ais_courses` index no longer exists:
<!-- termynal -->
```shell
> arlas_cli indices --config local list
+--------------+--------+-------+--------+
| name         | status | count | size   |
+--------------+--------+-------+--------+
| .arlas       | open   | 4     | 11.9kb |
+--------------+--------+-------+--------+
```

!!! tip
    Before reindexing data, do not forget to [recreate the empty index from inferred mapping](#create-an-empty-index-from-inferred-mapping)

    Collection does not need to be declared again.

### Delete a collection

To delete the `ais_courses` course collection
<!-- termynal -->
```shell
> arlas_cli collections --config local delete courses
```

### Add an ARLAS Dashboard from configuration file

The configuration of an ARLAS Dashboard describes all its elements (widgets, map layers...). Such a file can be directly imported to create a dashboard.

First, let's get an example of a dashboard configuration file:
<!-- termynal -->
```shell
> curl -X GET https://raw.githubusercontent.com/gisaia/arlas-cli/master/tests/dashboard.json -o dashboard.json
```
The downloaded `dashboard.json` contains the configuration of a dashboard to explore AIS data.

<!-- termynal -->
```shell
> arlas_cli persist --config local add ./dashboard.json config.json --name courses_dashboard
32d2624b-d7cd-11ee-9a91-0242ac130004
```

!!! note
    The dashboard generated unique identifier is returned

### List available dashboards

The available dashboards can be list with the following command:

<!-- termynal -->
```shell
> arlas_cli persist --config local zone config.json
+--------------------------------------+-------------------+-------------+------------------+-----------+
| id                                   | name              | zone        | last_update_date | owner     |
+--------------------------------------+-------------------+-------------+------------------+-----------+
| 32d2624b-d7cd-11ee-9a91-0242ac130004 | courses_dashboard | config.json | 1708510231303    | anonymous |
...
+--------------------------------------+-------------------+-------------+------------------+-----------+
```

!!! note
    The created dashboards can be accessed and managed in [ARLAS Hub](../../static_docs/concepts.md#arlas-hub) and edited with [ARLAS Builder](../../static_docs/concepts.md#arlas-builder).

    The `arlas_cli` commands to manage dashboards are detailed in [Persistence Documentation](persist.md).
