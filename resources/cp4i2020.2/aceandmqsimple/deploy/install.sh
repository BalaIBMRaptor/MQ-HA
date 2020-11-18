#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat acemqsimpleqmgr.yaml_template ; echo EOF ) | sh > acemqsimpleqmgr.yaml

oc apply -f acemqsimpleqmgr.yaml
