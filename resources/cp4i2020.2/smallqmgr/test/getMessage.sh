#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/smallqmgr/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/smallqmgr/test/key'

echo "Starting amqsghac" smallmq
/opt/mqm/samp/bin/amqsghac APPQ smallmq

