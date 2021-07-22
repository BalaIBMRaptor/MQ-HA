#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager nativeha -n $TARGET_NAMESPACE
oc delete secret nativehacert -n $TARGET_NAMESPACE
oc delete configmap nativehamqsc -n $TARGET_NAMESPACE
