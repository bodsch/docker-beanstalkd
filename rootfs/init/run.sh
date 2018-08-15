#!/bin/sh

set -e
set -u

. /init/output.sh


if [[ "${1:0:1}" = '-' ]]
then
  set -- beanstalkd "$@"
fi

if [[ "$1" = "beanstalkd" ]]
then
  /init/configure.sh "${@:2}"
fi

log_info "start beanstalkd ..."
exec "$@" 2> /dev/null
