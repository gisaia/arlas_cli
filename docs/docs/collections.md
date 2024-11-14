## ARLAS Collections

ARLAS collection are built on top of ES index. They describe yhe basic data structure for visualization and handle data access policy.

`arlas_cli` provide tools to manage the ARLAS collections with the `collections` command. 

**List collections management commands**

<!-- termynal -->
```shell
> arlas_cli collections --help
                                                                      
 Usage: python -m arlas.cli.cli collections [OPTIONS] COMMAND         
 [ARGS]...                                                            
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ *  --config        TEXT  Name of the ARLAS configuration to use    │
│                          from your configuration file              │
│                          (/Users/gaudan/.arlas/cli/configuration.… │
│                          [default: None]                           │
│                          [required]                                │
│    --help                Show this message and exit.               │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ count      Count the number of hits within a collection (or all    │
│            collection if not provided)                             │
│ create     Create a collection                                     │
│ delete     Delete a collection                                     │
│ describe   Describe a collection                                   │
│ list       List collections                                        │
│ name       Set the collection display name                         │
│ private    Set collection visibility to private                    │
│ public     Set collection visibility to public                     │
│ sample     Display a sample of a collection                        │
│ set_alias  Set the collection display name                         │
│ share      Share the collection with the organisation              │
│ unshare    Share the collection with the organisation              │
╰────────────────────────────────────────────────────────────────────╯

```

## create

The ARLAS Collection is linked to an index or even an index pattern.

The command line options let you specify how the index should be used by the collection. 

<!-- termynal -->
```shell
> arlas_cli collections --config local create --help
                                                                      
 Usage: python -m arlas.cli.cli collections create [OPTIONS]          
 COLLECTION                                                           
                                                                      
 Create a collection                                                  
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    collection      TEXT  Collection's name [default: None]       │
│                            [required]                              │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --model                           TEXT  Name of the model within   │
│                                         your configuration, or URL │
│                                         or file path               │
│                                         [default: None]            │
│ --index                           TEXT  Name of the index          │
│                                         referenced by the          │
│                                         collection                 │
│                                         [default: None]            │
│ --display-name                    TEXT  Display name of the        │
│                                         collection                 │
│                                         [default: None]            │
│ --public           --no-public          Whether the collection is  │
│                                         public or not              │
│                                         [default: no-public]       │
│ --owner                           TEXT  Organisation's owner       │
│                                         [default: None]            │
│ --orgs                            TEXT  List of organisations      │
│                                         accessing the collection   │
│ --id-path                         TEXT  Overide the JSON path to   │
│                                         the id field.              │
│                                         [default: None]            │
│ --centroid-path                   TEXT  Overide the JSON path to   │
│                                         the centroid field.        │
│                                         [default: None]            │
│ --geometry-path                   TEXT  Overide the JSON path to   │
│                                         the geometry field.        │
│                                         [default: None]            │
│ --date-path                       TEXT  Overide the JSON path to   │
│                                         the date field.            │
│                                         [default: None]            │
│ --help                                  Show this message and      │
│                                         exit.                      │
╰────────────────────────────────────────────────────────────────────╯

```

!!! note "Collection visibility"
    
    The visibility options (`--public`, `--private`, `--owner` and `--orgs`)  allow you to choose who can access the collection.

!!! note "--owner"
    
    If ARLAS is used with ARLAS IAM (like ARLAS Cloud), then a collection must be associated to an organisation.
    
    Example:

    `--owner your.organisation.com`

    By default, the organisation referenced in your `config` is used as owner.


### Create an ARLAS collection

The collection has to reference an ES index available with the [arlas_cli conf](confs.md#configurations).

The index option set the targeted index:`--index index_name`

!!! tip "Index pattern"

    The collection can target an index pattern. 
    Instead of an index name, the target is an expression using `*` to reference multiple ES indices.

    Example:
    
    `--index index_name_prefix*`

    All the indices have to share exactly the same data mapping.
    
    The data contained in all referenced indices are then explorable together in arlas.
    

The collection also describe a basic structure for spatio-temporel datasets:

- **ID path**: A data field containing unique element identifier. `--id-path unique_id_field`
- **Centroid path**: A data field containing a point geometry used for aggregations `--centroid-path point_geom_field`
- **Geometry path**: A data field containing a geometry representing the element `--geometry-path element_geom_field`
- **Date path**: A data field containing the date associated to each element `--date-path date_field` 

!!! tip "Pretty name"

    A pretty name for the collection can be set at the creation with the `display-name` option

    Example:
    
    `--display-name "Pretty Collection Name"`


To create the collection, run the following command:

<!-- termynal -->
```shell
> arlas_cli  collections \
   --config {local} \
   create {collection_name} \
   --index {index_name} \
   --id-path {unique_id_field} \
   --centroid-path {point_geom_field} \
   --geometry-path {element_geom_field} \
   --date-path {date_field} \
   --display-name {"Pretty Collection Name"}
```

## name

The collection can be defined by a pretty name. It can be set with `name` subcommand:

<!-- termynal -->
```shell
> arlas_cli collections --config local name --help

Usage: arlas_cli collections name [OPTIONS] COLLECTION NAME

  Set the collection display name

Arguments:
  COLLECTION  Collection's name  [required]
  NAME        The display name  [required]

Options:
  --help  Show this message and exit.

```

### Set a pretty name for the collection

The pretty name can be used in ARLAS to display the collection. It can also be set by the `--display-name` option at the [collection creation](#create).

To set it with the `name` subcommand:
```shell
> arlas_cli  collections \
   --config {local} \
   name {collection_name} {"Pretty Collection Name"}
```

## set_alias

The data fields are sometimes not very suitable in ARLAS Exploration dashboards. You can set aliases to improve their display in the interface.

<!-- termynal -->
```shell
> arlas_cli collections --config local set_alias --help

Usage: arlas_cli collections set_alias [OPTIONS] COLLECTION FIELD_PATH
                                       [DISPLAY_NAME]

  Set the collection display name

Arguments:
  COLLECTION      Collection's name  [required]
  FIELD_PATH      The field path  [required]
  [DISPLAY_NAME]  The field's display name. If none provided, then the alias
                  is removed if it existed

Options:
  --help  Show this message and exit.
```
### Set a pretty name for a data field

Each field of the data has a raw name. It can be replaced by a pretty name to display. For example:
```shell
> arlas_cli  collections \
   --config {local} \
   set_alias {collection_name} \
   {raw_field_name} {"Pretty Field Name (unit)"}
```

## list

### List available collections

You can access the list of available collections with the `list` subcommand:

<!-- termynal -->
```shell
> arlas_cli collections --config local set_alias --help

Usage: arlas_cli collections list [OPTIONS]

  List collections

Options:
  --help  Show this message and exit.

```


## describe

### Describe a collection

The `describe` command line provides a description of the collection's structure (fields) and its metadata.

<!-- termynal -->
```shell
> arlas_cli collections --config local describe --help
                                                                      
 Usage: python -m arlas.cli.cli collections describe [OPTIONS]        
 COLLECTION                                                           
                                                                      
 Describe a collection                                                
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    collection      TEXT  Collection's name [default: None]       │
│                            [required]                              │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                        │
╰────────────────────────────────────────────────────────────────────╯

```

## count

### Count the number of element within a collection

The `count` command show the total number of elements (data rows) accessible in a collection.

<!-- termynal -->
```shell
> arlas_cli collections --config local count --help
                                                                      
Usage: arlas_cli collections count [OPTIONS] [COLLECTION]

  Count the number of hits within a collection (or all collection if not
  provided)

Arguments:
  [COLLECTION]  Collection's name

Options:
  --help  Show this message and exit.

```

## sample

### Display a sample of the collection data

The `sample` command show few data rows accessible in a collection.

<!-- termynal -->
```shell
> arlas_cli collections --config local sample --help
                                                                      
Usage: arlas_cli collections sample [OPTIONS] COLLECTION

  Display a sample of a collection

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --pretty / --no-pretty  [default: pretty]
  --size INTEGER          [default: 10]
  --help                  Show this message and exit.
```

!!! note
    The number of rows to display can be set with `--size` option

## private

By default, a collection is private, it can be seen only from the members of the owner or shared organisation.

ARLAS user has to be logged and have the correct rights to access the collection.

### Set the collection as private

To switch a collection from **public** to **private**, use the `private` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local private --help
                                                                      
Usage: arlas_cli collections private [OPTIONS] COLLECTION

  Set collection visibility to private

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --help  Show this message and exit.
```

## public

A public collection can be accessed in ARLAS dashboards without any logging. It can be used to host demo dashboards for example.

### Set the collection as public

To switch a collection from **private** to **public**, use the `public` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local public --help
                                                                      
Usage: arlas_cli collections public [OPTIONS] COLLECTION

  Set collection visibility to public

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --help  Show this message and exit.

```

## share

A collection can be shared between different organisations to make it available for its users.

###  Share collections between organisations

A collection can be shared to other organisation with the `share` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local share --help
                                                                      
Usage: arlas_cli collections public [OPTIONS] COLLECTION

  Set collection visibility to public

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --help  Show this message and exit.
```

## unshare

The right to access a collection can be removed to the users of an organisation.

###  Remove collection access for an organisation

The access to a collection can be removed with the `unshare` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local unshare --help
                                                                      
Usage: arlas_cli collections unshare [OPTIONS] COLLECTION ORGANISATION

  Share the collection with the organisation

Arguments:
  COLLECTION    Collection's name  [required]
  ORGANISATION  Organisation's name  [required]

Options:
  --help  Show this message and exit.

```

## delete

A collection can be deleted. It doesn't delete the data (ES index can still exist) but it will no longer be accessible in ARLAS.

### Delete a collection

The collection can be removed with the `delete` command:

<!-- termynal -->
```shell
> arlas_cli collections --config local delete --help
   
Usage: arlas_cli collections delete [OPTIONS] COLLECTION

  Delete a collection

Arguments:
  COLLECTION  collection's name  [required]

Options:
  --help  Show this message and exit.
```