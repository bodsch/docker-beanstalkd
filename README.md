# docker-beanstalkd

A Docker container for beanstalkd.

Beanstalk is a simple, fast work queue. [Project at GitHub](http://kr.github.io/beanstalkd/)


# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-beanstalkd.svg?branch=1704-01)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-beanstalkd.svg?branch=1704-01)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-beanstalkd.svg?branch=1704-01)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-beanstalkd/
[microbadger]: https://microbadger.com/images/bodsch/docker-beanstalkd
[travis]: https://travis-ci.org/bodsch/docker-beanstalkd


# Build

Your can use the included Makefile.

To build the Container: `make build`

To remove the builded Docker Image: `make clean`

Starts the Container: `make run`

Starts the Container with Login Shell: `make shell`

Entering the Container: `make exec`

Stop (but **not kill**): `make stop`

History `make history`


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-beanstalkd)

## get

    docker pull bodsch/docker-beanstalkd


# supported Environment Vars



# Ports

 - 11300

