#!/bin/bash
export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/externalqmgr/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/externalqmgr/test/key'

for (( i=0; i<$1; ++i)); do
  echo "Starting amqsphac" externalmq
  /opt/mqm/samp/bin/amqsphac APPQ externalmq &
done
