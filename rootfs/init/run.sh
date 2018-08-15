#!/bin/sh

set -e
# set -x

if [[ "${1:0:1}" = '-' ]]
then
  set -- beanstalkd "$@"
fi

if [[ "$1" = "beanstalkd" ]]
then
  # org=${@}
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      -b)
        # storage path
        storage_path="$2"
        shift # past argument
        shift # past value
        ;;
      *)
        shift
        ;;
    esac
  done
  echo "set persistent storage to: '${storage_path}'"
  [[ -d ${storage_path} ]] || mkdir -p ${storage_path}
fi

exec $@
# $@
