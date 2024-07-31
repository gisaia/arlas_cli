To configure `arlas_cli` for your cloud.arlas.io account:

First, set the following environment variables by changing appropriately `SET_THIS_VALUE`:
```shell
export MY_ORGANIZATION=SET_THIS_VALUE
export ARLAS_USER=SET_THIS_VALUE
export ARLAS_PWD=SET_THIS_VALUE
export ELASTIC_ENDPOINT=SET_THIS_VALUE
export ELASTIC_USER=SET_THIS_VALUE
export ELASTIC_PWD=SET_THIS_VALUE
```

Then run the command `arlas_cli confs create cloud.arlas.io` with all the parameters:

```shell
arlas_cli confs \
    create cloud.arlas.io \
    --server "https://cloud.arlas.io/arlas/server" \
    --headers "arlas-org-filter:${MY_ORGANIZATION}" \
    --headers "Content-Type:application/json" \
    --no-allow-delete \
    --auth-token-url https://cloud.arlas.io/arlas/iam/session \
    --auth-login "${ARLAS_USER}" \
    --auth-password "${ARLAS_PWD}" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --auth-org "${MY_ORGANIZATION}" \
    --elastic "${ELASTIC_ENDPOINT}" \
    --elastic-headers "Content-Type:application/json" \
    --elastic-login "${ELASTIC_USER}" \
    --elastic-password "${ELASTIC_PWD}" \
    --elastic-headers "Content-Type:application/json" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --persistence "https://cloud.arlas.io/arlas/persistence" \
    --persistence-headers "Content-Type:application/json" \
    --auth-arlas-iam
```

Check the configuration exists:

```shell
arlas_cli confs list
```

You can now list the collections:

```shell
arlas_cli collections --config cloud.arlas.io list
```

List the indices:

```shell
arlas_cli indices --config cloud.arlas.io list
```

List the persisted elements:

```shell
arlas_cli persist --config cloud.arlas.io groups config.json
```
