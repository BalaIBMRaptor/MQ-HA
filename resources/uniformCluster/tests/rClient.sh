#!/bin/bash

export MQCCDTURL='/home/callum/uniformCluster/tests/CCDT2.JSON'
export MQSSLKEYR='/home/callum/uniformCluster/tests/key'

CCDT_NAME=${2:-"*ANY_QM"}

for (( i=0; i<$1; ++i)); do
  echo "Starting amqsghac" $CCDT_NAME
  /opt/mqm/samp/bin/amqsghac APPQ $CCDT_NAME &
done
