#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat mqldap.yaml_template ; echo EOF ) | sh > mqldap.yaml

oc apply -f mqldap.yaml
