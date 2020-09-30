#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager smallmq -n $TARGET_NAMESPACE
oc delete secret smallqmgrcert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-smallqmgr-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap mqsmallmqsc -n $TARGET_NAMESPACE

