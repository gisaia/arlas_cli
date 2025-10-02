#!/usr/bin/env sh
set -e

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1

if test -f "$HOME/.pypirc"; then
    echo "$HOME/.pypirc found."
else
    echo "$HOME/.pypirc does not exists. Please create it and set the username/password".
    exit 1
fi

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
echo "\`\`\`" >> README.md
echo "python3 -m arlas.cli.cli  --help" >> README.md
python3.10 -m arlas.cli.cli  --help >> README.md
echo "\`\`\`" >> README.md
echo "" >> README.md
echo "Actions on collections:" >> README.md
echo "" >> README.md
echo "\`\`\`" >> README.md
echo "python3 -m arlas.cli.cli collections --help" >> README.md
python3.10 -m arlas.cli.cli collections  --config demo --help >> README.md
echo "\`\`\`" >> README.md
echo "" >> README.md
echo "Actions on indices:" >> README.md
echo "" >> README.md
echo "\`\`\`" >> README.md
echo "python3 -m arlas.cli.cli indices --help" >> README.md
python3.10 -m arlas.cli.cli indices  --config demo --help >> README.md
echo "\`\`\`" >> README.md
echo "" >> README.md
echo "Actions on configurations:" >> README.md
echo "" >> README.md
echo "\`\`\`" >> README.md
echo "python3 -m arlas.cli.cli confs --help" >> README.md
python3.10 -m arlas.cli.cli confs --help >> README.md
echo "\`\`\`" >> README.md


docker run \
        -e GROUP_ID="$(id -g)" \
        -e USER_ID="$(id -u)" \
        --mount dst=/opt/python,src="$PWD",type=bind \
        --rm \
        gisaia/python-3-alpine \
            setup.py sdist bdist_wheel

docker run --rm \
    -w /opt/python \
    -v $PWD:/opt/python \
    -v $HOME/.pypirc:/root/.pypirc \
    python:3 \
    /bin/bash -c  "pip install twine ; twine upload dist/*"