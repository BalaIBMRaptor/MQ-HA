#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat perfqmgr4coretls.yaml_template ; echo EOF ) | sh > perfqmgr4coretls.yaml

oc apply -f perfqmgr4coretls.yaml
