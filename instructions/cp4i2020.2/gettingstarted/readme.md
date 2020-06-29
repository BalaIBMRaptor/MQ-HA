# Getting Started with MQ on Cloud Pak for Integration 2020.2

These instructions document how to setup MQ within Cloud Pak for Integration which is accessible from within the OpenShift Cluster. 
The instructions have been created using a fresh OpenShift environment deployed on AWS however the process should be similar on other environments.

# Pre-requisites
You have installed the OpenShift command line utility *oc*. If you have not, following these [instructions](https://docs.openshift.com/container-platform/4.4/cli_reference/openshift_cli/getting-started-cli.html).

# Installing the IBM Common Services and IBM Operator Catalog
The Cloud Pak for Integration uses IBM Common Services for capabilities such as single sign on and metering. 
Therefore these need to be added to the Operator catalog. 
1. Log into the OpenShift environment and click the plus icon, in the top right:    
   ![Add to OpenShift](img/plusopenshift.png)     
1. Copy the following into the YAML editor and click *Create*:   
    ```
    apiVersion: operators.coreos.com/v1alpha1
    kind: CatalogSource
    metadata:
      name: opencloud-operators
      namespace: openshift-marketplace
    spec:
      displayName: IBMCS Operators
      publisher: IBM
      sourceType: grpc
      image: docker.io/ibmcom/ibm-common-service-catalog:latest
      updateStrategy:
        registryPoll:
          interval: 45m
    ```
    ![Add to OpenShift](img/ibmcatalogimport2.png)      

The Cloud Pak for Integration is deployed using operators and to make these available within your environment you need to install the catalog. 
1. Click the plus icon, in the top right:    
   ![Add to OpenShift](img/plusopenshift.png)     
1. Copy the following into the YAML editor and click *Create*:     
   ```
   apiVersion: operators.coreos.com/v1alpha1
   kind: CatalogSource
   metadata:
     name: ibm-operator-catalog
     namespace: openshift-marketplace
   spec:
     displayName: ibm-operator-catalog 
     publisher: IBM Content
     sourceType: grpc
     image: docker.io/ibmcom/ibm-operator-catalog
     updateStrategy:
       registryPoll:
         interval: 45m
   ```     
   ![Add to OpenShift](img/ibmcatalogimport.png)


# Installing the Cloud Pak for Integration 
I've decided to install the entire Cloud Pak for Integration instead of focusing on a cut-down version for IBM MQ.
Different approaches exist, but this appears the most likely. I've decided to install in a particular namespace to provide isolation.

1. Within the OpenShift Web Console select Home --> Projects, and click on *Create Project*:      
   ![Select CP4I](img/createproject.png)     
1. Fill in *cp4i* as the project name, and click *Create*:       
   ![Select CP4I](img/createcp4iproject.png)
1. Navigate to Operators --> Operator Hub, search for *Cloud Pak* and select IBM Cloud Pak for Integration:      
   ![Select CP4I](img/installcp4i.png)      
1. Click *Install*
1. Select the *A specific namespace on the cluster* and change the namespace to *cp4i*:      
   ![Select CP4I](img/installcp4ioperator.png)    
1. The installation of the operator will take several minutes and while this is occuring the status may appear to be stuck in *UpgradePending*:      
   ![Select CP4I](img/upgradepending.png)    


