## Manage organisations, users, permissions and groups

<!-- termynal -->
```shell
> arlas_cli iam --config local orgs --help
Usage: python -m arlas.cli.cli iam orgs [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add                           Create organisation with the given name
  add_group                     Add a group to the organisation
  add_permission                Add a permission to the organisation
  add_permission_to_group       Add a permission to a group within the...
  add_user_to_group             Add a user to a group within the...
  collections                   List the collections of the organisation
  delete                        Delete the organisation
  delete_group                  Remove the group from the organisation
  delete_permission             Remove the permission from the organisation
  delete_permission_from_group  Remove a permission to a group within the...
  delete_user_from_group        Remove a user from a group within the...
  groups                        List the groups of the organisation
  list                          List organisations
  permissions                   List the permissions of the organisation
  users                         List the users of the organisation
```

## Create, delete, activate / deactivate users

<!-- termynal -->
```shell
> arlas_cli iam --config local users --help
Usage: python -m arlas.cli.cli iam users [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  activate    Activate user account
  add         Create user
  deactivate  Deactivate user account
  delete      Delete user
```
