# About arlas_cli

__ARLAS Command Line Interface__ (`arlas_cli`) is a tool to manage data and [configurations](../../static_docs/concepts.md#arlas-cli-configuration) in ARLAS.

`arlas_cli` is a Python command line for:

- Managing [Elasticsearch indices](../../static_docs/concepts.md#es-index):
    - Generate an index mapping based on [NDJSON data](https://jsonlines.org/){:target="_blank"}
    - Create an index
    - List indices
    - Describe an index
    - Clone an index
    - Migrate an index
    - Delete an index
- Managing [ARLAS collections](../../static_docs/concepts.md#arlas-collection)
    - Create a collection
    - List collections
    - Describe a collection
    - Delete a collection
- Managing [arlas_cli configurations](../../static_docs/concepts.md#arlas-cli-configuration)
    - Register an ARLAS/Elasticsearch configuration, with headers and authentication parameters
    - Login to your ARLAS Cloud account
    - List your configurations
    - Delete a configuration
- Managing [ARLAS Dashboards](../../static_docs/concepts.md#arlas-dashboards) in persistence
    - Create a dashboard from a configuration file
    - List available dashboard
    - Describe a dashboard
    - Delete a dashboard
    - Get the groups accessing dashboards
- Managing [ARLAS Identity and Access](../../static_docs/concepts.md#arlas-iam) (ARLAS IAM)
    - List organisations
    - Add an organisation
    - Within an organisation:
        - List visible collections
        - List groups
        - List users
        - List permissions
        - Add/delete a permission
        - Add/delete a group
        - Add/delete a permission to/from a group
        - Add/delete a user
        - Add/delete a user to/from a group
    - Create a user
    - Activate a user
    - Deactivate a user

Follow the [Getting Started Guide](started.md) to begin using ARLAS CLI.