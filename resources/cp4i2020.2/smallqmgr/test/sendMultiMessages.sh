#!/bin/bash
export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/smallqmgr/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/smallqmgr/test/key'

for (( i=0; i<$1; ++i)); do
  echo "Starting amqsphac" smallmq
  /opt/mqm/samp/bin/amqsphac APPQ smallmq &
done
