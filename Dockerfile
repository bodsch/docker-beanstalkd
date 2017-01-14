
FROM bodsch/docker-alpine-base:1701-02

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1.1.0"

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
  mkdir /var/cache/beanstalkd && \
  apk del --purge \
    build-base \
    bash \
    ca-certificates \
    git && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/

CMD ["/usr/bin/beanstalkd", "-b", "/var/cache/beanstalkd", "-f", "0"]

# EOF
