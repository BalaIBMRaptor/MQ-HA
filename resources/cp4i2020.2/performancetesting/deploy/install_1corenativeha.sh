#! /bin/bash

export TARGET_NAMESPACE=cp4i

oc adm policy add-scc-to-user anyuid -z default

( echo "cat <<EOF" ; cat perfqmgr1corenativeha.yaml_template ; echo EOF ) | sh > perfqmgr1corenativeha.yaml

oc apply -f perfqmgr1corenativeha.yaml
oc project $TARGET_NAMESPACE

while true; do
  phase=`oc get qmgr mqperf1core -o jsonpath="{.status.phase}"`
  if [ $phase == Running ] ; then break; fi
  echo "Waiting for qmgr...$i"
  oc get qmgr mqperf1core
  sleep 4
done
