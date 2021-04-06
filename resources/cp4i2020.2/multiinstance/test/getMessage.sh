#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance/test/key'

echo "Starting amqsgetc" multiinstancemq
/opt/mqm/samp/bin/amqsghac APPQ multiinstancemq
