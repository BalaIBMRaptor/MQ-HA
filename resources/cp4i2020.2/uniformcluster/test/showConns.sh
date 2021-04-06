#!/bin/bash

clear
green='\033[0;32m'
lgreen='\033[1;32m'
nc='\033[0m'

export MQCCDTURL='/home/callum/git/MQonCP4I/resources/cp4i2020.2/uniformcluster/test/ccdt.json'
export MQSSLKEYR='/home/callum/git/MQonCP4I/resources/cp4i2020.2/uniformcluster/test/key'

APPNAME=${2:-amqsghac}
DELAY=${3:-1s}

for (( i=0; i<100000; ++i)); do
  CONNCOUNT=`echo "dis conn(*) where(appltag eq '$APPNAME')" | /opt/mqm/bin/runmqsc -c $1 | grep "  CONN" | wc -w`
  BALANCED=`echo "dis apstatus('$APPNAME')" | /opt/mqm/bin/runmqsc $1 | grep "  BALANCED"`
  clear
  echo -e "${green}$1${nc} / ${green}$APPNAME${nc} -- ${lgreen}$CONNCOUNT${nc}"
  echo "dis conn(*) where(appltag eq '$APPNAME')" | /opt/mqm/bin/runmqsc $1 | grep "  CONN"
  sleep $DELAY
done
