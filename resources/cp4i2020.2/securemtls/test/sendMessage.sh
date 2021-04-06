#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/securemtls/test/CCDT.JSON'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/securemtls/createcerts/application'

echo "Starting amqsputc" mtlsqm
/opt/mqm/samp/bin/amqsputc APPQ mtlsqm
