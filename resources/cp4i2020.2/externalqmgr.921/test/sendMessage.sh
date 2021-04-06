#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/externalqmgr.921/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/externalqmgr.921/test/key'

echo "Starting amqsphac" externalmqwithoutcustomroute
/opt/mqm/samp/bin/amqsphac APPQ externalmqwithoutcustomroute
