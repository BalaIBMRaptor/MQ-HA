#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}

oc delete queuemanager ucqm1 -n $TARGET_NAMESPACE
oc delete queuemanager ucqm2 -n $TARGET_NAMESPACE
oc delete secret uniformclustercert -n $TARGET_NAMESPACE
oc delete configmap uniformcluster -n $TARGET_NAMESPACE
oc delete configmap uniformclusterqm1 -n $TARGET_NAMESPACE
oc delete configmap uniformclusterqm2 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm1-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm1-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm1-ibm-mq-2 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm2-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm2-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-ucqm2-ibm-mq-2 -n $TARGET_NAMESPACE
