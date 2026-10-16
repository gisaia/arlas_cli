#!/usr/bin/env bash
set -euo pipefail

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"


# Set the right version in setup.cfg and arlas/cli/cli.py
sed -i.bak 's/arlas_cli_versions/'${VERSION}'/' $PROJECT_DIR/setup.cfg
sed -i.bak 's/arlas_cli_versions/'${VERSION}'/' $PROJECT_DIR/arlas/cli/cli.py
