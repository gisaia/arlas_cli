#!/usr/bin/env sh
set -e

echo "START STACK"
docker compose -p arlas_cli --env-file scripts/stack.env -f docker/dc-test.yaml up -d --remove-orphans --wait


