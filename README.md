# docker-beanstalkd

A docker container for beanstalkd.

Beanstalk is a simple, fast work queue. [Project at GitHub](http://kr.github.io/beanstalkd/)


```bash
/ # beanstalkd -h
Use: beanstalkd [OPTIONS]

Options:
 -b DIR   wal directory
 -f MS    fsync at most once every MS milliseconds (use -f0 for "always fsync")
 -F       never fsync (default)
 -l ADDR  listen on address (default is 0.0.0.0)
 -p PORT  listen on port (default is 11300)
 -u USER  become user and group
 -z BYTES set the maximum job size in bytes (default is 65535)
 -s BYTES set the size of each wal file (default is 10485760)
            (will be rounded up to a multiple of 512 bytes)
 -c       compact the binlog (default)
 -n       do not compact the binlog
 -v       show version information
 -V       increase verbosity
 -h       show this help
```


# Status

[![Docker Pulls](https://img.shields.io/docker/pulls/bodsch/docker-beanstalkd.svg)][hub]
[![Image Size](https://images.microbadger.com/badges/image/bodsch/docker-beanstalkd.svg)][microbadger]
[![Build Status](https://travis-ci.org/bodsch/docker-beanstalkd.svg)][travis]

[hub]: https://hub.docker.com/r/bodsch/docker-beanstalkd/
[microbadger]: https://microbadger.com/images/bodsch/docker-beanstalkd
[travis]: https://travis-ci.org/bodsch/docker-beanstalkd


# Build

Your can use the included Makefile.

- To build the Container: `make build`
- To remove the builded Docker Image: `make clean`
- Starts the Container: `make run`
- Starts the Container with Login Shell: `make shell`
- Entering the Container: `make exec`
- Stop (but **not kill**): `make stop`
- History `make history`


# Docker Hub

You can find the Container also at  [DockerHub](https://hub.docker.com/r/bodsch/docker-beanstalkd)

## get

    docker pull bodsch/docker-beanstalkd


# supported Environment Vars



# Ports

- 11300

