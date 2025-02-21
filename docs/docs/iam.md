# Identity & Access Management

## Manage organisations, users, permissions and groups

<!-- termynal -->
```shell
> arlas_cli iam --config local orgs --help
                                                                              
 Usage: arlas_cli iam orgs [OPTIONS] COMMAND [ARGS]...                        
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ add                           Create organisation with the given name      │
│ add-apikey                    Add and return an new API Key with           │
│                               permissions associated to provided groups.   │
│                               Use the key id and key secret with the       │
│                               arlas-api-key-id and arlas-api-key-secret    │
│                               headers.                                     │
│ add_group                     Add a group to the organisation              │
│ add_permission                Add a permission to the organisation         │
│ add_permission_to_group       Add a permission to a group within the       │
│                               organisation                                 │
│ add_user                      Add a user to the organisation, and          │
│                               optionally within groups                     │
│ add_user_to_group             Add a user to a group within the             │
│                               organisation                                 │
│ authorize                     Remove an organisation name from the         │
│                               forbidden list.                              │
│ check                         Check if user's organisation exists          │
│ collections                   List the collections of the organisation     │
│ delete                        Delete the organisation                      │
│ delete-apikey                 Delete an API Key                            │
│ delete_group                  Remove the group from the organisation       │
│ delete_permission             Remove the permission from the organisation  │
│ delete_permission_from_group  Remove a permission to a group within the    │
│                               organisation                                 │
│ delete_user                   Remove the user from the organisation        │
│ forbid                        Forbid an organisation name.                 │
│ forbidden                     List forbidden organisations.                │
│ groups                        List the groups of the organisation          │
│ list                          List organisations                           │
│ permissions                   List the permissions of the organisation     │
│ remove_user_from_group        Remove a user from a group within the        │
│                               organisation                                 │
│ users                         List the users of the organisation           │
╰────────────────────────────────────────────────────────────────────────────╯

```

## Create, delete, activate / deactivate users

<!-- termynal -->
```shell
> arlas_cli iam --config local users --help
                                                                              
 Usage: arlas_cli iam users [OPTIONS] COMMAND [ARGS]...                       
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ activate               Activate user account                               │
│ add                    Create user                                         │
│ deactivate             Deactivate user account                             │
│ delete                 Delete user                                         │
│ describe               Describe user                                       │
│ reset-password         Launch reset user's password process                │
│ update                 Update user                                         │
╰────────────────────────────────────────────────────────────────────────────╯

```
