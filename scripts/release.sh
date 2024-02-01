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
./release/publish.sh $VERSION

# TAG
git tag -a ${VERSION} -m "ARLAS Command line ${VERSION}"
git push origin ${VERSION}
