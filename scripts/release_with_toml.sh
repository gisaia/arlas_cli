#!/bin/bash
set -e

export RELEASE_COMMAND_LINE="$0 $*"

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1
echo ${VERSION} > version.txt


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


echo "Build and release the image with version ${VERSION}"

# PYTHON PIP
./scripts/publish_with_toml.sh $VERSION

git add version.txt
git add pyproject.tml
git add setup.cfg
git commit -m "TEST- toml - ARLAS Command line ${VERSION}"
# TAG
git tag -a ${VERSION} -m "TEST- toml - ARLAS Command line ${VERSION}"

# Make sure to install the published arlas_cli
set +e
sleep 5
pip3 install arlas_cli @ git+https://github.com/gisaia/arlas_cli.git@${VERSION}
sleep 5
pip3 install arlas_cli @ git+https://github.com/gisaia/arlas_cli.git@${VERSION}
set -e

# CONFIG FILE
arlas_cli --config-file /tmp/arlas-cli-release.conf --version

