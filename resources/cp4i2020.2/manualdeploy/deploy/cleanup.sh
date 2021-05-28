#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager custom-cp4i -n $TARGET_NAMESPACE
oc delete configmap mymqsc -n $TARGET_NAMESPACE
oc delete secret mycert -n $TARGET_NAMESPACE
oc delete pvc data-custom-cp4i-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-custom-cp4i-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-custom-cp4i-ibm-mq-2 -n $TARGET_NAMESPACE
