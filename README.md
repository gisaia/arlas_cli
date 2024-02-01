# arlas_cli


ARLAS Command Line is for managing collections and indices. You can list them, get some stats, get their structure, add or delete one.

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

## Configuration
The confiuration file `~/.arlas/cli/configuration.yaml` must contain the different ARLAS/elasticsearch endpoints you want to interact with. [One is automatically created for your convinience at the first launch](configuration.yaml). It contains the demo endpoint and the localhost endpoint.

The configuration must contain references to collection models for creating collections. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.
It must also contain references to index mappings for creating indices. A default one is provided for ARLAS EO. A reference can be an http url or a path to a local file.

## Running

```shell
arlas_cli --help
```

## Examples

### Listing collections
```shell
arlas_cli demo collections list
```
```shell
+------------------------------+------------------------------+
| name                         | index                        |
+------------------------------+------------------------------+
| demo_ais_course              | demo_ais_course              |
| demo_ais_flow                | demo_ais_flow                |
...
| demo_wpi                     | demo_wpi                     |
| metacollection               | .demo_arlas                  |
+------------------------------+------------------------------+
```

### Listing indices
```shell
arlas_cli local indices list
```
```shell
+----------+--------+-------+--------+
| name     | status | count | size   |
+----------+--------+-------+--------+
| .arlas   | open   | 4     | 11.9kb |
| arlas_eo | open   | 0     | 249b   |
+----------+--------+-------+--------+
```

### Describing a collection

```shell
arlas_cli demo collections describe demo_ais_course
```
```shell
+----------------------------------------------------+-----------+
| field name                                         | type      |
+----------------------------------------------------+-----------+
| arrival.address.country                            | KEYWORD   |
| arrival.address.port                               | KEYWORD   |
| arrival.location                                   | GEO_POINT |
| arrival.stop_after.duration_s                      | LONG      |
| arrival.stop_after.location                        | GEO_POINT |
| arrival.stop_after.location_precision.geometry     | GEO_SHAPE |
...
| track.timestamps.start                             | DATE      |
| track.trail                                        | GEO_SHAPE |
| track.trail_geohashes_6                            | GEO_POINT |
| track.visibility.proportion                        | FLOAT     |
+----------------------------------------------------+-----------+
```

### Describing an index

```shell
arlas_cli local indices describe arlas_eo
```
```shell
+---------------------------------------------------------+-----------+
| field name                                              | type      |
+---------------------------------------------------------+-----------+
| assets                                                  | object    |
| bbox                                                    | float     |
| catalog                                                 | keyword   |
...
| properties.view__sun_elevation                          | float     |
| properties.water_coverage                               | float     |
+---------------------------------------------------------+-----------+
```

### Adding an index
```shell
arlas_cli local indices create arlas_eo --mapping arlas_eo
```

### Adding a collection
```shell
arlas_cli local collections create arlas_eo --model arlas_eo --index arlas_eo
```

### Deleting an index
```shell
arlas_cli local indices delete arlas_eo
```

Note: by default, it is not allowed to delete an index for a given configuration. To allow deleting, edit the configuration file and set `allow_delete` to `True`.


### Deleting a collection
```shell
arlas_cli local collections delete arlas_eo
```

### Adding data
```shell
arlas_cli local indices data arlas_eo --help
```
