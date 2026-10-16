#!/usr/bin/env bash
set -euo pipefail

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

ARLAS_CLI_IMAGE="gisaia/arlas_cli:$VERSION"
DOCKERFILE_ARLAS_CLI="docker/Dockerfile-arlas_cli"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

$SCRIPT_DIR/set_version.sh $VERSION

# Builds the arlas cli local image. If this image has already been built, then the build is skipped.
build_arlas_cli() {
  if ! docker image inspect "$ARLAS_CLI_IMAGE" >/dev/null 2>&1; then
    echo "ARLAS_CLI_IMAGE '$ARLAS_CLI_IMAGE' not found. Building..."
    docker build -t "$ARLAS_CLI_IMAGE" -f "$PROJECT_DIR/$DOCKERFILE_ARLAS_CLI" "$PROJECT_DIR"
  else
    echo "The docker image '$ARLAS_CLI_IMAGE' already exists. Skipping build."
  fi
}

build_arlas_cli


