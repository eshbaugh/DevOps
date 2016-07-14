#!/usr/bin/env bash

# This example works with docker version 1.12
# based on example: https://docs.docker.com/engine/security/https/ 

openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=osboxes" -sha256 -new -key server-key.pem -out server.csr

echo subjectAltName = IP:10.10.10.20,IP:127.0.0.1 > extfile.cnf # ADD YOUR IPS HERE!!!

openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf

openssl genrsa -out key.pem 4096

openssl req -subj '/CN=client' -new -key key.pem -out client.csr

echo extendedKeyUsage = clientAuth > extfile.cnf

openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem  -CAcreateserial -out cert.pem -extfile extfile.cnf

chmod -v 0400 ca-key.pem key.pem server-key.pem 

chmod -v 0444 ca.pem server-cert.pem cert.pem 

docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem

systemctl stop docker-engine

docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem -H=0.0.0.0:2376

export DOCKER_HOST=tcp://osboxes:2376 DOCKER_TLS_VERIFY=1

#docker --tlsverify --tlscacert=ca.pem --tlscert=/home/admin/certs/cert.pem --tlskey=/home/admin/certs/key.pem -H=osboxes:2376 ps
#docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem --cluster-store=consul://127.0.0.1:8500 --cluster-advertise=lo:2376 -H=0.0.0.0:2376

#docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem --cluster-store=consul://127.0.0.1:8500 --cluster-advertise=enp0s3:2376 --cluster-store-opt kv.cacertfile=/home/admin/certs/ca.pem --cluster-store-opt kv.certfile=/home/admin/certs/server-cert.pem --cluster-store-opt kv.keyfile=/home/admin/certs/server-key.pem -H=0.0.0.0:2376


echo "Done"
exit 0
