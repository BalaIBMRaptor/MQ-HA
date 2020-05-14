# Building an IBM MQ Uniform Cluster using IBM MQ Advanced 

This lab will demonstrate how you can deploy two IBM MQ instances and have connections balanced across the two. 
This currently requires a custom helm chart and the code has been uploaded to avoid typos.

## Pre-requisites
These instructions assume you have already installed:
* helm 
* kubectl
* oc (OpenShift command line tool)

## Downloading the helm charts
The IBM MQ Advanced helm charts are available [here](https://github.com/IBM/charts/blob/master/repo/entitled) and these instructions were created using [v5.0.0](https://github.com/IBM/charts/blob/master/repo/entitled/ibm-mqadvanced-server-integration-prod-5.0.0.tgz).     
For instance in my environment I completed the following commands:
```
wget https://github.com/IBM/charts/raw/master/repo/entitled/ibm-mqadvanced-server-prod-5.0.0.tgz
tar -zxvf ibm-mqadvanced-server-prod-5.0.0.tgz
```       
This will unpack the shipped 9.1.4 IBM MQ Advanced Helm chart into a directory called *ibm-mqadvanced-server-integration-prod*   

## Instructions
These instructions are separated into 4 parts:
* Updating the helm chart
* Deploying the environment
* Providing external access
* Verifying the uniform cluster works

### Updating the helm chart
There are four files that require updating, the updated version of these files have been included to avoid typo and a explanation of the changes included below:

#### [service.yaml](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/resources/uniformCluster/service.yaml)
*Replacement Location:* ibm-mqadvanced-server-prod/templates/service.yaml

#### [stateful-set.yaml](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/resources/uniformCluster/stateful-set.yaml)
*Replacement Location:* ibm-mqadvanced-server-prod/templates/stateful-set.yaml

#### [values-metadata.yaml](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/resources/uniformCluster/values-metadata.yaml)
*Replacement Location:* ibm-mqadvanced-server-prod/values-metadata.yaml

#### [values.yaml](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/resources/uniformCluster/values.yaml)
*Replacement Location:* ibm-mqadvanced-server-prod/values.yaml


### Deploying the environment


### Providing external access


### Verifying the uniform cluster works



