## Manage persistence

ARLAS Persistence allows you to place files within zones. A zone is visible by groups. It is also possible to set the access: writers, readers and whether it is public or not.

<!-- termynal -->
```shell
> arlas_cli persist --help
                                                                      
 Usage: python -m arlas.cli.cli persist [OPTIONS] COMMAND [ARGS]...   
                                                                      
╭─ Options ──────────────────────────────────────────────────────────╮
│ *  --config        TEXT  Name of the ARLAS configuration to use    │
│                          from your configuration file              │
│                          (/Users/gaudan/.arlas/cli/configuration.… │
│                          [default: None]                           │
│                          [required]                                │
│    --help                Show this message and exit.               │
╰────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────╮
│ add           Add an entry, returns its ID                         │
│ delete        Delete an entry                                      │
│ describe      Describe an entry                                    │
│ get           Retrieve an entry                                    │
│ groups        List groups allowed to access a zone                 │
│ zone          List entries within a zone                           │
╰────────────────────────────────────────────────────────────────────╯

```

## ARLAS Persistence

### Add an entry

<!-- termynal -->
```shell
> arlas_cli persist \
    --config local \
    add path/to/config.json config.json \  
    --name dashboard_name
32d2624b-d7cd-11ee-9a91-0242ac130004
```

### Describe an entry

<!-- termynal -->
```shell
> arlas_cli persist --config local describe 32d2624b-d7cd-11ee-9a91-0242ac130004
+------------------+--------------------------------------+
| metadata         | value                                |
+------------------+--------------------------------------+
| ID               | 6a415cec-d7cd-11ee-9a91-0242ac130004 |
| ispublic         | None                                 |
| last_update_date | 1709298774600                        |
| name             | courses_dashboard                    |
| organization     | None                                 |
| owner            | anonymous                            |
| updatable        | True                                 |
| zone             | config.json                          |
+------------------+--------------------------------------+
```

### Get an entry value

<!-- termynal -->
```shell
> arlas_cli persist --config local get 32d2624b-d7cd-11ee-9a91-0242ac130004
{
  "arlas": {
    "web": {
      "contributors": [
...
}
```

### List entries within a zone

<!-- termynal -->
```shell
> arlas_cli persist --config local zone config.json
+--------------------------------------+-------------------+-------------+------------------+-----------+
| id                                   | name              | zone        | last_update_date | owner     |
+--------------------------------------+-------------------+-------------+------------------+-----------+
| 66984014-d0a1-11ee-b41c-0242ac190004 | Courses           | config.json | 1708510231303    | anonymous |
...
+--------------------------------------+-------------------+-------------+------------------+-----------+
```


### List groups accessing a zone

<!-- termynal -->
```shell
> arlas_cli persist --config local groups config.json
+--------------+
| group        |
+--------------+
| group/public |
+--------------+
```


### Delete an entry

<!-- termynal -->
```shell
> arlas_cli persist --config local delete 32d2624b-d7cd-11ee-9a91-0242ac130004
Resource 32d2624b-d7cd-11ee-9a91-0242ac130004 deleted.
```
