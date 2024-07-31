## List collections management commands

<!-- termynal -->
```shell
> arlas_cli collections --help
Usage: python -m arlas.cli.cli collections [OPTIONS] COMMAND [ARGS]...

Options:
  --config TEXT  Name of the ARLAS configuration to use from your
                 configuration file
                 (/Users/gaudan/.arlas/cli/configuration.yaml).  [required]
  --help         Show this message and exit.

Commands:
  count     Count the number of hits within a collection (or all...
  create    Create a collection
  delete    Delete a collection
  describe  Describe a collection
  list      List collections
  sample    Display a sample of a collection
```

## Create a collection

You can create a collection from scratch or by providing a collection model (`--model`). The command line options let you specify how the index should be used by the collection. The visibility options (`--public`, `--owner` and `--orgs`)  allow you to choose who can access the collection.

<!-- termynal -->
```shell
> arlas_cli collections --config local create --help
Usage: python -m arlas.cli.cli collections create [OPTIONS] COLLECTION

  Create a collection

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --model TEXT            Name of the model within your configuration, or URL
                          or file path
  --index TEXT            Name of the index referenced by the collection
  --display-name TEXT     Display name of the collection
  --public / --no-public  Whether the collection is public or not  [default:
                          no-public]
  --owner TEXT            Organisation's owner
  --orgs TEXT             List of organisations accessing the collection
  --id-path TEXT          Overide the JSON path to the id field.
  --centroid-path TEXT    Overide the JSON path to the centroid field.
  --geometry-path TEXT    Overide the JSON path to the geometry field.
  --date-path TEXT        Overide the JSON path to the date field.
  --help                  Show this message and exit.
```

## Describe a collection

This command line provides a description of the collection structure (fields) and of its metadata.

<!-- termynal -->
```shell
> arlas_cli collections --config local describe --help
Usage: python -m arlas.cli.cli collections describe [OPTIONS] COLLECTION

  Describe a collection

Arguments:
  COLLECTION  Collection's name  [required]

Options:
  --help  Show this message and exit.
```
