#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}
# Possible altnative for ENV_NAME:
#    ibmcloudvpc2
#    ibmcloudclassic

./run-1core.sh $TARGET_NAMESPACE $ENV_NAME 
./run-2core.sh $TARGET_NAMESPACE $ENV_NAME
./run-4core.sh $TARGET_NAMESPACE $ENV_NAME
./run-8core.sh $TARGET_NAMESPACE $ENV_NAME
