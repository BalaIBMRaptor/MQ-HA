#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/multiinstance.ibmcloud/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/multiinstance.ibmcloud/test/key'

echo "Starting amqsgetc" multiinstancemq
/opt/mqm/samp/bin/amqsghac APPQ multiinstancemq
