#!/bin/bash

export MQCCDTURL='/home/callum/cp4iexamples/MQonCP4I/resources/cp4i2020.2/securemtls/test/CCDT.JSON'
export MQSSLKEYR='/home/callum/cp4iexamples/MQonCP4I/resources/cp4i2020.2/securemtls/createcerts/application'

echo "Starting amqsgetc" mtlsqm
/opt/mqm/samp/bin/amqsgetc APPQ mtlsqm

