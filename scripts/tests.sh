#!/bin/sh
set -e

./scripts/start_stack.sh

# ----------------------------------------------------------
echo "TEST default configuration placed in $HOME/.arlas/cli"
rm -f $HOME/.arlas/cli/configuration.yaml
python3 -m arlas.cli.cli --version
FILE=$HOME/.arlas/cli/configuration.yaml
if test -f "$FILE"; then
    echo "OK: $FILE exists."
else
    echo "ERROR: $FILE does not exist."
    exit 1
fi

# ----------------------------------------------------------
echo "TEST infer mapping and add mapping on ES"
python3 -m arlas.cli.cli indices --config local mapping tests/sample.json --nb-lines 10 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --push-on courses
if [ "$? -eq 0" ] ; then
    echo "OK: Mapping infered and added"
else
    echo "ERROR: infer mapping failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST retrieve mapping from ES"
if python3 -m arlas.cli.cli indices --config local list | grep courses ; then
    echo "OK: mapping found"
else
    echo "ERROR: mapping not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe mapping from ES"
if python3 -m arlas.cli.cli indices --config local describe courses | grep "track.timestamps.center" | grep "date      "; then
    echo "OK: describe mapping ok"
else
    echo "ERROR: describe mapping failled"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST add data to ES"
python3 -m arlas.cli.cli indices --config local data courses tests/sample.json
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve hits from ES"
if python3 -m arlas.cli.cli indices --config local list | grep courses | grep " 100   "; then
    echo "OK: hundred hits found"
else
    echo "ERROR: hits not found"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST add collection"
python3 -m arlas.cli.cli collections --config local create courses --index courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve collection"
if python3 -m arlas.cli.cli collections --config local list | grep courses ; then
    echo "OK: collection found"
else
    echo "ERROR: collection not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe collection"
python3 -m arlas.cli.cli collections --config local describe courses
if [ "$? -eq 0" ] ; then
    echo "OK: Describe collection ok"
else
    echo "ERROR: Describe collection failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST count collection"
python3 -m arlas.cli.cli collections --config local count courses
if [ "$? -eq 0" ] ; then
    echo "OK: Count collection ok"
else
    echo "ERROR: Count collection failed"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST delete collection"
yes | python3 -m arlas.cli.cli collections --config local delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete collection ok"
else
    echo "ERROR: delete collection failed"
    exit 1
fi

sleep 2
# ----------------------------------------------------------
echo "TEST collection deleted"
if python3 -m arlas.cli.cli collections --config local list| grep courses ; then
    echo "ERROR: collection found, not deleted"
    exit 1
else
    echo "OK: collection deleted"
fi

# ----------------------------------------------------------
echo "TEST delete index"
yes | python3 -m arlas.cli.cli indices --config local delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete index ok"
else
    echo "ERROR: delete index failed"
    exit 1
fi


sleep 2

# ----------------------------------------------------------
echo "TEST index deleted"
if python3 -m arlas.cli.cli indices --config local list| grep courses ; then
    echo "ERROR: index found, not deleted"
    exit 1
else
    echo "OK: index deleted"
fi

# ----------------------------------------------------------
echo "TEST list configurations"
if python3 -m arlas.cli.cli confs list | grep local ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST create configuration"
python3 -m arlas.cli.cli confs create toto --server http://localhost:9999
if [ "$? -eq 0" ] ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST  configuration added"
if python3 -m arlas.cli.cli confs list | grep toto ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST delete configuration"
python3 -m arlas.cli.cli confs delete toto
if [ "$? -eq 0" ] ; then
    echo "OK: configuration deleted"
else
    echo "ERROR: configuration not deleted"
    exit 1
fi


./scripts/stop_stack.sh