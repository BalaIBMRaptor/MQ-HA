#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat traceqmgr.yaml_template ; echo EOF ) | sh > traceqmgr.yaml

oc apply -f traceqmgr.yaml
