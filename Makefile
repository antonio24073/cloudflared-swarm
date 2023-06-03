include ./env/.env.${ENV}
export

STACK=${ENV}

	
rm:
	- docker stack rm cl_${STACK}
	
build:
	- docker build -t antonio24073/cloudflared:1.0 ./docker-file/

push:
	- docker push antonio24073/cloudflared:1.0

login:
	- COMMAND="login" docker compose -p cl_${STACK} -f ./docker-compose/docker-compose.yml up --build 
	- sleep 1
	- docker logs cl_${STACK}

list:
	- COMMAND="list ${DOMAIN}" docker compose -p cl_${STACK} -f ./docker-compose/docker-compose.yml up
	- docker stop cl_${STACK}

delete:
	- COMMAND="delete ${DOMAIN}" docker compose -p cl_${STACK} -f ./docker-compose/docker-compose.yml up
	- docker stop cl_${STACK}

create:
	- COMMAND="create ${DOMAIN}" docker compose -p cl_${STACK} -f ./docker-compose/docker-compose.yml up
	- docker stop cl_${STACK}

dns:
	- COMMAND="route dns ${DOMAIN} ${CNAME}" docker compose -p cl_${STACK} -f ./docker-compose/docker-compose.yml up
	- docker rm cl_${STACK}

up:
	- COMMAND="--no-autoupdate run ${DOMAIN}" docker stack deploy -c ./docker-compose/docker-compose.yml cl_${STACK}

logs:
	docker service ps -q cl_${STACK}_tunnel -f desired-state=running | \
	while read NODE; do for f in $$NODE; do docker inspect --format '{{.Status.ContainerStatus.ContainerID}}' $$f; done | \
	while read CONTAINER; do docker logs $$CONTAINER; \
	done; \
	done;

watch:
	docker service ps -q cl_${STACK}_tunnel -f desired-state=running | \
	while read NODE; do for f in $$NODE; do docker inspect --format '{{.Status.ContainerStatus.ContainerID}}' $$f; done | \
	while read CONTAINER; do watch docker logs $$CONTAINER; \
	done; \
	done;