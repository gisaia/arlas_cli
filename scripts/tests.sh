#!/bin/sh
set -e

if test -f "/tmp/arlas_cli.yaml"; then
    rm /tmp/arlas_cli.yaml
fi

if test -f "/tmp/arlas_cli_persist"; then
    rm -rf /tmp/arlas_cli_persist
fi

python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml --config-file /tmp/arlas_cli.yaml --version
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml --config-file /tmp/arlas_cli.yaml confs \
    create tests \
    --server http://localhost:9999/arlas \
    --persistence http://localhost:9997/arlas_persistence_server \
    --headers "Content-Type:application/json" \
    --elastic http://localhost:9200 \
    --elastic-headers "Content-Type:application/json" \
    --allow-delete 

# ----------------------------------------------------------
echo "TEST configuration placed in /tmp/"
FILE=/tmp/arlas_cli.yaml
if test -f "$FILE"; then
    echo "OK: $FILE exists."
else
    echo "ERROR: $FILE does not exist."
    exit 1
fi

# ----------------------------------------------------------
echo "TEST add direct mapping on ES"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests create direct_mappping_index --mapping tests/mapping.json
if [ "$? -eq 0" ] ; then
    echo "OK: Mapping added"
else
    echo "ERROR: add direct mapping failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST retrieve direct mapping from ES"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests list | grep direct_mappping_index ; then
    echo "OK: direct mapping found"
else
    echo "ERROR: direct mapping not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST infer mapping and add mapping on ES"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests mapping tests/sample.json --nb-lines 200 --field-mapping track.timestamps.center:date-epoch_second --field-mapping track.timestamps.start:date-epoch_second --field-mapping track.timestamps.end:date-epoch_second --no-fulltext cargo_type --push-on courses
if [ "$? -eq 0" ] ; then
    echo "OK: Mapping inferred and added"
else
    echo "ERROR: infer mapping failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST retrieve mapping from ES"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests list | grep courses ; then
    echo "OK: mapping found"
else
    echo "ERROR: mapping not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe mapping from ES"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests describe courses | grep "track.timestamps.center" | grep "date      "; then
    echo "OK: describe mapping ok"
else
    echo "ERROR: describe mapping failled"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST add data to ES"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests data courses tests/sample.json tests/sample.json
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve hits from ES"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests list | grep courses | grep " 200   "; then
    echo "OK: hundred hits found"
else
    echo "ERROR: hits not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST clone index"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests clone courses courses2 | grep courses2 | grep " 200   "; then
    echo "OK: hundred hits found"
else
    echo "ERROR: hits not found"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST add collection"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests create courses --index courses --display-name courses --id-path track.id --centroid-path track.location --geometry-path track.trail --date-path track.timestamps.center
if [ "$? -eq 0" ] ; then
    echo "OK: data added"
else
    echo "ERROR: add data failed"
    exit 1
fi
sleep 2

# ----------------------------------------------------------
echo "TEST retrieve collection"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests list | grep courses ; then
    echo "OK: collection found"
else
    echo "ERROR: collection not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST set field alias"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests set_alias courses track.visibility.proportion Proportion | grep Proportion ; then
    echo "OK: Alias found"
else
    echo "ERROR: alias not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST set collection name"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests name courses thecourses | grep thecourses ; then
    echo "OK: Collection name found"
else
    echo "ERROR: Collection name not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST describe collection"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests describe courses
if [ "$? -eq 0" ] ; then
    echo "OK: Describe collection ok"
else
    echo "ERROR: Describe collection failed"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST count collection"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests count courses
if [ "$? -eq 0" ] ; then
    echo "OK: Count collection ok"
else
    echo "ERROR: Count collection failed"
    exit 1
fi


# ----------------------------------------------------------
echo "TEST delete collection"
yes | python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete collection ok"
else
    echo "ERROR: delete collection failed"
    exit 1
fi

sleep 2
# ----------------------------------------------------------
echo "TEST collection deleted"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml collections --config tests list| grep courses ; then
    echo "ERROR: collection found, not deleted"
    exit 1
else
    echo "OK: collection deleted"
fi

# ----------------------------------------------------------
echo "TEST delete index"
yes | python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests delete courses
if [ "$? -eq 0" ] ; then
    echo "OK: delete index ok"
else
    echo "ERROR: delete index failed"
    exit 1
fi


sleep 2

# ----------------------------------------------------------
echo "TEST index deleted"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml indices --config tests list| grep courses ; then
    echo "ERROR: index found, not deleted"
    exit 1
else
    echo "OK: index deleted"
fi

# ----------------------------------------------------------
echo "TEST list configurations"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml confs list | grep local ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST create configuration"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml confs create toto --server http://localhost:9999
if [ "$? -eq 0" ] ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST  configuration added"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml confs list | grep toto ; then
    echo "OK: configuration found"
else
    echo "ERROR: configuration not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST delete configuration"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml confs delete toto
if [ "$? -eq 0" ] ; then
    echo "OK: configuration deleted"
else
    echo "ERROR: configuration not deleted"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST add entry"
id=`python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml persist --config tests add README.md my_zone --name toto`

# ----------------------------------------------------------
echo "TEST entry found (${id})"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml persist --config tests zone my_zone | grep toto ; then
    echo "OK: entry found"
else
    echo "ERROR: entry not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST entry content is same as sent"
python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml persist  --config tests get $id > /tmp/result

if cmp --silent -- /tmp/result README.md; then
    echo "OK: content is the same"
else
    echo "ERROR: content differs"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST entry describe"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml persist --config tests describe $id | grep toto ; then
    echo "OK: entry described"
else
    echo "ERROR: describe not found"
    exit 1
fi

# ----------------------------------------------------------
echo "TEST list groups"
if python3.10 -m arlas.cli.cli --config-file /tmp/arlas_cli.yaml persist --config tests groups my_zone | grep "group/public" ; then
    echo "OK: groups found "
else
    echo "ERROR: groups not found"
    exit 1
fi
