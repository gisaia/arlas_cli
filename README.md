# arlas_cli

__ARLAS Command Line__ (`arlas_cli`) is for managing the ARLAS data and configurations.

See the documentation at https://docs.arlas.io/external_docs/arlas_cli/

## Install arlas_cli

To install arlas_cli:

```shell
pip3.10 install "arlas_cli@@git+https://github.com/gisaia/arlas_cli.git@vx.y.z
```

## Developer section

### Run arlas_cli commands locally

To run the commands locally from the project root, simply replace `arlas_cli` by `python3.10 -m arlas.cli.cli`

### Release process

#### Prerequisites

- docker installed
- mkdocs installed (to deploy the documentation in Github pages)
```shell
pip3.10 install mkdocs-material termynal
```

#### Release

To release `arlas_cli`, make sure to be on the branch `master` up to date.

Run in a terminal at project root:

```
./scripts/release.sh {ARLAS_CLI_VERSION}
```