#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/securemtls/test/CCDT.JSON'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/securemtls/createcerts/application'

echo "Starting amqsputc" mtlsqm
/opt/mqm/samp/bin/amqsputc APPQ mtlsqm 

