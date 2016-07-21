# After creating the certs  in separte shells run the following

NETWORK="enp0s3" 
CERTS="/var/consul/certs"
HOSTNAME="osboxes"

export DOCKER_HOST=tcp://$HOSTNAME:2376 DOCKER_TLS_VERIFY=1
docker daemon --tlsverify --tlscacert=$CERTS/ca.pem --tlscert=$CERTS/server-cert.pem --tlskey=$CERTS/server-key.pem --cluster-store=consul://127.0.0.1:8080 --cluster-advertise=$NETWORK:2376 --cluster-store-opt kv.cacertfile=$CERTS/ca.pem --cluster-store-opt kv.certfile=$CERTS/server-cert.pem --cluster-store-opt kv.keyfile=$CERTS/server-key.pem -H=$HOSTNAME:2376


