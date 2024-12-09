#!/bin/bash
set -e

python3.10 docs/inject_commands.py docs/docs/*.template

pip3.10 install mkdocs-material termynal
mkdocs build -f docs/mkdocs.yml  -d ../target/docs
