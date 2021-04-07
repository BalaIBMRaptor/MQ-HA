#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat addThirdQM.yaml_template ; echo EOF ) | sh > addThirdQM.yaml

oc apply -f addThirdQM.yaml
