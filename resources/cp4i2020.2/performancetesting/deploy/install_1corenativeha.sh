#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export ENV_NAME=${2:-"ibmcloudclassic"}


if [[ $ENV_NAME = "ibmcloudclassic" ]]
then
  export STORAGE_CLASS="ibmc-block-gold"
elif [[ $ENV_NAME = "ibmcloudvpc2" ]]
then
  export STORAGE_CLASS="ibmc-vpc-block-10iops-tier"
else
  # need something else here
  echo "No env set"
fi

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
