#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance.ibmcloud/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/multiinstance.ibmcloud/test/key'

echo "Starting amqsgetc" multiinstancemq
/opt/mqm/samp/bin/amqsghac APPQ multiinstancemq
