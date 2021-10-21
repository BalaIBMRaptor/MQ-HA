#! /bin/bash

oc apply -f job8corenonpersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest8corenonpersistent  --timeout=6000s

oc apply -f job8corepersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest8corepersistent  --timeout=6000s

export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
export IPADDRESS="$(getent hosts $ROOTURL | awk 'NR==1{print $1}')"
( echo "cat <<EOF" ; cat job8corenonpersistencetls.yaml ; echo EOF ) | sh > job8corenonpersistencetls_generated.yaml
( echo "cat <<EOF" ; cat job8corepersistencetls.yaml ; echo EOF ) | sh > job8corepersistencetls_generated.yaml

oc apply -f job8corenonpersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest8corenonpersistenttls --timeout=6000s

oc apply -f job8corepersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest8corepersistenttls --timeout=6000s

echo "**********************8 Core Non Persistent******************************"
echo "**********************8 Core Non Persistent******************************" >> ../results.txt
kubectl logs job/cphtest8corenonpersistent >> ../results.txt
echo "**********************8 Core Persistent**********************************"
echo "**********************8 Core Persistent**********************************" >> ../results.txt
kubectl logs job/cphtest8corepersistent >> ../results.txt
echo "**********************8 Core Non Persistent With TLS*********************"
echo "**********************8 Core Non Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest8corenonpersistenttls >> ../results.txt
echo "**********************8 Core Persistent With TLS*********************"
echo "**********************8 Core Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest8corepersistenttls >> ../results.txt
