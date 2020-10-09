#! /bin/bash

export TARGET_NAMESPACE=icp4i

oc delete queuemanager multiinstancemq -n $TARGET_NAMESPACE
oc delete secret mqmultiinstancecert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-multiinstance-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap mqmultiinstancemqsc -n $TARGET_NAMESPACE
oc delete pvc data-multiinstancemq-ibm-mq-0 -n $TARGET_NAMESPACE
oc delete pvc data-multiinstancemq-ibm-mq-1 -n $TARGET_NAMESPACE
oc delete pvc multiinstancemq-ibm-mq-persisted-data -n $TARGET_NAMESPACE
oc delete pvc multiinstancemq-ibm-mq-recovery-logs -n $TARGET_NAMESPACE

