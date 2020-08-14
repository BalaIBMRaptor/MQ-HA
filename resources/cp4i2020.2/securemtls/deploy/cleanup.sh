#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager mtlsqm -n $TARGET_NAMESPACE
oc delete secret mqcert -n $TARGET_NAMESPACE
oc delete route mq-mtls-traffic-operator-test -n $TARGET_NAMESPACE
oc delete configmap mtlsmqsc -n $TARGET_NAMESPACE

