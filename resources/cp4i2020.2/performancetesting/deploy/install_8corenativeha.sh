#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc adm policy add-scc-to-user anyuid -z default

( echo "cat <<EOF" ; cat perfqmgr8corenativeha.yaml_template ; echo EOF ) | sh > perfqmgr8corenativeha.yaml

oc apply -f perfqmgr8corenativeha.yaml
oc project $TARGET_NAMESPACE

while true; do
  phase=`oc get qmgr mqperf8core -o jsonpath="{.status.phase}"`
  if [ $phase == Running ] ; then break; fi
  echo "Waiting for qmgr...$i"
  oc get qmgr mqperf8core
  sleep 4
done
