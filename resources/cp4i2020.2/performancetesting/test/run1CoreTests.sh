#! /bin/bash

oc apply -f job1corenonpersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corenonpersistent  --timeout=3000s

oc apply -f job1corepersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corepersistent  --timeout=3000s

export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
export IPADDRESS="$(getent hosts $ROOTURL | awk '{ print $1 }')"
( echo "cat <<EOF" ; cat job1corenonpersistencetls.yaml ; echo EOF ) | sh > job1corenonpersistencetls_generated.yaml
( echo "cat <<EOF" ; cat job1corepersistencetls.yaml ; echo EOF ) | sh > job1corepersistencetls_generated.yaml

oc apply -f job1corenonpersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corenonpersistenttls --timeout=3000s

oc apply -f job1corepersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corepersistenttls --timeout=3000s


echo "**********************1 Core Non Persistent******************************"
kubectl logs job/cphtest1corenonpersistent >> ../results.txt
echo "**********************1 Core Persistent**********************************"
kubectl logs job/cphtest1corepersistent >> ../results.txt
echo "**********************1 Core Non Persistent With TLS*********************"
kubectl logs job/cphtest1corenonpersistenttls >> ../results.txt
echo "**********************1 Core Persistent With TLS*********************"
kubectl logs job/cphtest1corepersistenttls >> ../results.txt
