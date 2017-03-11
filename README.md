# DevOps Scripts

This repository contains files that are using to explore DevOps automation.

## Docker TLS encription
Both ca and consul are prerequisites for creating a TLS secure connection to docker and docker network encryption.

This setup is intended for educational purposes only!  Aditional precautions, and perminate orchastration is required in production.

Docker 1.12.0-rc3 or newer is required and not installed by these scripts

#### ca
Certificate Authority
  
#### consul
Consul key value data store
  
#### docker
Utilities to setup secure docker and docker networks using TLS encryption.

### Stack Setup
Run the setup scripts in the ca then consul directory

### Stack Startup 
To start the consul/docker/docker-network stack run the start scripts in different terminal shells so they can be killed independently. 
  
## Other Utilities  
#### solr
This directory is nrelated to the other three this directory contains setup for the solr search engine and zookeeper
