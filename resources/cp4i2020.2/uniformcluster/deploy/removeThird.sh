#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete queuemanager ucqm3 -n $TARGET_NAMESPACE
oc delete configmap uniformclusterqm3 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm3-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm3-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm3-ibm-mq-2 -n $TARGET_NAMESPACE
