
FROM alpine:3.6

MAINTAINER Bodo Schulz <bodo@boone-schulz.de>

ENV \
  ALPINE_MIRROR="mirror1.hs-esslingen.de/pub/Mirrors" \
  ALPINE_VERSION="v3.6" \
  TERM=xterm \
  BUILD_DATE="2017-08-29" \
  BEANSTALKD_VERSION="1.10+21+gb7b4a6a+mod" \
  APK_ADD="build-base git" \
  APK_DEL="build-base git"

EXPOSE 11300

LABEL \
  version="1708-35" \
  org.label-schema.build-date=${BUILD_DATE} \
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
  apk --no-cache update && \
  apk --no-cache upgrade && \
  apk --no-cache add ${APK_ADD} && \
  [ -d /opt ] || mkdir /opt &&\
  cd /opt && \
  git clone https://github.com/kr/beanstalkd.git && \
  cd beanstalkd && \
  sed -i 's,sys/fcntl.h,fcntl.h,' sd-daemon.c && \
  make && \
  mv beanstalkd /usr/bin/ && \
  mkdir /var/cache/beanstalkd && \
  /usr/bin/beanstalkd -v && \
  apk del --purge ${APK_ADD} && \
  rm -rf \
    /opt/* \
    /tmp/* \
    /var/cache/apk/

CMD ["/usr/bin/beanstalkd", "-b", "/var/cache/beanstalkd", "-f", "0"]

# EOF
