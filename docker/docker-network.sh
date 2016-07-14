#!/usr/bin/env bash

# install consul first
# RUn docker with --cluster-store and --cluster-advertise options
# docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem --cluster-store=consul://127.0.0.1:8500 --cluster-advertise=lo:2376 -H=0.0.0.0:2376


docker network create --driver overlay --subnet=10.9.9.0/24 jerry-net

