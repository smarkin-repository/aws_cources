DOCKER_IMAGE_NAME=simple_app
DOCKER_IMAGE_TAG=0.0.3
DOCKER_LABEL=simple_app
DOCKER_PORT=8088
SERVER_PORT=8080
AWS_ACCOUNT_ID=500480925365
AWS_REGION=eu-north-1

all: image run test

install:
	npm install

image:
	docker build . --build-arg SERVER_PORT=${SERVER_PORT} -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

run: docker-run logs

docker-run:
	docker run -p ${DOCKER_PORT}:${SERVER_PORT} --label ${DOCKER_LABEL} --name ${DOCKER_LABEL} -d ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

logs:
	docker logs $(shell  docker ps -qf "label=${DOCKER_LABEL}" )

kill:
	docker kill $(shell docker ps -qf "label=${DOCKER_LABEL}" )

test:
	curl -i localhost:${DOCKER_PORT}

exec:
	docker exec -it ${DOCKER_LABEL} /bin/sh

deploy:
	aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 500480925365.dkr.ecr.eu-north-1.amazonaws.com/${DOCKER_IMAGE_NAME}
	docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
	docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

pack:
	packer validate ./packer/template.json
