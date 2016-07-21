#!/usr/bin/env bash

CERTS="/var/consul/certs"
HOSTNAME="osboxes"

docker --tlsverify --tlscacert=$CERTS/ca.pem --tlscert=$CERTS/cert.pem --tlskey=$CERTS/key.pem -H=$HOSTNAME:2376 network create --driver overlay --subnet=10.9.9.0/24 jerry-net

echo "Verify network was created"
docker --tlsverify --tlscacert=$CERTS/ca.pem --tlscert=$CERTS/cert.pem --tlskey=$CERTS/key.pem -H=$HOSTNAME:2376 network ls


