# After creating the certs  in separte shells run the following

Shell 1
consul agent -config-dir /etc/consul.d/bootstrap -dev -bind=127.0.0.1


Shell 2
export DOCKER_HOST=tcp://osboxes:2376 DOCKER_TLS_VERIFY=1
docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem --cluster-store=consul://127.0.0.1:8500 --cluster-advertise=enp0s3:2376 --cluster-store-opt kv.cacertfile=/home/admin/certs/ca.pem --cluster-store-opt kv.certfile=/home/admin/certs/server-cert.pem --cluster-store-opt kv.keyfile=/home/admin/certs/server-key.pem -H=osboxes:2376

Shell 3
export DOCKER_HOST=tcp://osboxes:2376 DOCKER_TLS_VERIFY=1
docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem -H=osboxes:2376 network create --driver overlay --subnet=10.9.9.0/24 jerry-net






