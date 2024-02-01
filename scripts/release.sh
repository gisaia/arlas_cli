#!/bin/bash
[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

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
python -m arlas.cli.cli
cp $HOME/.arlas/cli/configuration.yaml .
git add configuration.yaml
git commit -m "ARLAS Command line ${VERSION}"
# TAG
git tag -a ${VERSION} -m "ARLAS Command line ${VERSION}"
git push origin ${VERSION}
