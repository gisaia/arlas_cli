# Installation

## Prerequisite

- python 3.10
- pip 

## Install

### Python Virtual environment

Particularly on Windows, it is advised to create a python virtual environment with [venv](https://docs.python.org/3.10/library/venv.html#creating-virtual-environments) before installing `arlas_cli`

- Create the environment:
```shell
python -m venv env_arlas_cli
```

- Activate the environment:
=== "Linux/Mac"
    ```bash
    source env_arlas_cli/bin/activate (Can be added to .bashrc or .zshrc)
    ```
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

### Install arlas_cli
Install `arlas_cli` with pip:

<!-- termynal -->
```shell
> pip install arlas_cli
```

!!! success

    In a new terminal, you should be able to run it:
    
    <!-- termynal -->
    ```shell
    > arlas_cli --version
    X.Y.Z
    ```

    The version of `arlas_cli` is `X.Y.Z` where `X` is ARLAS Stack main version and `Y.Z` is the increment of arlas_cli version.

## Run ARLAS Locally

`arlas_cli` is meant to interact with a deployed ARLAS stack. 

To run the simplest ARLAS stack and elasticsearch on the local machine, clone the [ARLAS Stack Exploration](https://github.com/gisaia/ARLAS-Exploration-stack) project and run the stack:

<!-- termynal -->
```shell
> git clone https://github.com/gisaia/ARLAS-Exploration-stack.git
> cd ARLAS-Exploration-stack
> ./start.sh
```

More details about deployment can be found on [ARLAS Stack Exploration project](https://github.com/gisaia/ARLAS-Exploration-stack).
