#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat gettingstartedqmgr.yaml_template ; echo EOF ) | sh > gettingstartedqmgr.yaml

oc apply -f gettingstartedqmgr.yaml
