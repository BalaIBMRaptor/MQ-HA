#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"

( echo "cat <<EOF" ; cat uniformcluster.yaml_template ; echo EOF ) | sh > uniformcluster.yaml

oc apply -f uniformcluster.yaml
