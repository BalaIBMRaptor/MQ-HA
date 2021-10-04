#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager externalmq -n $TARGET_NAMESPACE
oc delete secret mqexternalqmgrcert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-externalqmgr-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap mqexternalmqsc -n $TARGET_NAMESPACE
oc delete pvc data-externalmq-ibm-mq-0 -n $TARGET_NAMESPACE
