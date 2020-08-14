#!/bin/bash

export MQCCDTURL='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/ldap/test/ccdt.json'
export MQSSLKEYR='/home/callum/2020.2/MQonCP4I/resources/cp4i2020.2/ldap/test/key'
export MQSAMP_USER_ID=mqapp

echo "Starting amqsgetc" ldapmq
/opt/mqm/samp/bin/amqsgetc Q1 ldapmq

