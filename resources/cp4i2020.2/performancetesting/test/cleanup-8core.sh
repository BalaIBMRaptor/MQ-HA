#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete job cphtest8corenonpersistent -n $TARGET_NAMESPACE
oc delete job cphtest8corenonpersistenttls -n $TARGET_NAMESPACE
oc delete job cphtest8corepersistent -n $TARGET_NAMESPACE
oc delete job cphtest8corepersistenttls -n $TARGET_NAMESPACE
