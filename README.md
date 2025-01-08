# arlas_cli

__ARLAS Command Line__ (`arlas_cli`) is for managing the ARLAS data and configurations.

See the documentation at https://docs.arlas.io/external_docs/arlas_cli/

## Developer section

### Run arlas_cli commands locally

To run the commands locally from the project root, simply replace `arlas_cli` by `python3.10 -m arlas.cli.cli`

### Release process

#### Prerequisites

- docker installed
- python3.10
- Pypi authentication: a file `~/.pypirc` containing your Pypi account credentials (`{password}` accessible on Bitbucket)

```
[pypi]
  username = __token__
  password = {password}
```

#### Release

To release `arlas_cli`, make sure to be on the branch `master` up to date.

Run in a terminal at project root:

```
./scripts/release.sh {ARLAS_CLI_VERSION}
```