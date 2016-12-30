
FROM bodsch/docker-alpine-base:1612-01

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="0.0.1"

EXPOSE 11300

# ---------------------------------------------------------------------------------------

RUN \
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add \
    build-base \
    git && \
  cd /opt && \
  git clone https://github.com/kr/beanstalkd.git && \
  cd beanstalkd && \
  sed -i 's,sys/fcntl.h,fcntl.h,' sd-daemon.c && \
  make && \
  mv beanstalkd /usr/bin/ && \
  apk del --purge \
    build-base \
    git && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/

COPY rootfs/ /

CMD '/bin/sh'

# EOF
