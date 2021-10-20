#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc delete job cphtest1corenonpersistent -n $TARGET_NAMESPACE
oc delete job cphtest1corenonpersistenttls -n $TARGET_NAMESPACE
oc delete job cphtest1corepersistent -n $TARGET_NAMESPACE
oc delete job cphtest1corepersistenttls -n $TARGET_NAMESPACE
