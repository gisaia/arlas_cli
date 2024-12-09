#!/bin/sh -e

# Generate documentation
python3.10 docs/inject_commands.py docs/docs/*.template

# Copy documentation to target
rm -rf target/generated-docs
mkdir -p target/generated-docs

cp -r docs/docs/* target/generated-docs
