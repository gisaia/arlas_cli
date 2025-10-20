# Identity & Access Management

## Manage organisations, users, permissions and groups

<!-- termynal -->
```shell
> arlas_cli iam --config local orgs --help
Using configuration 'local'
                                                                              
 Usage: arlas_cli iam orgs [OPTIONS] COMMAND [ARGS]...                        
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ list                           List organisations                          │
│ add                            Create organisation with the given name     │
│ delete                         Delete the organisation                     │
│ collections                    List the collections of the organisation    │
│ users                          List the users of the organisation          │
│ add_user                       Add a user to the organisation, and         │
│                                optionally within groups                    │
│ delete_user                    Remove the user from the organisation       │
│ groups                         List the groups of the organisation         │
│ permissions                    List the permissions of the organisation    │
│ add_group                      Add a group to the organisation             │
│ delete_group                   Remove the group from the organisation      │
│ add_permission                 Add a permission to the organisation        │
│ delete_permission              Remove the permission from the organisation │
│ add_permission_to_group        Add a permission to a group within the      │
│                                organisation                                │
│ delete_permission_from_group   Remove a permission to a group within the   │
│                                organisation                                │
│ add_user_to_group              Add a user to a group within the            │
│                                organisation                                │
│ remove_user_from_group         Remove a user from a group within the       │
│                                organisation                                │
│ add-apikey                     Add and return an new API Key with          │
│                                permissions associated to provided groups.  │
│                                Use the key id and key secret with the      │
│                                arlas-api-key-id and arlas-api-key-secret   │
│                                headers.                                    │
│ delete-apikey                  Delete an API Key                           │
│ check                          Check if user's organisation exists         │
│ forbidden                      List forbidden organisations.               │
│ forbid                         Forbid an organisation name.                │
│ authorize                      Remove an organisation name from the        │
│                                forbidden list.                             │
╰────────────────────────────────────────────────────────────────────────────╯

```

## Create, delete, activate / deactivate users

<!-- termynal -->
```shell
> arlas_cli iam --config local users --help
Using configuration 'local'
                                                                              
 Usage: arlas_cli iam users [OPTIONS] COMMAND [ARGS]...                       
                                                                              
╭─ Options ──────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                │
╰────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────╮
│ add              Create user                                               │
│ describe         Describe user                                             │
│ update           Update user                                               │
│ delete           Delete user                                               │
│ activate         Activate user account                                     │
│ deactivate       Deactivate user account                                   │
│ reset-password   Launch reset user's password process                      │
╰────────────────────────────────────────────────────────────────────────────╯

```
