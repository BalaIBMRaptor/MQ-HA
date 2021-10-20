#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager mqperf8core -n $TARGET_NAMESPACE
oc delete secret mqperfcert -n $TARGET_NAMESPACE
oc delete configmap mqperf8mqsc -n $TARGET_NAMESPACE
oc delete pvc data-mqperf8core-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-mqperf8core-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc data-mqperf8core-ibm-mq-2 -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-externalqmgr-ibm-mq-qm -n $TARGET_NAMESPACE
