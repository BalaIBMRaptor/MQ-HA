#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat perfqmgr4core.yaml_template ; echo EOF ) | sh > perfqmgr4core.yaml

oc apply -f perfqmgr4core.yaml
