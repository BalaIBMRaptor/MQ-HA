#!/bin/bash

echo "DELETING NAMESPACE THAT REMOVES THE MAJORITY"
oc delete namespace ldap

echo "DELETE CLUSTER IMAGE POLICY"
oc delete ClusterImagePolicy openldap

echo "COMPLETED"
