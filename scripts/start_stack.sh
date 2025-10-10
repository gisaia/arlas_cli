#!/usr/bin/env sh
set -e

echo "START STACK"
mkdir -p tmp
cd tmp

REPO_URL="https://github.com/gisaia/ARLAS-Exploration-stack.git"
REPO_DIR="ARLAS-Exploration-stack"

if [ ! -d "$REPO_DIR" ]; then
    git clone "$REPO_URL" "$REPO_DIR"
fi
cd "$REPO_DIR"
./start.sh iam

# Initialize ARLAS with confs an
pip3.10 install arlas-cli
./scripts/init_arlas_cli_confs.sh
./scripts/init_stack_with_data.sh local.iam.admin