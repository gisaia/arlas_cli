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

echo "Build and release the image with version ${VERSION}"

# PYTHON PIP
./scripts/publish.sh $VERSION

# CONFIG FILE
python3.10 -m arlas.cli.cli --config-file /tmp/arlas-cli-release.conf --version
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