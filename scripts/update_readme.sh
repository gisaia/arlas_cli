#!/usr/bin/env bash
set -euo pipefail

[[ -z "$1" ]] && echo "Please provide the version" && exit 1;
VERSION=$1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

$SCRIPT_DIR/build_arlas_cli_image.sh $VERSION

ARLAS_CLI_IMAGE="gisaia/arlas_cli:$VERSION"

# The function runs the --help option of arlas_cli with the given command
run_arlas_cli_help_command() {
    # ${1:+"$@"} tests if ${1} is null or unset, in this case, no param is passed, otherwise "" is passed for the command python -m arlas.cli.cli
    docker run \
        -e GROUP_ID="$(id -g)" \
        -e USER_ID="$(id -u)" \
        --rm \
        $ARLAS_CLI_IMAGE python -m arlas.cli.cli ${1:+"$@"} >> README-ARLAS-CLI-COMMANDS.md
}

# Initialise the README file for this VERSION
echo "# ARLAS Command line for collection management" > README-ARLAS-CLI-COMMANDS.md


export MARKDOWN_SNIPPET_QUOTES="\`\`\`"

# Concatenate the --help of each arlas.cli module in the README-ARLAS-CLI-COMMANDS.md file
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md
echo "python3 -m arlas.cli.cli  --help" >> README-ARLAS-CLI-COMMANDS.md
run_arlas_cli_help_command --help
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md

echo "" >> README-ARLAS-CLI-COMMANDS.md
echo "Actions on collections:" >> README-ARLAS-CLI-COMMANDS.md
echo "" >> README-ARLAS-CLI-COMMANDS.md

echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md
echo "python3 -m arlas.cli.cli collections --help" >> README-ARLAS-CLI-COMMANDS.md
run_arlas_cli_help_command collections --config demo --help
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md

echo "" >> README-ARLAS-CLI-COMMANDS.md
echo "Actions on indices:" >> README-ARLAS-CLI-COMMANDS.md
echo "" >> README-ARLAS-CLI-COMMANDS.md
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md
echo "python3 -m arlas.cli.cli indices --help" >> README-ARLAS-CLI-COMMANDS.md
run_arlas_cli_help_command indices --config demo --help
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md

echo "" >> README-ARLAS-CLI-COMMANDS.md
echo "Actions on configurations:" >> README-ARLAS-CLI-COMMANDS.md
echo "" >> README-ARLAS-CLI-COMMANDS.md
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md
echo "python3 -m arlas.cli.cli confs --help" >> README-ARLAS-CLI-COMMANDS.md
run_arlas_cli_help_command confs --help
echo "${MARKDOWN_SNIPPET_QUOTES}" >> README-ARLAS-CLI-COMMANDS.md
