#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance.aws/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance.aws/test/key'

echo "Starting amqsputc" multiinstancemq
/opt/mqm/samp/bin/amqsphac APPQ multiinstancemq
