To configure `arlas_cli` for your cloud.arlas.io account:

First, set the following environment variables:
```shell
export MY_ORGANIZATION=my-organization
export ARLAS_USER=my-login
export ARLAS_PWD=my-password
export ELASTIC_ENDPOINT=http://localhost:9200
export ELASTIC_USER=my-login
export ELASTIC_PWD=my-password
```

<!-- termynal -->
```shell
> python3.10 -m arlas.cli.cli confs \
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
    --elastic-headers "Content-Type: application/json" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --persistence "https://cloud.arlas.io/arlas/persistence" \
    --persistence-headers "Content-Type: application/json" \
    --auth-arlas-iam
```


python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml  confs \
    create cloud.arlas.io \
    --server "https://cloud.arlas.io/arlas/server" \
    --headers "arlas-org-filter:XXXXXXX" \
    --headers "Content-Type:application/json" \
    --no-allow-delete \
    --auth-token-url https://cloud.arlas.io/arlas/iam/session \
    --auth-login "XXXXXXX" \
    --auth-password "$XXXXXXX" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --auth-org "XXXXXXX" \
    --elastic "XXXXXXX" \
    --elastic-headers "Content-Type:application/json" \
    --elastic-login "XXXXXXX" \
    --elastic-password "XXXXXXX" \
    --elastic-headers "Content-Type: application/json" \
    --auth-headers "Content-Type:application/json;charset=utf-8" \
    --persistence "https://cloud.arlas.io/arlas/persistence" \
    --persistence-headers "Content-Type: application/json" \
    --auth-arlas-iam