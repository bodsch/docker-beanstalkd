#!/bin/bash

cd $(dirname $(readlink -f "$0"))

BEANSTALKD_PORT=11300

# wait for
#
wait_for_beanstalkd() {

  echo "wait for beanstalkd"

  # now wait for ssh port
  RETRY=40
  until [[ ${RETRY} -le 0 ]]
  do
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/127.0.0.1/${BEANSTALKD_PORT}" 2> /dev/null
    if [ $? -eq 0 ]
    then
      break
    else
      sleep 3s
      RETRY=$(expr ${RETRY} - 1)
    fi
  done

  if [[ $RETRY -le 0 ]]
  then
    echo "could not connect to the beanstalkd instance"
    exit 1
  fi

  echo ""
}

send_request() {
  echo "get beanstalkd version .."
  echo "stats" | nc -C -N localhost ${BEANSTALKD_PORT} | grep version
}


inspect() {

  echo ""
  echo "inspect needed containers"
  for d in $(docker ps | tail -n +2 | awk '{print($1)}')
  do
    # docker inspect --format "{{lower .Name}}" ${d}
    c=$(docker inspect --format '{{with .State}} {{$.Name}} has pid {{.Pid}} {{end}}' ${d})
    s=$(docker inspect --format '{{json .State.Health }}' ${d} | jq --raw-output .Status)

    printf "%-40s - %s\n"  "${c}" "${s}"
  done
  echo ""
}


if [[ $(docker ps | tail -n +2 | grep -c beanstalkd) -eq 1 ]]
then
  inspect
  wait_for_beanstalkd

  send_request

  exit 0
else
  echo "no running beanstalkd container found"
  echo "please run 'make compose-file' and 'docker-compose up --build -d' before"

  exit 1
fi


