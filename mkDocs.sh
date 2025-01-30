#!/bin/sh -e

# Copy documentation to target
rm -rf target/generated-docs
mkdir -p target/generated-docs

cp -r docs/docs/* target/generated-docs
