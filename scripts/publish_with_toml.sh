#!/usr/bin/env sh
set -e

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1


# Initialising the README file for this VERSION
touch README-${VERSION}.md
echo "# ARLAS Command line for collection management" >> README-${VERSION}.md
sed -i.bak 's/arlas_cli_versions/'${VERSION}'/' README-${VERSION}.md


export PYTHONPATH=`pwd`
echo "\`\`\`" >> README-${VERSION}.md
echo "python3 -m arlas.cli.cli  --help" >> README-${VERSION}.md
python3.10 -m arlas.cli.cli  --help >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "Actions on collections:" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "python3 -m arlas.cli.cli collections --help" >> README-${VERSION}.md
python3.10 -m arlas.cli.cli collections  --config demo --help >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "Actions on indices:" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "python3 -m arlas.cli.cli indices --help" >> README-${VERSION}.md
python3.10 -m arlas.cli.cli indices  --config demo --help >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "Actions on configurations:" >> README-${VERSION}.md
echo "" >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
echo "python3 -m arlas.cli.cli confs --help" >> README-${VERSION}.md
python3.10 -m arlas.cli.cli confs --help >> README-${VERSION}.md
echo "\`\`\`" >> README-${VERSION}.md
