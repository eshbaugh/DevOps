#!/usr/bin/env bash

if [ $HOSTNAME = "easjerrysolr1" ]; then
  SOLR1=solr11
elif [ $HOSTNAME = "easjerrysolr2" ]; then
  # Test both using solr11
  SOLR1=solr11
else
  echo "Invalid hostname:" $HOSTNAME
  exit -1
fi

# create sample data
echo "creating collection with two shards"

#COLL=$SOLR1'col'
#docker exec -it $SOLR1 /opt/solr/bin/solr create_collection -c $COLL -shards 2 -p 8983
#docker exec -it --user=solr $SOLR1  bin/post -c $COLL example/exampledocs/manufacturers.xml


echo "creating EG data"
EG=$SOLR1'eg'
docker exec -it --user=solr $SOLR1  bin/solr create_collection -c $EG -p 8983
docker exec -it --user=solr $SOLR1  bin/post -c $EG example/exampledocs/manufacturers.xml

echo "done"

exit 0
