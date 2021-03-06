#/bin/sh

docker swarm join-token --rotate manager
docker swarm join-token --rotate worker

# update tokens in secrets
aws secretsmanager update-secret --secret-id $SWARM_MASTER_TOKEN --secret-string $(docker swarm join-token manager -q) 2>/dev/null
aws secretsmanager update-secret --secret-id $SWARM_WORKER_TOKEN --secret-string $(docker swarm join-token worker -q) 2>/dev/null
