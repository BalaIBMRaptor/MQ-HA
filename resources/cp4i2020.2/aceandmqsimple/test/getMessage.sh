#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/externalqmgr/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/externalqmgr/test/key'

echo "Starting amqsghac" externalmq
/opt/mqm/samp/bin/amqsghac APPQ externalmq
