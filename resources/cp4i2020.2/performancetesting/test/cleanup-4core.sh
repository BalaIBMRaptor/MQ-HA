#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete job cphtest4corenonpersistent -n $TARGET_NAMESPACE
oc delete job cphtest4corenonpersistenttls -n $TARGET_NAMESPACE
oc delete job cphtest4corepersistent -n $TARGET_NAMESPACE
oc delete job cphtest4corepersistenttls -n $TARGET_NAMESPACE
