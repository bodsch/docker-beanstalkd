#!/bin/sh

. /init/output.sh

storage_path=

while [ $# -gt 0 ]
do
  key="${1}"
  case ${key} in
    -b)
      # storage path
      storage_path="${2}"
      shift # past argument
      shift # past value
      ;;
    *)
      shift
      ;;
  esac
done

if [ -n "${storage_path}" ]
then
  log_info "set persistent storage to: '${storage_path}'"
  [ -d "${storage_path}" ] || mkdir -p "${storage_path}"
fi
