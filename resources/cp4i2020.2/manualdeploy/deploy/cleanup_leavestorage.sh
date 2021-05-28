#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager custom-cp4i -n $TARGET_NAMESPACE
oc delete configmap mymqsc -n $TARGET_NAMESPACE
oc delete secret mycert -n $TARGET_NAMESPACE
