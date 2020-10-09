#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat externalqmgr.yaml_template ; echo EOF ) | sh > externalqmgr.yaml

oc apply -f externalqmgr.yaml
