#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat nativeha.yaml_template ; echo EOF ) | sh > nativeha.yaml

oc apply -f nativeha.yaml
