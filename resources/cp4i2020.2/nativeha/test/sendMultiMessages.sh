#!/bin/bash
export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/nativeha/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/nativeha/test/key'

for (( i=0; i<$1; ++i)); do
  echo "Starting amqsphac" nativeha
  /opt/mqm/samp/bin/amqsphac APPQ nativeha &
done