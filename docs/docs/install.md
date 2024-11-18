# Installation

## Prerequisites

- python 3.10
- pip 

## Install

### Install arlas_cli
Simply run in a terminal:

<!-- termynal -->
```shell
> pip install arlas_cli
```

!!! warning "Microsoft Windows"
    For Windows users, the installation has to be made in a python virtual environment, follow the [venv guide](#python-virtual-environment) before installing.

!!! success

    In a new Terminal/Powershell, you should be able to run it:
    
    <!-- termynal -->
    ```shell
    > arlas_cli --version
    X.Y.Z
    ```

    The version of `arlas_cli` is `X.Y.Z` where `X` is ARLAS Stack main version and `Y.Z` is the increment of arlas_cli version.

### Python Virtual environment

Particularly on Windows, it is advised to create a python virtual environment with [venv](https://docs.python.org/3.10/library/venv.html#creating-virtual-environments) before installing `arlas_cli`

- Create the environment:
```shell
python -m venv env_arlas_cli
```

- Activate the environment:

=== "Windows"
    with cmd:
    ```cmd
    .\env_arlas_cli\Scripts\Activate.bat
    ```
    with PowerShell:
    ```PowerShell
    .\env_arlas_cli\Scripts\Activate.ps1
    ```

    !!! tip
        On Microsoft Windows, it may be required to enable the Activate.ps1 script by setting the execution policy for the user. 

        You can do this by issuing the following PowerShell command:
        ```PowerShell
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        ```
        See [venv documentation](https://docs.python.org/3.10/library/venv.html#creating-virtual-environments) for more information.

=== "Linux/Mac"
    ```bash
    source env_arlas_cli/bin/activate (Can be added to .bashrc or .zshrc)
    ```

# ARLAS

`arlas_cli` is meant to interact with a deployed ARLAS stack. 

### ARLAS Cloud

If you want to connect arlas_cli to an existing ARLAS Cloud account, simply follow the [configuration guide](configuration.md#arlas-cloud-configuration).

### Run ARLAS Locally

To run the simplest ARLAS stack and Elasticsearch on the local machine, clone the [ARLAS Stack Exploration](https://github.com/gisaia/ARLAS-Exploration-stack) project and run the stack:

<!-- termynal -->
```shell
> git clone https://github.com/gisaia/ARLAS-Exploration-stack.git
> cd ARLAS-Exploration-stack
> ./start.sh
```

More details about deployment can be found on [ARLAS Stack Exploration project](https://github.com/gisaia/ARLAS-Exploration-stack).
