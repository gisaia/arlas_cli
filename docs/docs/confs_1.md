
!!! tip  
    At its first launch, `arlas_cli` will create a first configuration file for you (`$HOME/.arlas/cli/configuration.yaml`), with two ARLAS configurations, one pointing at a local deployment, one on ARLAS demo (without elasticsearch).

!!! bug 
    If you used the ARLAS Exploration Stack, it is possible that you already have a directory named `$HOME/.arlas`. This directory has been created by docker as root. The owner of the directory must be changed to the local user (`sudo chown ${USER}: $HOME/.arlas`).

## List configuration management commands

<!-- termynal -->
```shell
