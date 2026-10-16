#!/usr/bin/env bash
set -e

[[[ -z "$1" ]]] && echo "Please provide the version" && exit 1;
VERSION=$1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ARLAS_CLI_IMAGE="gisaia/arlas_cli:$VERSION"

$SCRIPT_DIR/build_arlas_cli_image.sh $VERSION

# Generate documentation
docker run -t \
        -e GROUP_ID="$(id -g)" \
        -e USER_ID="$(id -u)" \
        --mount dst=/app,src="$PROJECT_DIR",type=bind \
        --rm \
        $ARLAS_CLI_IMAGE python docs/inject_commands.py docs/docs/*.template
