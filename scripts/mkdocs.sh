#!/bin/bash
set -e

# INDICES
export PYTHONPATH=`pwd`/target/src
stty cols 70

echo "ARLAS Version:" > docs/docs/version.md
cat version.txt >> docs/docs/version.md

cat docs/docs/indices_1.md > docs/docs/indices.md
# general
echo "> arlas_cli indices --help" >> docs/docs/indices.md
python3 -m arlas.cli.cli indices --help >> docs/docs/indices.md
cat docs/docs/indices_2.md >> docs/docs/indices.md

# mapping
echo "> arlas_cli indices --config local mapping --help" >> docs/docs/indices.md
python3 -m arlas.cli.cli indices --config local mapping --help >> docs/docs/indices.md
cat docs/docs/indices_3.md >> docs/docs/indices.md

# create
echo "> arlas_cli indices --config local create --help" >> docs/docs/indices.md
python3 -m arlas.cli.cli indices --config local create --help >> docs/docs/indices.md
cat docs/docs/indices_4.md >> docs/docs/indices.md

# data
echo "> arlas_cli indices --config local data --help" >> docs/docs/indices.md
python3 -m arlas.cli.cli indices --config local data --help >> docs/docs/indices.md
cat docs/docs/indices_5.md >> docs/docs/indices.md


# COLLECTIONS
cat docs/docs/collections_1.md > docs/docs/collections.md
# general
echo "> arlas_cli collections --help" >> docs/docs/collections.md
python3 -m arlas.cli.cli collections --help >> docs/docs/collections.md
cat docs/docs/collections_2.md >> docs/docs/collections.md

# create
echo "> arlas_cli collections --config local create --help" >> docs/docs/collections.md
python3 -m arlas.cli.cli collections --config local create --help >> docs/docs/collections.md
cat docs/docs/collections_3.md >> docs/docs/collections.md

# describe
echo "> arlas_cli collections --config local describe --help" >> docs/docs/collections.md
python3 -m arlas.cli.cli collections --config local describe --help >> docs/docs/collections.md
cat docs/docs/collections_4.md >> docs/docs/collections.md


# PERSISTENCE
cat docs/docs/persist_1.md > docs/docs/persist.md
# general
echo "> arlas_cli persist --help" >> docs/docs/persist.md
python3 -m arlas.cli.cli persist --help >> docs/docs/persist.md
cat docs/docs/persist_2.md >> docs/docs/persist.md

# CONFIGURATIONS
cat docs/docs/confs_1.md > docs/docs/confs.md

# general
echo "> arlas_cli confs --help" >> docs/docs/confs.md
python3 -m arlas.cli.cli confs --help >> docs/docs/confs.md
cat docs/docs/confs_2.md >> docs/docs/confs.md

# create
echo "> arlas_cli confs create --help" >> docs/docs/confs.md
python3 -m arlas.cli.cli confs create --help >> docs/docs/confs.md
cat docs/docs/confs_3.md >> docs/docs/confs.md


pip install mkdocs-material
mkdocs build -f docs/mkdocs.yml  -d ../target/docs
