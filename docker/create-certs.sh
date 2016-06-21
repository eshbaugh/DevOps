#!/usr/bin/env bash

#SSL_CONF="/usr/lib/ssl/openssl.cnf"
SSL_CONF="/etc/pki/tls/openssl.cnf"

read -p "Are you running as root /sudo su?  Y to continue, N to abort.  " CONTINUE
CONTINUE_UP=${CONTINUE^^}
if [[ "$CONTINUE_UP" != "Y" ]]; then
  echo "Exiting"
  exit 1
fi

# Create Certificate Authority Keys
openssl genrsa -out ca-priv-key.pem 2048
openssl req -config $SSL_CONF -new -key ca-priv-key.pem -x509 -days 1825 -out ca.pem

# To Inspect Keys
# openssl rsa -in ca-priv-key.pem -noout -text
# openssl x509 -in ca.pem -noout -text

function node_certs() {
  NAME=$1
  echo "Name:" $NAME

  openssl genrsa -out "$NAME"-priv-key.pem 2048

  openssl req -subj "/CN=docker-net" -new -key "$NAME"-priv-key.pem -out "$NAME".csr

  openssl x509 -req -days 1825 -in "$NAME".csr -CA ca.pem -CAkey ca-priv-key.pem -CAcreateserial -out "$NAME"-cert.pem -extensions v3_req -extfile $SSL_CONF

  openssl rsa -in "$NAME"-priv-key.pem -out "$NAME"-priv-key.pem
}

node_certs 'web1'

node_certs 'web2'

echo "Done"
exit 0
