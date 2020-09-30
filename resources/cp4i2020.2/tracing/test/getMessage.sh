#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/tracing/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/tracing/test/key'

echo "Starting amqsghac" tracemq
/opt/mqm/samp/bin/amqsghac APPQ tracemq

