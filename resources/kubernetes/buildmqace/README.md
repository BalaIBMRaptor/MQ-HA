# Building an MQ Build in OpenShift with LDAP automatically configured and config for ACE demonstration
This lab will guide you through how to create a MQ container layer into the provided CP4I MQ Certified Container. 
This layer will include configuration for LDAP and we will use the MQ samples to verify the setup.

## Pre-requisites
1. You have installed the OpenShift command line and logged into the target OpenShift environment. If you are unaware of how to do this please consult [here](https://docs.openshift.com/container-platform/4.2/cli_reference/openshift_cli/getting-started-cli.html)
1. You have already created a namespace within OpenShift called *mq* and configured for a MQ deployment
1. There is already an entitled registry secret called ibm-entitled-key
1. You have already install helm

## Instructions
These instructions will be seperated into three sections:
1. Building the MQ pipeline that generates a LDAP enabled MQ image with messaging resources for ACE
1. Deploying a MQ Queue Manager using the helm command
1. Testing the solution

### Building the MQ pipeline that generates an MQ image with messaging resources for ACE
All the configuration required can be found [here](https://github.ibm.com/CALLUMJ/MQonCP4I/tree/master/resources/kubernetes/buildldapmq) download locally.
1. To install simply download the repository.     
2. Change directory to <github download>/MQonCP4I/resources/kubernetes/buildmqace
2. Log into the OpenShift command line
2. Run ```installbuild.sh```

### Deploying a MQ Queue Manager using the Helm command
1. Download the latest MQ CP4I Helm Chart:     
   ```git clone -b ga-6.0.X git@github.ibm.com:mq-cloudpak/ibm-mqadvanced-server-integration-prod.git```
1. Change directory to      
   ``cd ibm-mqadvanced-server-integration-prod/stable``
1. Run the following command:     
   ```helm install repair ibm-mqadvanced-server-integration-prod --namespace mq --set license=accept --set pki.keys[0].name=default,pki.keys[0].secret.secretName=mqcert,pki.keys[0].secret.items[0]=tls.key,pki.keys[0].secret.items[1]=tls.crt --set image.repository="image-registry.openshift-image-registry.svc:5000/mq/mqace" --set image.tag="latest" --set log.debug=false --set tls.generate=false --set tls.hostname=somewhere --set selectedCluster.label=local-cluster --set selectedCluster.value=local-cluster --set selectedCluster.ip="" --set selectedCluster.namespace=local-cluster --set odTracingConfig.enabled=false```

### Testing the solution
To verify the setup for ACE I've used the MQ sample to verify the deployment, 
these instructions assume you have the MQ samples installed:
1. Open a command prompt and set the following (for Windows):      
   ```
   SET MQCCDTURL=file:///C:/temp/ccdtACE.json
   SET MQSSLKEYR=C:\temp\key
   ```
1. Change directories to c:\temp and create a new file called ccdtACE.json:         
   ```
   cd c:\temp
   notepad ccdtACE.json
   ```
1. Copy the following into the new file and customize the hostname:       
   ```
   {
     "channel":
     [
       {
         "general":
         {
           "description": "MQ ACE channel details"
         },
         "name": "ACE_SVRCONN",
         "clientConnection":
         {
           "connection":
           [
             {
               "host": "repair-ibm-mq-web-mq.dan-agile-demo-1-ec111ed5d7db435e1c5eeeb4400d693f-0000.eu-gb.containers.appdomain.cloud",
               "port": 443
             }
           ],
           "queueManager": "repair"
         },
         "transmissionSecurity":
         {
           "cipherSpecification": "ECDHE_RSA_AES_128_CBC_SHA256"
         },
   	  "type": "clientConnection"
       }
     ]
   }
   ```
1. Download the key* files from [here](https://github.ibm.com/CALLUMJ/MQonCP4I/tree/master/resources/tls) and save to c:\temp
1. Start the sample PUT application by running:     
   ```
   amqsputc AccidentIn repair
   ```
   This should output the following:    
   ```
   C:\temp>amqsputc AccidentIn repair
   Sample AMQSPUT0 start
   target queue is Q1
   Hello World

   Sample AMQSPUT0 end
   ```
   If you would like to verify that the message was successfully sent then run the following:      
   ```
   C:\temp>amqsgetc AccidentIn repair
   Sample AMQSGET0 start
   message <Hello World>
   no more messages
   Sample AMQSGET0 end
   ```
 
