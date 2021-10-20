#! /bin/bash

oc apply -f job2corenonpersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest2corenonpersistent  --timeout=3000s

oc apply -f job2corepersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest2corepersistent  --timeout=3000s

export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
export IPADDRESS="$(getent hosts $ROOTURL | awk '{ print $1 }')"
( echo "cat <<EOF" ; cat job2corenonpersistencetls.yaml ; echo EOF ) | sh > job2corenonpersistencetls_generated.yaml
( echo "cat <<EOF" ; cat job2corepersistencetls.yaml ; echo EOF ) | sh > job2corepersistencetls_generated.yaml

oc apply -f job2corenonpersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest2corenonpersistenttls --timeout=3000s

oc apply -f job2corepersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest2corepersistenttls --timeout=3000s


echo "**********************2 Core Non Persistent******************************"
kubectl logs job/cphtest2corenonpersistent >> ../results.txt
echo "**********************2 Core Persistent**********************************"
kubectl logs job/cphtest2corepersistent >> ../results.txt
echo "**********************2 Core Non Persistent With TLS*********************"
kubectl logs job/cphtest2corenonpersistenttls >> ../results.txt
echo "**********************2 Core Persistent With TLS*********************"
kubectl logs job/cphtest2corepersistenttls >> ../results.txt
