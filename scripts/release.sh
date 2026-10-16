#!/usr/bin/env bash
set -eo pipefail

export RELEASE_COMMAND_LINE="$0 $*"


function clean_exit {
    ARG=$?
    $SCRIPT_DIR/reset_version.sh $VERSION
    exit $ARG
}
trap clean_exit EXIT


[[ -z "$1" ]] && echo "Please provide the version" && exit 1;
VERSION=$1
echo ${VERSION} > version.txt


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if ! command -v mkdocs >/dev/null 2>&1; then
    echo "Error: "[mkdocs]" is not installed. Please install it before continuing." >&2
    exit 1
fi

$SCRIPT_DIR/build_arlas_cli_image.sh $VERSION

ARLAS_CLI_IMAGE="gisaia/arlas_cli:$VERSION"


send_chat_message(){
    MESSAGE=$1
    if [ -z "$GOOGLE_CHAT_RELEASE_CHANEL" ] ; then
        echo "Environement variable GOOGLE_CHAT_RELEASE_CHANEL is not definied ... skipping message publishing"
    else
        DATA='{"text":"'${MESSAGE}'"}'
        echo $DATA
        curl -X POST --header "Content-Type:application/json" $GOOGLE_CHAT_RELEASE_CHANEL -d "${DATA}"
    fi
}

# Generate and publish documentation
$SCRIPT_DIR/update_readme.sh $VERSION
# Generate and publish documentation
$SCRIPT_DIR/generate_doc.sh $VERSION
# Deploy documentation in Github pages
mkdocs gh-deploy -f docs/mkdocs.yml

# Add changed files to git
git add $PROJECT_DIR/arlas/cli/cli.py
git add $PROJECT_DIR/setup.cfg
git add $PROJECT_DIR/version.txt
git add $PROJECT_DIR/docs
git add $PROJECT_DIR/README-ARLAS-CLI-COMMANDS.md
git commit -m "ARLAS Command line ${VERSION}"
# TAG
git tag -a ${VERSION} -m "ARLAS Command line ${VERSION}"
git push origin ${VERSION}
# Reset version to "arlas_cli_version" before pushing to master
$SCRIPT_DIR/reset_version.sh $VERSION

git add $PROJECT_DIR/arlas/cli/cli.py
git add $PROJECT_DIR/setup.cfg
git commit -m "Reset versions to 'arlas_cli_versions'"
git push origin master

send_chat_message "Release of arlas_cli, version ${VERSION}"
send_chat_message "${RELEASE_COMMAND_LINE}"
