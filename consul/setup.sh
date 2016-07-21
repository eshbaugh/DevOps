#!/usr/bin/env  bash

# STATUS, this script is a record of commands entered manually and has not yet been debuged
# Reference: https://www.consul.io/intro/getting-started/agent.html

CERTS="/var/consul/certs"

apt-get update -y
apt-get install unzip

cd /usr/local/bin

wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip

unzip consul_0.6.4_linux_amd64.zip

adduser consul
mkdir -p $CERTS

mkdir -p /var/consul
chown consul:consul /var/consul
mkdir -p /etc/consul.d/bootstrap

echo "This configuration is for test only, encrypt string is public and always secure your private keys!"

cat > /etc/consul.d/bootstrap/config.json << EOL

{
    "bootstrap": true,
    "server": true,
    "datacenter": "MyLocalVM",
    "data_dir": "/var/consul",
    "encrypt": "Rd6aKIa57f0zStHSawm1dg==",
    "log_level": "INFO",
    "enable_syslog": true,
    "addresses": {
      "https": "0.0.0.0"
    },
    "ports": {
      "https": 8080
    },
    "key_file": "$CERTS/server-key.pem",
    "cert_file": "$CERTS/server-cert.pem",
    "ca_file": "$CERTS/ca.pem"
}

EOL
