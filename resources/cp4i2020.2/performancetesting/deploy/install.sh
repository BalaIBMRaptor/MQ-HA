#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat perfqmgr.yaml_template ; echo EOF ) | sh > perfqmgr.yaml

oc apply -f perfqmgr.yaml
