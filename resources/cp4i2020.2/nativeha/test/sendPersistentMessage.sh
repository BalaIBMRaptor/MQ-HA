#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/nativeha/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/nativeha/test/key'

echo "Starting /opt/mqm/samp/bin/amqsputc" nativeha
/opt/mqm/samp/bin/amqsputc APPQ nativeha
