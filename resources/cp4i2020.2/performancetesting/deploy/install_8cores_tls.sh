#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat perfqmgr8coretlspersistent.yaml_template ; echo EOF ) | sh > perfqmgr8coretlspersistent.yaml

oc apply -f perfqmgr8coretlspersistent.yaml
