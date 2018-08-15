
include env_make

NS       = bodsch
VERSION ?= latest

REPO     = docker-beanstalkd
NAME     = beanstalkd
INSTANCE = default

BUILD_DATE    := $(shell date +%Y-%m-%d)
BUILD_VERSION := $(shell date +%y%m)
BUILD_TYPE    ?= 'stable'
BEANSTALKD_VERSION ?= 1.10

.PHONY: build push shell run start stop rm release

default: build

params:
	@echo ""
	@echo " BEANSTALKD_VERSION: ${BEANSTALKD_VERSION}"
	@echo " BUILD_DATE        : $(BUILD_DATE)"
	@echo ""

build:	params
	docker build \
		--force-rm \
		--compress \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg BUILD_VERSION=$(BUILD_VERSION) \
		--build-arg BUILD_TYPE=$(BUILD_TYPE) \
		--build-arg BEANSTALKD_VERSION=${BEANSTALKD_VERSION} \
		--tag $(NS)/$(REPO):${BEANSTALKD_VERSION} .

clean:
	docker rmi \
		--force \
		$(NS)/$(REPO):${BEANSTALKD_VERSION}

history:
	docker history \
		$(NS)/$(REPO):${BEANSTALKD_VERSION}

push:
	docker push \
		$(NS)/$(REPO):${BEANSTALKD_VERSION}

shell:
	docker run \
		--rm \
		--name $(NAME)-$(INSTANCE) \
		--interactive \
		--tty \
		--entrypoint "" \
		$(PORTS) \
		$(VOLUMES) \
		$(ENV) \
		$(NS)/$(REPO):${BEANSTALKD_VERSION} \
		/bin/sh

run:
	docker run \
		--rm \
		--name $(NAME)-$(INSTANCE) \
		$(PORTS) \
		$(VOLUMES) \
		$(ENV) \
		$(NS)/$(REPO):${BEANSTALKD_VERSION}

exec:
	docker exec \
		--interactive \
		--tty \
		$(NAME)-$(INSTANCE) \
		/bin/sh

start:
	docker run \
		--detach \
		--name $(NAME)-$(INSTANCE) \
		$(PORTS) \
		$(VOLUMES) \
		$(ENV) \
		$(NS)/$(REPO):${BEANSTALKD_VERSION}

stop:
	docker stop \
		$(NAME)-$(INSTANCE)

rm:
	docker rm \
		$(NAME)-$(INSTANCE)

release: build
	make push -e VERSION=${BEANSTALKD_VERSION}

default: build


