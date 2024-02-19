# About arlas_cli

__ARLAS Exploration__ is an Open Source software for exploring and analysing Geo BigData. __ARLAS Command Line__ (`arlas_cli`) is for managing elasticsearch indices, ARLAS collections and elasticsearch/ARLAS endpoint configurations.

`arlas_cli` is a python command line for:

- managing elasticsearch indices:
    - generate an index mapping based on [NDJSON data](https://jsonlines.org/)
    - create an index
    - list indices
    - describe an index
    - delete an index
- managing [ARLAS collections](https://docs.arlas.io/arlas-api-collection/)
    - create a collection
    - list collections
    - describe a collection
    - delete a collection
- managing configurations
    - register an ARLAS/elasticsearch configuration, with headers and authentication parameters
    - delete a configuration

