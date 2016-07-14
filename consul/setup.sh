#!/usr/bin/env  bash

# STATUS, this script is a record of commands entered manually and has not yet been debuged
# Reference: https://www.consul.io/intro/getting-started/agent.html

apt-get update -y
apt-get install unzip

cd /usr/local/bin

wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip

unzip consul_0.6.4_linux_amd64.zip


adduser consul

mkdir /var/consul

chown consul:consul /var/consul

consul agent -config-dir /etc/consul.d/bootstrap -dev -bind=127.0.0.1

mkdir /etc/consul.d/bootstrap

cat > /etc/consul.d/bootstrap << EOL

{
    "bootstrap": true,
    "server": true,
    "datacenter": "nyc2",
    "data_dir": "/var/consul",
    "encrypt": "Rd6aKIa57f0zStHSawm1dg==",
    "log_level": "INFO",
    "enable_syslog": true
}
EOL

consul agent -config-dir /etc/consul.d/bootstrap -dev -bind=127.0.0.1

