#! /bin/bash

oc apply -f job4corenonpersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest4corenonpersistent  --timeout=6000s

oc apply -f job4corepersistence.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest4corepersistent  --timeout=6000s

export ROOTURL="$(oc get IngressController default -n openshift-ingress-operator -o jsonpath='{.status.domain}')"
export IPADDRESS="$(getent hosts $ROOTURL | awk 'NR==1{print $1}')"
( echo "cat <<EOF" ; cat job4corenonpersistencetls.yaml ; echo EOF ) | sh > job4corenonpersistencetls_generated.yaml
( echo "cat <<EOF" ; cat job4corepersistencetls.yaml ; echo EOF ) | sh > job4corepersistencetls_generated.yaml

oc apply -f job4corenonpersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest4corenonpersistenttls --timeout=6000s

oc apply -f job4corepersistencetls_generated.yaml
sleep 10s
kubectl wait --for=condition=complete job/cphtest4corepersistenttls --timeout=6000s

echo "**********************4 Core Non Persistent******************************"
echo "**********************4 Core Non Persistent******************************" >> ../results.txt
kubectl logs job/cphtest4corenonpersistent >> ../results.txt
echo "**********************4 Core Persistent**********************************"
echo "**********************4 Core Persistent**********************************" >> ../results.txt
kubectl logs job/cphtest4corepersistent >> ../results.txt
echo "**********************4 Core Non Persistent With TLS*********************"
echo "**********************4 Core Non Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest4corenonpersistenttls >> ../results.txt
echo "**********************4 Core Persistent With TLS*********************"
echo "**********************4 Core Persistent With TLS*********************" >> ../results.txt
kubectl logs job/cphtest4corepersistenttls >> ../results.txt
