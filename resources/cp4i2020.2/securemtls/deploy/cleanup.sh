#! /bin/bash

export TARGET_NAMESPACE=mqquickstart

oc delete queuemanager mtlsqm -n $TARGET_NAMESPACE
oc delete secret mqcert -n $TARGET_NAMESPACE
oc delete route mq-mtls-traffic-operator-test -n $TARGET_NAMESPACE
oc delete pvc data-mtlsqm-ibm-mq-0 -n $TARGET_NAMESPACE

