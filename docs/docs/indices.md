# Indices

## Elasticsearch index

To be explored in ARLAS dashboards, the data has to be indexed in an [elasticsearch](concepts.md#elasticsearch) (ES) [index](concepts.md#es-index). 
An index contains the data and a [mapping](concepts.md#es-mapping) to describe how fields have to be interpreted (types).

`arlas_cli` provide tools to infer mapping from data and manage the ES indices with the `indices` command. 

**List index management commands**

<!-- termynal -->
```shell
> arlas_cli indices --help
                                                                      
 Usage: python -m arlas.cli.cli indices [OPTIONS] COMMAND [ARGS]...   
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ *  --config        TEXT  Name of the ARLAS configuration to use    │
│                          from your configuration file              │
│                          (~/.arlas/cli/configuration.yaml          │
│                          [default: None]                           │
│                          [required]                                │
│    --help                Show this message and exit.               │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ clone     Clone an index and set its name                          │
│ create    Create an index                                          │
│ data      Index data                                               │
│ delete    Delete an index                                          │
│ describe  Describe an index                                        │
│ list      List indices                                             │
│ mapping   Generate the mapping based on the data                   │
│ migrate   Migrate an index on another arlas configuration, and set │
│           the target index name                                    │
│ sample    Display a sample of an index                             │
╰────────────────────────────────────────────────────────────────────╯

```

## mapping

`arlas_cli` provide tools to infer the ES mapping directly from a data file.

<!-- termynal -->
```shell
> arlas_cli indices --config local mapping --help
                                                                      
 Usage: python -m arlas.cli.cli indices mapping [OPTIONS] FILE        
                                                                      
 Generate the mapping based on the data                               
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    file      TEXT  Path to the file containing the data. Format: │
│                      NDJSON                                        │
│                      [default: None]                               │
│                      [required]                                    │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --nb-lines             INTEGER  Number of line to consider for     │
│                                 generating the mapping. Avoid      │
│                                 going over 10.                     │
│                                 [default: 2]                       │
│ --field-mapping        TEXT     Overide the mapping with the       │
│                                 provided field path/type. Example: │
│                                 fragment.location:geo_point.       │
│                                 Important: the full field path     │
│                                 must be provided.                  │
│ --no-fulltext          TEXT     List of keyword or text fields     │
│                                 that should not be in the fulltext │
│                                 search. Important: the field name  │
│                                 only must be provided.             │
│ --push-on              TEXT     Push the generated mapping for the │
│                                 provided index name                │
│                                 [default: None]                    │
│ --help                          Show this message and exit.        │
╰────────────────────────────────────────────────────────────────────╯
```

### Data file

To generate a mapping, you need to provide a NDJSON `file` (New line delimiter JSON).

The values of the first lines of the files are used for inferring the mapping for each field of the data.

!!! note "--nb_lines"
    By default, the `indices mapping` function uses the first 2 rows to infer mapping. 
    If a field is not present in the first rows, it will not appear in the mapping.

    Make sure to take enough rows into account to get all the fields with the option `--nb_lines`

!!! tip
    The data can be split in different NDJSON files in a folder:
    ```
    part-00000-[...].json
    part-00001-[...].json
    ...
    ```
    In practice, the `file` Argument can be filed with a **pattern** such as `path/to/data.json/part-0000*.json` to reference all the different files.


### Type identification

The mapping associates to each field of the data a type (see [elasticsearch type](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html))

A **geometry** is identified as such if

- it is a geojson
- it is a WKT string
- the field name contains `geohash`
- it is a string containing two float separated by a comma

A **date** is identified as such if

- its name is one of `timestamp`, `date`, `start` or `end` and that it can be parsed as a date
- its name contains `timestamp`, `date`, `start` or `end` and its values are number within [631152000, 4102444800] or [631152000000, 4102444800000] (year 1990 to 2100)

!!! note "--field-mapping"
    If the mapping is wrong, you can overwrite the typing with the `--field-mapping` option.

    It has the structure **field_name:field_type** (see [elasticsearch type](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-types.html))

    Examples:

    - `--field-mapping field_point:geo_point`
    - `--field-mapping field_geometry:geo_shape`
    - `--field-mapping field_short_text:keyword`
    - `--field-mapping field_long_text:text`
    - `--field-mapping field_float:double`
    - `--field-mapping field_int:long`

    The date fields have a format that can be specified as **field_name:date-format** with all format accepted by [elasticsearch date type](https://www.elastic.co/guide/en/elasticsearch/reference/current/date.html)

    Examples:

    - `--field-mapping field_time_epoch_second:date-epoch_second`
    - `--field-mapping field_time_epoch_millisecond:date-epoch_millis`
    - `--field-mapping field_time_pattern:date-"yyyy-MM-dd HH:mm:ss"`

By default, the keywords and text fields are searchable as fulltext to be accessible in the searchbar.

!!! note "--no-fulltext "
     
    If it is not required for a given field, it is more optimal to deactivate fulltext search.

    Example:

    - `--no-fulltext field_keyword`

### Created mapping 

By default, the `arlas_cli indices mapping` directly returns the mapping in the command line.

Once you're happy with the mapping, you can either store it in a file or directly push it on elasticsearch.

!!! tip "Store mapping in a file"
    To store the created mapping in a `mapping.json` file, simply use `>` as the end of your command.

    Example:
    <!-- termynal -->
    ```shell
    > arlas_cli  indices \
       --config local \
       mapping path/to/data.json \
       --field-mapping timestamps.start:date-epoch_second \
       --field-mapping timestamps.end:date-epoch_second \
       > path/to/mapping.json
    ```

!!! note "--push-on"

    To push the inferred mapping directly in an elasticsearch index, use the `--push-on` option with the target index name.

    Example:
    <!-- termynal -->
    ```shell
    > arlas_cli  indices \
       --config local \
       mapping path/to/data.json \
       --push-on index_name
    ```
    
    The index is then created and the [index creation command](#create) can be skipped.

## create

Before putting the data in an elasticsearch index, the index has to be initialised with the [correct mapping](#mapping).

The `indices create` sub-function create the index from a mapping json file.

<!-- termynal -->
```shell
> arlas_cli indices --config local create --help
                                                                      
 Usage: python -m arlas.cli.cli indices create [OPTIONS] INDEX        
                                                                      
 Create an index                                                      
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT  index's name [default: None] [required]      │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ *  --mapping        TEXT     Name of the mapping within your       │
│                              configuration, or URL or file path    │
│                              [default: None]                       │
│                              [required]                            │
│    --shards         INTEGER  Number of shards for the index        │
│                              [default: 1]                          │
│    --help                    Show this message and exit.           │
╰────────────────────────────────────────────────────────────────────╯
```

### Create an ES index with its mapping

The index name and the path to the mapping json file have to be used to create the ES index.

The `indices create` sub-function create the index from a mapping json file.

Example:
<!-- termynal -->
```shell
> arlas_cli  indices \
   --config local \
   create index_name \
   --mapping path/to/mapping.json
```

Once the index is created, it is ready to [ingest data](#data).

## data

To explore data in ARLAS, it has to be indexed in the created ES index.

The `indices data` sub-function ingest the data in a given index.

<!-- termynal -->
```shell
> arlas_cli indices --config local data --help
                                                                      
 Usage: python -m arlas.cli.cli indices data [OPTIONS] INDEX FILES... 
                                                                      
 Index data                                                           
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT      index's name [default: None] [required]  │
│ *    files      FILES...  List of paths to the file containing the │
│                           data. Format: NDJSON                     │
│                           [default: None]                          │
│                           [required]                               │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --bulk        INTEGER  Bulk size for indexing data [default: 100]  │
│ --help                 Show this message and exit.                 │
╰────────────────────────────────────────────────────────────────────╯

```
### Ingest data

For indexing data, you'll need to provide one or several NDJSON (New line delimiter JSON) file(s). 
Indexing uses bulks for optimal performances.

Example:
<!-- termynal -->
```shell
> arlas_cli  indices \
   --config local \
   data index_name path/to/data.json
```

!!! warning 
    If the index already contains data, the data is added to the index.
    
    To reindex the same data, delete the index, and do not forget to recreate it with the correct mapping before ingesting the data

!!! note "--bulk"
    Indexing uses bulks for optimal performances. 

    The default size of bulk is 5000 and can be changed with the `--bulk` option

## list

To list the available ES indices, simply use the `indices list` sub-function. No arguments are required.

<!-- termynal -->
```shell
> arlas_cli indices --config local list --help
                                                                      
 Usage: python -m arlas.cli.cli indices help [OPTIONS]
                                                                      
 List indices                                                        
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --help                 Show this message and exit.                 │
╰────────────────────────────────────────────────────────────────────╯

```

### List available ES indices

It displays for each ES index its status, the number of elements it contains and the size of the index. 

Example:

```shell
> arlas_cli indices --config local list
+--------------+--------+-------+--------+
| name         | status | count | size   |
+--------------+--------+-------+--------+
| .arlas       | open   | 4     | 11.9kb |
| index_name   | open   | 100   | 1mb    |
+--------------+--------+-------+--------+
```

## describe

Once the index is created, the description of the fields it contains (corresponding to the mapping) can be displayed with the `indices describe` sub function:

<!-- termynal -->
```shell
> arlas_cli indices --config local data --help
                                                                      
 Usage: python -m arlas.cli.cli indices describe [OPTIONS] INDEX 
                                                                      
 Describe an index                                                          
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT      index's name [default: None] [required]  │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --help                 Show this message and exit.                 │
╰────────────────────────────────────────────────────────────────────╯

```

### Describe the index mapping

For a given index, the description of its fields and their type can be displayed.

For example:

```shell
> arlas_cli indices --config local describe index_name
+------------------+-----------+
| field name       | type      |
+------------------+-----------+
| field_keyword    | keyword   |
| field_point      | geo_point |
| field_long       | long      |
| field_shape      | geo_shape |
| field_double     | double    |
| field_date       | date      |
| field_text       | text      |
| field_object     | object    |
| field_boolean    | boolean   |
+------------------+-----------+

```

## sample

The first rows of the data contained in an index can be displayed with the `indices sample` sub function.

<!-- termynal -->
```shell
> arlas_cli indices --config local delete --help
                                                                      
 Usage: python -m arlas.cli.cli indices sample [OPTIONS] INDEX 
                                                                      
 Display a sample of an index                                                          
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT      index's name [default: None] [required]  │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --pretty / --no-pretty  [default: pretty]                          │
│ --size        INTEGER   [default: 100]                             │
│ --help                  Show this message and exit.                │
╰────────────────────────────────────────────────────────────────────╯

```

### Visualize few rows of your dataset

For a given index `index_name`, the first rows of data can be displayed as a valid json dictionary.

!!! note "--size"
    The number of rows to display (default 100) can be changed

    Example:
    
    ```shell
    > arlas_cli indices --config local sample index_name --size 10
    ```

By default, the json representation of the data is pretty printed (clear indentation and one line per field)

!!! note "--no-pretty"
    The pretty printing can be deactivated and data is displayed in a compact way

    Example:
    
    ```shell
    > arlas_cli indices --config local sample index_name --no-pretty
    ```

## delete

The ES index can be deleted with `indices delete` sub command to free space on ES cluster.

<!-- termynal -->
```shell
> arlas_cli indices --config local delete --help
                                                                      
 Usage: python -m arlas.cli.cli indices delete [OPTIONS] INDEX 
                                                                      
 Delete an index                                                          
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT      index's name [default: None] [required]  │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --help                 Show this message and exit.                 │
╰────────────────────────────────────────────────────────────────────╯

```

### Delete an ES index

To delete an ES index `index_name` on `local` configuration, run the following command:

<!-- termynal -->
```shell
> arlas_cli indices --config local delete index_name
```
!!! warning 
    Delete an index is not reversible. Make sure you don't lost any data. 

!!! Note Delete is not always allowed
    By default, it is not allowed to delete an index for a given configuration. 

    To allow deleting, [edit the configuration file](configuration.md) and set `allow_delete` to `True`.

!!! tip "Good practice: Set admin confs"
    For a given ARLAS deployment, it is advised to set two configurations, with only the admin one with `allow_delete` at `True`.
    
    For example:
    ```
    +----------------------+------------------------------------------+
    | name                 | url                                      |
    +----------------------+------------------------------------------+
    | cloud.arlas.io       | https://cloud.arlas.io/arlas/server      |
    | cloud.arlas.io-admin | https://cloud.arlas.io/arlas/server      |
    | local                | http://localhost/arlas                   |
    +----------------------+------------------------------------------+
    ```
    
    Here the configuration `--config cloud.arlas.io-admin` has to be used to delete any index.
    