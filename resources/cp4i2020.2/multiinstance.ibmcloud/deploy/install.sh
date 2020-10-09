#! /bin/bash

export TARGET_NAMESPACE=icp4i

( echo "cat <<EOF" ; cat mqmultiinstance.yaml_template ; echo EOF ) | sh > mqmultiinstance.yaml

oc apply -f mqmultiinstance.yaml
