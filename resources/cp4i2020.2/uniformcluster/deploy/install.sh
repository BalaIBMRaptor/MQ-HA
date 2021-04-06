#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat uniformcluster.yaml_template ; echo EOF ) | sh > uniformcluster.yaml

oc apply -f uniformcluster.yaml
