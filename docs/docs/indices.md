## List index management commands

<!-- termynal -->
```shell
> arlas_cli indices --help
                                                                      
 Usage: python -m arlas.cli.cli indices [OPTIONS] COMMAND [ARGS]...   
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ --config        TEXT  Name of the ARLAS configuration to use from  │
│                       your configuration file                      │
│                       (/Users/gaudan/.arlas/cli/configuration.yam… │
│                       [default: None]                              │
│ --help                Show this message and exit.                  │
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

## Generate mapping from a data file


To generate a mapping, you need to provide a NDJSON file (New line delimiter JSON). The first N lines are used for infering the mapping. If the mapping is wrong, you can overwrite the typing with the `--field-mapping` option. Once you're happy with the mapping, you can directly push it on elasticsearch (`--push-on`).

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
│ --field-mapping        TEXT     Override the mapping with the      │
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

## Create an index with its mapping

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

## Index data

For indexing data, you'll need to provide one ore several NDJSON file(s). Indexing uses bulks for optimal performances.

<!-- termynal -->
```shell
> arlas_cli indices --config local data --help
                                                                      
 Usage: python -m arlas.cli.cli indices data [OPTIONS] INDEX FILES... 
                                                                      
 Index data                                                           
                                                                      
╭─ Arguments ────────────────────────────────────────────────────────╮
│ *    index      TEXT      index's name [default: None] [required]  │
│ *    files      FILES...  List of paths to the file(s) containing  │
│                           the data. Format: NDJSON                 │
│                           [default: None]                          │
│                           [required]                               │
╰────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────╮
│ --bulk        INTEGER  Bulk size for indexing data [default: 5000] │
│ --help                 Show this message and exit.                 │
╰────────────────────────────────────────────────────────────────────╯

```
