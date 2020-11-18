#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager tracemq -n $TARGET_NAMESPACE
oc delete secret traceqmgrcert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-traceqmgr-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap tracemqsc -n $TARGET_NAMESPACE

