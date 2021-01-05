#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/externalqmgr.921/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/externalqmgr.921/test/key'

echo "Starting amqsghac" externalmqwithoutcustomroute
/opt/mqm/samp/bin/amqsghac APPQ externalmqwithoutcustomroute
