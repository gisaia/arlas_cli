#!/bin/sh
set -e

./scripts/start_stack.sh

# ----------------------------------------------------------
echo "TEST default configuration placed in $HOME/.arlas/cli"
rm -f $HOME/.arlas/cli/configuration.yaml
python3 -m arlas.cli.cli --help
FILE=$HOME/.arlas/cli/configuration.yaml
if test -f "$FILE"; then
    echo "OK: $FILE exists."
else
    echo "ERROR: $FILE does not exist."
    exit 1
fi

# ----------------------------------------------------------
echo "TEST infer mapping and add mapping on ES"
python3 -m arlas.cli.cli --config local indices mapping tests/sample.json --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --push-on courses
if [ "$? -eq 0" ] ; then
    echo "OK: Mapping infered and added"
else
    echo "ERROR: infer mapping failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST retrieve mapping from ES"
if python3 -m arlas.cli.cli --config local indices list | grep courses ; then
    echo "OK: mapping found"
else
    echo "ERROR: mapping not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe mapping from ES"
if python3 -m arlas.cli.cli --config local indices describe courses | grep "track.timestamps.center" | grep "date      "; then
    echo "OK: describe mapping ok"
else
    echo "ERROR: describe mapping failled"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST add data to ES"
python3 -m arlas.cli.cli --config local indices data courses tests/sample.json
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve hits from ES"
if python3 -m arlas.cli.cli --config local indices list | grep courses | grep " 2     "; then
    echo "OK: two hits found"
else
    echo "ERROR: hits not found"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST add collection"
python3 -m arlas.cli.cli --config local collections create courses --index courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve collection"
if python3 -m arlas.cli.cli --config local collections list | grep courses ; then
    echo "OK: collection found"
else
    echo "ERROR: collection not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe collection"
python3 -m arlas.cli.cli --config local collections describe courses
if [ "$? -eq 0" ] ; then
    echo "OK: Describe collection ok"
else
    echo "ERROR: Describe collection failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST count collection"
python3 -m arlas.cli.cli --config local collections count courses
if [ "$? -eq 0" ] ; then
    echo "OK: Count collection ok"
else
    echo "ERROR: Count collection failed"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST delete collection"
yes | python3 -m arlas.cli.cli --config local collections delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete collection ok"
else
    echo "ERROR: delete collection failed"
    exit 1
fi

sleep 2
# ----------------------------------------------------------
echo "TEST collection deleted"
if python3 -m arlas.cli.cli --config local collections list | grep courses ; then
    echo "ERROR: collection found, not deleted"
    exit 1
else
    echo "OK: collection deleted"
fi

# ----------------------------------------------------------
echo "TEST delete index"
yes | python3 -m arlas.cli.cli --config local indices delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete index ok"
else
    echo "ERROR: delete index failed"
    exit 1
fi


sleep 2

# ----------------------------------------------------------
echo "TEST index deleted"
if python3 -m arlas.cli.cli --config local indices list | grep courses ; then
    echo "ERROR: index found, not deleted"
    exit 1
else
    echo "OK: index deleted"
fi


./scripts/stop_stack.sh