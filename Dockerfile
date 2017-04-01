
FROM alpine:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1702-02"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="v3.5" \
  TERM=xterm

EXPOSE 11300

# ---------------------------------------------------------------------------------------

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main"       > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  apk --quiet --no-cache add \
    build-base \
    git && \
  [ -d /opt ] || mkdir /opt &&\
  cd /opt && \
  git clone https://github.com/kr/beanstalkd.git && \
  cd beanstalkd && \
  sed -i 's,sys/fcntl.h,fcntl.h,' sd-daemon.c && \
  make && \
  mv beanstalkd /usr/bin/ && \
  mkdir /var/cache/beanstalkd && \
  apk del --purge --quiet \
    build-base \
    git && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/

CMD ["/usr/bin/beanstalkd", "-b", "/var/cache/beanstalkd", "-f", "0"]

# EOF
