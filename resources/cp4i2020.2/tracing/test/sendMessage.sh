#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/tracing/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/tracing/test/key'

echo "Starting amqsphac" tracemq
/opt/mqm/samp/bin/amqsptlc APPQ tracemq
