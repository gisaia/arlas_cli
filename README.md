# arlas_cli

__ARLAS Command Line__ (`arlas_cli`) is for managing the ARLAS data and configurations.

See the documentation at https://gisaia.github.io/arlas_cli/

## Developer section

### Run arlas_cli commands locally

To run the commands locally from the project root, simply replace `arlas_cli` by `python3.10 -m arlas.cli.cli`

### Release

To release `arlas_cli`, make sure to be at project root on the branch `master` up to date.

Run in the terminal:

```
./scripts/release.sh {ARLAS_CLI_VERSION}
```