#! /bin/bash

export TARGET_NAMESPACE=mqquickstart
export QM_KEY=$(cat ../createcerts/server.key | base64 | tr -d '\n')
export QM_CERT=$(cat ../createcerts/server.crt | base64 | tr -d '\n')
export APP_CERT=$(cat ../createcerts/application.crt | base64 | tr -d '\n')

( echo "cat <<EOF" ; cat mtlsqm.yaml_template ; echo EOF ) | sh > mtlsqm.yaml

oc apply -f mtlsqm.yaml
