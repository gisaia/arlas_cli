#!/bin/bash
set -e

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1
echo ${VERSION} > version.txt

if test -f "$HOME/.pypirc"; then
    echo "$HOME/.pypirc found."
else
    echo "$HOME/.pypirc does not exists. Please create it and set the username/password".
    exit 1
fi

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
./scripts/publish.sh $VERSION

# Make sure to install the published arlas_cli
sleep 5
pip3.10 install arlas_cli=$VERSION
sleep 5
pip3.10 install arlas_cli=$VERSION

# CONFIG FILE
arlas_cli --config-file /tmp/arlas-cli-release.conf --version
cp /tmp/arlas-cli-release.conf ./configuration.yaml
git add configuration.yaml

# Generate and publish documentation
./mkDocs.sh
pip3.10 install mkdocs-material termynal
mkdocs gh-deploy -f docs/mkdocs.yml

git add version.txt
git add docs
git commit -m "ARLAS Command line ${VERSION}"
# TAG
git tag -a ${VERSION} -m "ARLAS Command line ${VERSION}"
git push origin ${VERSION}
git push origin master

send_chat_message "Release of arlas_cli, version ${VERSION}"
