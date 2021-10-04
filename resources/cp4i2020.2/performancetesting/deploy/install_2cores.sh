#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat perfqmgr2core.yaml_template ; echo EOF ) | sh > perfqmgr2core.yaml

oc apply -f perfqmgr2core.yaml
