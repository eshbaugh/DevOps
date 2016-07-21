#!/usr/bin/env  bash

echo "------------------------------"
echo "Starting consul single node data store, ctrl+c to abort"

consul agent -config-dir /etc/consul.d/bootstrap -dev -bind=127.0.0.1
