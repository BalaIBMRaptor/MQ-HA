#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete job cphtest2corenonpersistent -n $TARGET_NAMESPACE
oc delete job cphtest2corenonpersistenttls -n $TARGET_NAMESPACE
oc delete job cphtest2corepersistent -n $TARGET_NAMESPACE
oc delete job cphtest2corepersistenttls -n $TARGET_NAMESPACE
