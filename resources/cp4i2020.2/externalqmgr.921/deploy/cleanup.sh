#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager externalmqwithoutcustomroute -n $TARGET_NAMESPACE
oc delete secret externalmqwithoutcustomroutecert -n $TARGET_NAMESPACE
oc delete configmap externalmqwithoutcustomroutemqsc -n $TARGET_NAMESPACE
