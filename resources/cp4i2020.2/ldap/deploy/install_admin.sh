#! /bin/bash

export TARGET_NAMESPACE=cp4i

( echo "cat <<EOF" ; cat mqldapadmin.yaml_template ; echo EOF ) | sh > mqldap.yaml

oc apply -f mqldap.yaml
