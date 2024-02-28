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

echo "Build and releas the image with version ${VERSION}"

# PYTHON PIP
./scripts/publish.sh $VERSION

# CONFIG FILE
rm $HOME/.arlas/cli/configuration.yaml
python3 -m arlas.cli.cli --version
cp $HOME/.arlas/cli/configuration.yaml .
git add configuration.yaml

# Model
export PYTHONPATH=`pwd`
python3 -m arlas.cli.settings > docs/docs/model/model.schema.json
jsonschema2md -d docs/docs/model/ -o docs/docs/model/
rm -r out
git add docs/docs/model

./scripts/mkdocs.sh
mkdocs gh-deploy -f docs/mkdocs.yml

git add version.txt
git commit -m "ARLAS Command line ${VERSION}"
# TAG
git tag -a ${VERSION} -m "ARLAS Command line ${VERSION}"
git push origin ${VERSION}
git push origin master