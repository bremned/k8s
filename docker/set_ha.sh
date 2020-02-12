#!/bin/bash -ex
while true ; do 
  sleep 20
  echo "Waiting for RabbitMQ be ready...."
  rabbitmqctl status
  ready=$?
  if [ ${ready} == 0 ]; then
    echo "RabbitMQ is ready, setting ha policy"
    sleep 5
    rabbitmqctl set_policy ha-all '.*' '{{RABBITMQ_HA_POLICY}}' --apply-to queues
    rabbitmqctl set_policy expiry '.*' '{"expires":1800000}' --apply-to queues
    echo "ha-all policy set successfully"
    break
  fi
  echo "RabbitMQ still not ready..."
  sleep 5
done

