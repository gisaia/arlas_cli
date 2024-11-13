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
    
    The collection can be associated to an organisation.
    
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
   --config local \
   collection_name \
   --index index_name \
   --id-path unique_id_field \
   --centroid-path point_geom_field \
   --geometry-path element_geom_field \
   --date-path date_field \
   --display-name "Pretty Collection Name"
```

## name

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
│ --help                                  Show this message and      │
│                                         exit.                      │
╰────────────────────────────────────────────────────────────────────╯

```

### Set a pretty name for the collection

## set_alias

### Set a pretty name for a data field

## list

### List available collections

## describe

This command line provides a description of the collection structure (fields) and of its metadata.

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
### Describe a collection

## count

### Count the number of element within a collection

## sample

### Display a sample of the collection data

## private

### Set the collection as private

## public

### Set the collection as public

### Define visibility policy for collections

## share

## unshare

###  Share collections between organisations

## delete

### Delete an organisation