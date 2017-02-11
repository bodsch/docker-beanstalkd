
CONTAINER  := beanstalkd
IMAGE_NAME := docker-beanstalkd


build:
	docker \
		build \
		--rm --tag=$(IMAGE_NAME) .
	@echo Image tag: ${IMAGE_NAME}

clean:
	docker \
		rmi \
		${IMAGE_NAME}

run:
	docker \
		run \
		--detach \
		--interactive \
		--tty \
		--publish=11300:11300 \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		${IMAGE_NAME}

shell:
	docker \
		run \
		--rm \
		--interactive \
		--tty \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		${IMAGE_NAME} \
		/bin/sh

exec:
	docker \
		exec \
		--interactive \
		--tty \
		${CONTAINER}

remove:
	docker \
		rm \
		${CONTAINER}

stop:
	docker \
		kill ${CONTAINER}

history:
	docker \
		history ${IMAGE_NAME}

