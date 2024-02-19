```

## Create a configuration

The configuration file (default is `$HOME/.arlas/cli/configuration.yaml`) contains 3 sections:

- the list of ARLAS configurations
- the list of mappings
- the list of collection models

It is possible, with the `arlas_cli` command line, to manage the ARLAS configurations, but not the two last ones.

An ARLAS Configuration tells `arlas_cli` how to contact ARLAS Server and elasticsearch. It supports the addition of http headers. For ARLAS, keycloak and ARLAS IAM authentications are supported. Default is keycloak, use `--auth-arlas-iam` for ARLAS IAM.

!!! danger  
    By default, it is not possible to run the `delete` command on an elasticsearch with `arlas_cli`. This is to prevent accidental data loass. In order to allow delete on a configuration, use the `--allow-delete` option.

<!-- termynal -->
```shell
