#!/bin/bash

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/ldap/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/ldap/test/key'
export MQSAMP_USER_ID=mqapp

echo "Starting amqsputc" ldapmq
/opt/mqm/samp/bin/amqsputc Q1 ldapmq
