## ARLAS Persistence

ARLAS Persistence allows you to place files within **zones**.

A **zone** is a group of files of the same nature (configurations, dashboard previews, bookmarks, ...)

A **zone** is visible by **groups**.

It is also possible to set who can access the file.

The main persistence zone is the `config.json` which contains the dashboard configurations.

An entry is an element stored in the persistence.

<!-- termynal -->
```shell
> arlas_cli persist --help
Usage: arlas_cli persist [OPTIONS] COMMAND [ARGS]...

Options:
  --config TEXT  Name of the ARLAS configuration to use from your
                 configuration file
                 (/home/willi/.arlas/cli/configuration.yaml).
  --help         Show this message and exit.

Commands:
  add       Add an entry, returns its ID
  delete    Delete an entry
  describe  Describe an entry
  get       Retrieve an entry
  groups    List groups allowed to access a zone
  zone      List entries within a zone
```

## add

The `persist add` sub-command allows to create an entry from a file.

<!-- termynal -->
```shell
> arlas_cli persist --config local add --help
Usage: arlas_cli persist add [OPTIONS] FILE ZONE

  Add an entry, returns its ID

Arguments:
  FILE  File path  [required]
  ZONE  zone  [required]

Options:
  --name TEXT             name  [default: none]
  --reader TEXT           Readers
  --writer TEXT           writers
  --encode / --no-encode  Encode in BASE64  [default: no-encode]
  --help                  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### Add an entry from a file

For example to create an ARLAS dashboard directly from a json file, run the following command to add the entry to the `config.json` zone:

<!-- termynal -->
```shell
> arlas_cli persist \
    --config {local} \
    add {path/to/config.dashboard.json} config.json \
    --name {dashboard_name}
32d2624b-d7cd-11ee-9a91-0242ac130004
```

The returned identifier is the entry unique identifier.

!!! Note
    The `config.dashboard.json` file has to contain all the dashboard configurations merged (`config.json` and `config.map.json`).

## zone

The available entries in a zone can be listed with the `persist zone` sub-command:

<!-- termynal -->
```shell
> arlas_cli persist --config local zone --help
Usage: arlas_cli persist zone [OPTIONS] ZONE

  List entries within a zone

Arguments:
  ZONE  Zone name  [required]

Options:
  --help  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### List entries within a zone

For example, to list all the available ARLAS dashboards (`config.json` zone), run the following command:

<!-- termynal -->
```shell
> arlas_cli persist --config {local} zone config.json
+--------------------------------------+-------------------+-------------+------------------+-----------+
| id                                   | name              | zone        | last_update_date | owner     |
+--------------------------------------+-------------------+-------------+------------------+-----------+
| 66984014-d0a1-11ee-b41c-0242ac190004 | Courses           | config.json | 1708510231303    | anonymous |
...
+--------------------------------------+-------------------+-------------+------------------+-----------+
```

The `id` is the unique identifier of the entry.

## describe

An entry (defined by its unique identifier) can be described with the `persist describe` sub-command:

<!-- termynal -->
```shell
> arlas_cli persist --config local describe --help
Usage: arlas_cli persist describe [OPTIONS] ID

  Describe an entry

Arguments:
  ID  entry identifier  [required]

Options:
  --help  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### Describe an entry

For example, a dashboard configuration can be described by its metadata with the following command:

<!-- termynal -->
```shell
> arlas_cli persist --config {local} describe {99acb6b7-3cfd-11ef-aee2-2e6497b109c4}
+------------------+--------------------------------------------+
| metadata         | value                                      |
+------------------+--------------------------------------------+
| ID               | 99acb6b7-3cfd-11ef-aee2-2e6497b109c4       |
| name             | AIS Course                                 |
| zone             | config.json                                |
| last_update_date | 2024-10-21T18:02:59.456000                 |
| owner            | 6ce7f1f2-2ee3-4532-987d-26079c1b3043       |
| organization     | gisaia.com                                 |
| ispublic         | False                                      |
| updatable        | True                                       |
| readers          | group/config.json/gisaia.com, group/public |
| writers          | group/config.json/gisaia.com               |
+------------------+--------------------------------------------+
```

In the metadata, we can find which organisation own the dashboard and which groups can access the dashboard as readers and writers.

## get

The content of an entry can be accessed with the `persist get` sub-command:

<!-- termynal -->
```shell
> arlas_cli persist --config local get --help
Usage: arlas_cli persist get [OPTIONS] ID

  Retrieve an entry

Arguments:
  ID  entry identifier  [required]

Options:
  --help  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### Get an entry value

The content of the configuration file of an ARLAS dashboard can be read directly from its entry unique identifier:

<!-- termynal -->
```shell
> arlas_cli persist --config {local} get {32d2624b-d7cd-11ee-9a91-0242ac130004}
{
  "arlas": {
    "web": {
      "contributors": [
...
}
```

## groups

The groups accessing a zone can be listed with the `persist groups` sub-command:

<!-- termynal -->
```shell
> arlas_cli persist --config local groups --help
Usage: arlas_cli persist groups [OPTIONS] ZONE

  List groups allowed to access a zone

Arguments:
  ZONE  Zone name  [required]

Options:
  --help  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### List groups accessing a zone

For example, the groups accessing the dashboards `config.json` zone can be listed with the following command:

<!-- termynal -->
```shell
> arlas_cli persist --config {local} groups config.json
+-------------------------------+
| group                         |
+-------------------------------+
| group/config.json/gisaia.com  |
| group/public                  |
+-------------------------------+
```

## delete

An entry defined by its unique identifier can be deleted with the `persist delete` sub-command:

<!-- termynal -->
```shell
> arlas_cli persist --config local delete --help
Usage: arlas_cli persist delete [OPTIONS] ID

  Delete an entry

Arguments:
  ID  entry identifier  [required]

Options:
  --help  Show this message and exit.

  See full arlas_cli documentation at https://gisaia.github.io/arlas_cli/
```

### Delete an entry

For example, to delete a dashboard from its identifier, run the following command:

<!-- termynal -->
```shell
> arlas_cli persist --config {local} delete {32d2624b-d7cd-11ee-9a91-0242ac130004}
Resource 32d2624b-d7cd-11ee-9a91-0242ac130004 deleted.
```

!!! warning
    A deleted entry cannot be restored.
