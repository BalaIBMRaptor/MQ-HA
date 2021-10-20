#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager mqperf1core -n $TARGET_NAMESPACE
oc delete secret mqperfcert -n $TARGET_NAMESPACE
oc delete configmap mqperfmqsc -n $TARGET_NAMESPACE
oc delete pvc data-mqperf1core-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-mqperf1core-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-mqperf1core-ibm-mq-2 -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-externalqmgr-ibm-mq-qm -n $TARGET_NAMESPACE
