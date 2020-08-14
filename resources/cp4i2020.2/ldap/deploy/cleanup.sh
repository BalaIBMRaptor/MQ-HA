#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager ldapmq -n $TARGET_NAMESPACE
oc delete secret mqldapcert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-ldap-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap mqldapmqsc -n $TARGET_NAMESPACE

