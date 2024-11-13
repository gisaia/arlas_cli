# About arlas_cli

__ARLAS Exploration__ is an Open Source software for exploring and analysing Geo BigData. 

__ARLAS Command Line__ (`arlas_cli`) is for managing the ARLAS data and configurations.


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
- managing ARLAS persistence
    - create a entry in a zone
    - list entries within a zone
    - describe an entry
    - delete an entry
    - get the groups accessing a zone
- managing ARLAS Identity and Access (ARLAS IAM)
    - list organisations
    - add an organisation
    - within an organisation:
        - list visible collections
        - list groups
        - list users
        - list permissions
        - add/delete a permission
        - add/delete a group
        - add/delete a permission to/from a group
        - add/delete a user
        - add/delete a user to/from a group
    - create a user
    - activate a user
    - deactivate a user
- managing configurations
    - register an ARLAS/elasticsearch configuration, with headers and authentication parameters
    - delete a configuration

