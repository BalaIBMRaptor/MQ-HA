#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager mqperf -n $TARGET_NAMESPACE
oc delete secret mqperfcert -n $TARGET_NAMESPACE
oc delete configmap mqperfmqsc -n $TARGET_NAMESPACE
oc delete pvc data-mqperf-ibm-mq-0 -n $TARGET_NAMESPACE
