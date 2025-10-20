#!/usr/bin/env sh
set -e

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

if [ -d "target" ]; then
  rm -r target
  echo "Existing 'target' directory removed."
fi
mkdir -p target/src/arlas
cp -r arlas target/src/
cp -r  scripts/materials/pip/setup.py target/
cp -r  requirements.txt target/
cp -r  scripts/materials/pip/README.md target/
mkdir target/bin
sed -i.bak 's/arlas_cli_versions/'${VERSION}'/' target/setup.py
sed -i.bak 's/arlas_cli_versions/'${VERSION}'/' target/src/arlas/cli/cli.py

export PYTHONPATH=`pwd`/target/src
cd target

docker run \
        -e GROUP_ID="$(id -g)" \
        -e USER_ID="$(id -u)" \
        --mount dst=/opt/python,src="$PWD",type=bind \
        --rm \
        gisaia/python-3-alpine \
            setup.py sdist bdist_wheel
