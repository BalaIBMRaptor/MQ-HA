#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"

( echo "cat <<EOF" ; cat addThirdQM.yaml_template ; echo EOF ) | sh > addThirdQM.yaml

oc apply -f addThirdQM.yaml
