
FROM alpine:latest

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

LABEL version="1705-01"

ENV \
  ALPINE_MIRROR="dl-cdn.alpinelinux.org" \
  ALPINE_VERSION="edge" \
  TERM=xterm \
  BUILD_DATE="2017-05-01" \
  BEANSTALKD_VERSION="1.10+21+gb7b4a6a+mod" \
  APK_ADD="build-base git" \
  APK_DEL="build-base git"

EXPOSE 11300

LABEL org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="beanstalkd Docker Image" \
      org.label-schema.description="Inofficial beanstalkd Docker Image" \
      org.label-schema.url="http://kr.github.io/beanstalkd/" \
      org.label-schema.vcs-url="https://github.com/bodsch/docker-beanstalkd" \
      org.label-schema.vendor="Bodo Schulz" \
      org.label-schema.version=${BEANSTALKD_VERSION} \
      org.label-schema.schema-version="1.0" \
      com.microscaling.docker.dockerfile="/Dockerfile" \
      com.microscaling.license="GNU General Public License v3.0"

# ---------------------------------------------------------------------------------------

RUN \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/main"       > /etc/apk/repositories && \
  echo "http://${ALPINE_MIRROR}/alpine/${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
  apk --quiet --no-cache update && \
  apk --quiet --no-cache upgrade && \
  for apk in ${APK_ADD} ; \
  do \
    apk --quiet --no-cache add ${apk} ; \
  done && \
  [ -d /opt ] || mkdir /opt &&\
  cd /opt && \
  git clone https://github.com/kr/beanstalkd.git && \
  cd beanstalkd && \
  sed -i 's,sys/fcntl.h,fcntl.h,' sd-daemon.c && \
  make && \
  mv beanstalkd /usr/bin/ && \
  mkdir /var/cache/beanstalkd && \
  #
  /usr/bin/beanstalkd -v && \
  for apk in ${APK_DEL} ; \
  do \
    apk del --quiet --purge ${apk} ; \
  done && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/

CMD ["/usr/bin/beanstalkd", "-b", "/var/cache/beanstalkd", "-f", "0"]

# EOF
