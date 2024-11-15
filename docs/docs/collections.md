## List collections management commands

<!-- termynal -->
```shell
> arlas_cli collections --help
                                                                      
 Usage: python -m arlas.cli.cli collections [OPTIONS] COMMAND         
 [ARGS]...                                                            
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --config        TEXT  Name of the ARLAS configuration to use from  │
│                       your configuration file                      │
│                       (/Users/gaudan/.arlas/cli/configuration.yam… │
│                       [default: None]                              │
│ --help                Show this message and exit.                  │
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
│ set_alias  Set the field display name                              │
│ share      Share the collection with the organisation              │
│ unshare    Unshare the collection with the organisation            │
╰────────────────────────────────────────────────────────────────────╯

```

## Create a collection

You can create a collection from scratch or by providing a collection model (`--model`). The command line options let you specify how the index should be used by the collection. The visibility options (`--public`, `--owner` and `--orgs`)  allow you to choose who can access the collection.

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
│ --id-path                         TEXT  Override the JSON path to  │
│                                         the id field.              │
│                                         [default: None]            │
│ --centroid-path                   TEXT  Override the JSON path to  │
│                                         the centroid field.        │
│                                         [default: None]            │
│ --geometry-path                   TEXT  Override the JSON path to  │
│                                         the geometry field.        │
│                                         [default: None]            │
│ --date-path                       TEXT  Override the JSON path to  │
│                                         the date field.            │
│                                         [default: None]            │
│ --help                                  Show this message and      │
│                                         exit.                      │
╰────────────────────────────────────────────────────────────────────╯

```

## Describe a collection

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
