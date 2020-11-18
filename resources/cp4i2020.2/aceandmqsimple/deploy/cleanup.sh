#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete queuemanager acemqsimple -n $TARGET_NAMESPACE
oc delete secret mqacemqsimplecert -n $TARGET_NAMESPACE
oc delete route mq-traffic-mq-acemqsimple-ibm-mq-qm -n $TARGET_NAMESPACE
oc delete configmap acemqsimplemqsc -n $TARGET_NAMESPACE

