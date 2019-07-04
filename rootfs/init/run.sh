#!/bin/sh

set -e
set -u

. /init/output.sh

# set the beanstalkd binary, when it missing
if [ "${1:0:1}" = '-' ]
then
  set -- beanstalkd "${@}"
fi

if [ "${1}" = "beanstalkd" ]
then
  /init/configure.sh "${@}"
fi

log_info "start beanstalkd ..."
exec "$@" 2> /dev/null
