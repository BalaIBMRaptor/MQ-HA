#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat smallnoweb.yaml_template ; echo EOF ) | sh > smallqmgr.yaml

oc apply -f smallqmgr.yaml
