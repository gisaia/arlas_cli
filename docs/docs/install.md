# Installation

## Prerequisite

- python 3.10
- pip

## Install

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
    X.X.X
    ```

    The version of `arlas_cli` is `xxx.yyy` where `xxx` is ARLAS Stack main version and `yyy` is the increment of arlas_cli version.
TODO: Check version explanation

## Run ARLAS Locally

arlas_cli is meant to interact with a deployed ARLAS stack. 

To run ARLAS and elasticsearch on the local machine, clone the [ARLAS Stack Exploration](https://github.com/gisaia/ARLAS-Exploration-stack) project and run the stack:

<!-- termynal -->
```shell
> git clone https://github.com/gisaia/ARLAS-Exploration-stack.git
> cd ARLAS-Exploration-stack
> ./start.sh
```

