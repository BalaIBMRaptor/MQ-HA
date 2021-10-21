#! /bin/bash

oc apply -f job1corenonpersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corenonpersistent  --timeout=6000s

oc apply -f job1corepersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corepersistent  --timeout=6000s

export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
export IPADDRESS="$(getent hosts $ROOTURL | awk 'NR==1{print $1}')"

( echo "cat <<EOF" ; cat job1corenonpersistencetls.yaml ; echo EOF ) | sh > job1corenonpersistencetls_generated.yaml
( echo "cat <<EOF" ; cat job1corepersistencetls.yaml ; echo EOF ) | sh > job1corepersistencetls_generated.yaml

oc apply -f job1corenonpersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corenonpersistenttls --timeout=6000s

oc apply -f job1corepersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest1corepersistenttls --timeout=6000s


echo "**********************1 Core Non Persistent******************************"
echo "**********************1 Core Non Persistent******************************" >> ../results.txt
kubectl logs job/cphtest1corenonpersistent >> ../results.txt
echo "**********************1 Core Persistent**********************************"
echo "**********************1 Core Persistent**********************************" >> ../results.txt
kubectl logs job/cphtest1corepersistent >> ../results.txt
echo "**********************1 Core Non Persistent With TLS*********************"
echo "**********************1 Core Non Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest1corenonpersistenttls >> ../results.txt
echo "**********************1 Core Persistent With TLS*********************"
echo "**********************1 Core Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest1corepersistenttls >> ../results.txt
