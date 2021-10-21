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

( echo "cat <<EOF" ; cat perfqmgr8core.yaml_template ; echo EOF ) | sh > perfqmgr8core.yaml

oc apply -f perfqmgr8core.yaml
oc project $TARGET_NAMESPACE

while true; do
  phase=`oc get qmgr mqperf8core -o jsonpath="{.status.phase}"`
  if [ $phase == Running ] ; then break; fi
  echo "Waiting for qmgr...$i"
  oc get qmgr mqperf8core
  sleep 4
done
