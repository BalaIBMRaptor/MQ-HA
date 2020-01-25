# Deploying a Non-Persistent IBM MQ Queue Manager on the Cloud Pak for Integration
These instructions will document the process to deploy a non-persistent IBM MQ on the Cloud Pak for Integration (CP4I) 2019.4.1. 
Health warning - any configuration of MQ completed will be lost when the container is restarted. This will mean that the [Basic configuration for messaging traffic](#basic-configuration-for-messaging-traffic) section needs to be repeated. 

## Pre-requisites 
The Cloud Pak for Integration has been deployed and the access credentials are available. 

## Instructions
This section is separated into five parts:
* [Setup TLS Certificates for MQ Deployment](#setup-tls-certificates-for-mq-deployment)
* [Deploy IBM MQ within Cloud Pak for Integration](#deploy-ibm-mq-within-cloud-pak-for-integration)
* [Basic configuration for messaging traffic](#basic-configuration-for-messaging-traffic)
* [Configure access to MQ outside the cluster](#configure-access-to-mq-outside-the-cluster)
* [Testing the setup](#testing-the-setup)

### Setup TLS Certificates for MQ Deployment
When IBM MQ is deployed it exposes ports for the Web Console and messaging traffic. These should be secure using TLS. To allow this a Kubernetes secrete should be created.
1. Navigate to the OpenShift Console by selecting the menu at the top left of the screen and selecting *OpenShift Console*:   
  ![OpenShift Console](img/openshift.png)  
1. You will require to log in with the OpenShift credentials which are likely to be different from the Cloud Pak for Integration credentials. If you are unsure please as the OpenShift Administrator for this information.  
1. Select *Workloads --> Secrets*  and select the *MQ* project:    
  ![Open Routes](img/createsecrets.png)  
1. Select *Create --> Key/Value Secret*:    
  ![Open Routes](img/createkeyvalue.png)   
1. Fill in the following details:    
   * Secret Name: *mqcerts*
   * Key: *tls.key* 
   * Value: Copy the following into the text box:     
   ```
   -----BEGIN PRIVATE KEY-----
   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDOcOckWHETR0st
   Zr0VgE+iMUy55H9kMitgsDjxpVpIxo4Xww4ngOMYBu78TSf0cauoiv2e1GyhF8dz
   RZqksKlam7CBk8Qi5YacsqVy5GZu1RNNFj8EccsqRQCCvIFC6N1e8NOGfKZq8E+M
   rdPV9UTRwQ5gYD0aOtdIHc6E8ZkYGU1z3nOJ0VH1Wte3QNEJUCTrh9tOGS68fy40
   S5NqG9QT1Ed92yPax47kojueBfSYdAGogu4/elr7IxXkbw09mNLFIHQHd4q/6IJx
   aFG7pEVvZ9x97OCeZKlFdTnQpipZlt2iwbeFCpJFBDZhF3LvpnRsmioXey2FsiLr
   I1/8xP1/AgMBAAECggEACG3rwjwqQdNDapMrXVlj5weEToLaAMlbpBMOAC/0Q8x3
   uNiqF0rX+v8tevfbjcumardiK74YwWsrJbXN3rOn9p8s0d2qwJIGsRdKUiqpVBU3
   OIqUACZ1WUCACNaRoJ3JjDrhKDimwu8VEHV4lN/y822inKTRWeTVLYiqChujWKx9
   CoQOjxZddQqWLMlKgtTP8e1I262cTmXsW8aId8t5iYFfpW68zKO6jJdUZKivq62G
   sxjbqy+95J+jo0Kye2o3t3cEzjIPI8/XaFieNQEMFmEeeW5R4MbguMnZhq0UWPsK
   Vtq4RJv9m6h/QXij0eBco5Fzv0PyDvmPY+ee0OZeAQKBgQDpPRopjzLb8EFu3ru6
   KrsPMc5/mG8KZfcCFz7cHtPu2DC6qO+iExdVNqghzdkK+NdjQFPcfvTPexB9hlYA
   7Cm8MPFLR5HMv+E/pRBnT75KdwaOccOmblSFHMKJ8IUvewwZhDaAaEZSfBWtMOFw
   JkAkL7LMld/B1nOKh39bdudJQQKBgQDillOvFVEciLr3o2GRsRxH+YLBBcmFiHJ6
   x3CRMB4O2WY22OazleRYQwjuMOKlF6cbGEAGRJiTHlj60Q4quplDkmRSueIrpQ11
   Sp52s+jv7YzYtZqPm4S1mhoqqMbD86WeDfzzEB0ybORO1em85tje+h7qo7F9Ae+K
   eSoSP7nWvwKBgAJSBUycjBj8DuqXdK6pdir0h+VlEtW7pfVzXcC63cjmhbWVsKyg
   G/9RB+MuNRaS2zG1lh//c1gNFWDqUTi5IMEqi3wAPkcXMZp8felJNc9v17TbFOM2
   /chFPPo6VljelIQ8eH5WizyO13hdoCCJgOHbR6AZbZx0EbozFuVGDY8BAoGAP+5A
   QEcYcp+VeSeM8Oly3E/m94UlfdqoykGZXi2gXXozX8hFF2h0W/7V9zaty/zndjqa
   Xepeziui2WnAwIeTlMAqNDkkOkJAkNZz7XQHhiKVOdPLfzdW81I+jci/BCyrjvPN
   adsjEcYtiJzMbTMI/6i8rmFvQ6EXMA/NsgZu7csCgYEAi7dVc8d6cTQQJGNG/IxW
   6wWI7U7WOx93UNQDderAHMxTA1tJlwSFkMS6+Yp/g54+KSAfKMl8x5TNtq3YiPGb
   J38kUSiqWentV3xLLVbLE4Tax1nJm+FE45xUlpb2rMNdb1n8ZNvEkM2lDIT0pJ9e
   Sq/ZFW0mcHgcUdivowXrK5Q=
   -----END PRIVATE KEY-----
   ```
   * Add a second key/value pair 
   * Key: *tls.crt*
   * Value: Copy the following into the text box:     
   ```
   -----BEGIN CERTIFICATE-----
   MIIDCTCCAfGgAwIBAgIUGKbhNYYrLeWjPPUNZyFWIN2PXLQwDQYJKoZIhvcNAQEL
   BQAwFDESMBAGA1UEAwwJbG9jYWxob3N0MB4XDTIwMDEwNjEwMDcyN1oXDTMwMDEw
   MzEwMDcyN1owFDESMBAGA1UEAwwJbG9jYWxob3N0MIIBIjANBgkqhkiG9w0BAQEF
   AAOCAQ8AMIIBCgKCAQEAznDnJFhxE0dLLWa9FYBPojFMueR/ZDIrYLA48aVaSMaO
   F8MOJ4DjGAbu/E0n9HGrqIr9ntRsoRfHc0WapLCpWpuwgZPEIuWGnLKlcuRmbtUT
   TRY/BHHLKkUAgryBQujdXvDThnymavBPjK3T1fVE0cEOYGA9GjrXSB3OhPGZGBlN
   c95zidFR9VrXt0DRCVAk64fbThkuvH8uNEuTahvUE9RHfdsj2seO5KI7ngX0mHQB
   qILuP3pa+yMV5G8NPZjSxSB0B3eKv+iCcWhRu6RFb2fcfezgnmSpRXU50KYqWZbd
   osG3hQqSRQQ2YRdy76Z0bJoqF3sthbIi6yNf/MT9fwIDAQABo1MwUTAdBgNVHQ4E
   FgQUHBPFcArO/YRlbgKhni1IWgKFyTAwHwYDVR0jBBgwFoAUHBPFcArO/YRlbgKh
   ni1IWgKFyTAwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAZFzI
   Z/6Nk/SBf4YrGuWMK5cM4KvWcYGWAigu6uO6oWeTVgXjkFlOFgdGEXiJ1Y6/fDPB
   +Z1Q4HDLbmala5itjyXWmalE1E8tvm8F009dAO/J1RcrKUYqAJlbP56mnkuBkjdM
   c022HW97tEJdaubNQvebkh8Y+YhPedWn6fam1S5Kg0aIUQdJwAnd9BohKVI7HqEf
   hRKCbbEg3rIyRKAKvNCEyo268ouHrYw2/V0HLSEgXE7Q1qY5Jiqzcr2oA/SlYtfp
   vXdXJj078bu7xkKaqfLi7qSK7cITcZ3VrWF9fBlHy1Uu+eu5Sa7ontTv2KN7bhsT
   4g3U9Ludv/MqLNDX5g==
   -----END CERTIFICATE-----
   ```     
   ![Configure Secret](img/createkeyvalue2.png)
1. Click Save

### Deploy IBM MQ within Cloud Pak for Integration 
1. Open a web browser and navigate to the CP4I console:  
![Open console in browser](img/console.png)  
Commonly the first time you attempt to access the CP4I console a warning will appear regarding the certificate. This can be accepted as it is normally due to a self-signed certificate, or a unknow certificate authority. In a real production environment this would commonly be configured with a certificate that would be known by the browser, therefore please accept prior to demonstration to avoid confusion. 
1. Fill in the username / password and select *Log in*. The *Platform home* will be displayed:  
![Log in](img/platformhome.png)
1. This page provides an overview of the capabilities of the Cloud Pak for Integration. We will focus on IBM MQ, so select the IBM MQ icon:  
![Select MQ](img/selectmq.png)
1. You will be navigated to the IBM MQ section that highlights the capabilities. We want to deploy an IBM MQ instance so select *Create instance*:  
![Select MQ](img/homecreateinstance.png)
1. The *Create instance* tiles will be shown, select *MQ*:   
![Select MQ](img/tilecreateinstance.png)
1. The launch page for the IBM MQ deployment will be displayed. This highlights any pre-requisites that should be completed prior to deploying. As we are deploying a simple Queue Manager we can skip these, click *Next*:  
![Select Next](img/startcreatewizard.png)
1. A new tab will open for the MQ instance configuration, fill in the following fields:
    * *Helm release name*: mq-non-persistent
    * *Target namespace*: mq
    * *Target cluster*: local-cluster
    * *License*: Accept  
![Select Next](img/configurestep1.png)  
1. Expand *All parameters* and scroll down to the *Image* section. Change the *Image repository* value to: *image-registry.openshift-image-registry.svc:5000/mq/ibm-mqadvanced-server-integration*   
![MQ Image Repository](img/mqregistryname.png)  
  For further information on why this customization is required please consult [Container Image Locations](#container-image-locations)
1. Scroll down to the *Single sign-on* section. Once deployed the MQ Console will be accessed using the user credentials that you used to access the Integration Console. To assure this works the username used to login *MUST* be specified within the *Web admin users* section. In our case the user is *Admin1*. The Single sign-on process runs a kubernetes job to configure the environment, this requires a container image. In our case this needs updating to *image-registry.openshift-image-registry.svc:5000/mq/ibm-mq-oidc-registration*:  
![Select Next](img/configsso.png)    
  For further information on why this customization is required please consult [Container Image Locations](#container-image-locations)
1. In the *TLS* section, select the *Generate Certificate* and enter any hostname in the *Cluster hostname* field (this is a required field but will not be used as we are generating a new certificate):  
![Select Next](img/configurestep3.png)    
1. In the *Persistence* section, deselect the *Enable persistence* check box:  
![Select Next](img/configurestep4.png)    
1. Scroll down to the PKI section and copy in the following:     
```
- name: default
  secret:
    secretName: mqcerts
    items:
      - tls.key
      - tls.crt
```
![Select Next](img/configurepki.png)
1. Start the installation by clicking the *Install* button at the bottom right. The install will be started, and you will be presented with:  
![Select Next](img/installstarted.png)
1. Click *Home*, this will navigate you back to Cloud Pak for Integration console, select the *View instances* tab 

### Basic configuration for insecure messaging traffic
An empty IBM MQ is setup within the Cloud Pak for Integration, and therefore MQ resources need to be configured to allow application to communicate. This section will document the steps required:
1. Return to the Cloud Pak for Integration Platform home and click on *View instance*:   
   ![View Instances](img/viewinstances.png)
1. Listed will be the newly created IBM MQ instance, if it is NOT shown wait another minute and refresh the page. Click on the newly created instance.
1. This will open the IBM MQ Web Console. Commonly the first time you attempt to access the MQ console a warning will appear regarding the certificate. This can be accepted as it is normally due to a self-signed certificate, or a unknow certificate authority. In a real production environment this would commonly be configured with a certificate that would be known by the browser, therefore please accept prior to demonstration to avoid confusion. The default IBM MQ Web Console will be displayed:   
   ![View MQ Console](img/defaultwebconsole.png)
1. The first step is to add widgets to administration of the following objects:
    * Queues
    * Channels
  Click on the *Add widget* button at the top level and select *Queues*:  
  ![View Queues](img/addqueues.png)
  Repeat this for *Channels* so you see the following:  
  ![View Channels](img/addchannels.png)
1. As this will be an insecure setup of IBM MQ, security will be disabled. A seperat write-up will discuss how to provide a secure environment. Click the Queue Manager *mqnonpersistent* and select the *Properties* section:  
  ![Select Queue Manager](img/selectqm.png)
1. Select *Extended* and remove any text from *Connection authentication* field:    
  ![Remove Connection Authorization](img/removeconnauth.png)
1. IBM MQ V7 introduced the concept of Channel Authentication which is enabled by default, this will be disabled. Select *Communication* and in the *CHLAUTH record* field change the value to *Disabled*. Click *Save* to persist the changes, and *Close* to dismiss the popup:
  ![Disable channel auth](img/disablechannelauth.png)
1. MQ uses channels to provide remote access to a queue manager, when the queue manager is created system default channels are defined but users should create their own. Select the *create* button associated with the Channels widget:  
  ![Create channel](img/createchannel.png)
1. Fill in the following information:
     * Channel name: *MQNONPERSISTENTSVR*
     * Channel Type: *Server-connection*  
  ![Create Channel](img/createsvrconn.png)
  Select *Create*.  
  The channel name which will be exposed by OpenShift needs to be unquie across the entire cluster. Therefore we have included the helm deployment name within the channel.
1. Select the newly created channel and click *Properties*:  
  ![Create Queue](img/channelproperties.png)  
1. Select the *MCA* section and type *mqm* within the *MCA user ID* field:  
  ![Add MCA User](img/addmqm.png)  
1. Select the *SSL* section and fill in the following:
     * SSL cipher spec: *ECDHE_RSA_AES_128_CBC_SHA256*
     * SSL authentication: *Optional*  
  Click *Save* and *Close*  
  ![Add MCA User](img/channelssl.png)  
1. A queue will be created that allows a sample application to PUT and GET a test message. Within the Queue widget click on *Create*:   
  ![Create Queue](img/createqueue.png)  
1. Enter *In* as the Queue name and click *Create*:   
  ![Create Queue](img/createinqueue.png)  
1. Finally MQ Security will be refreshed, click the Queue Manager *mqnonpersistent* and select the *... --> Refresh security...*:  
  ![Refresh Security](img/refreshsecurity.png)  
1. Select *Connection authetication*:  
  ![Refresh Security](img/connauthrefresh.png)
  
### Configure access to MQ outside the cluster
By default OpenShift does NOT expose any deployed containers outside of the cluster. To enable this [OpenShift Routes](https://docs.openshift.com/container-platform/4.2/networking/routes/secured-routes.html) need to be configured. OpenShift provides a GUI, API and command line interface to configure, to minimize the pre-requisites we have demonstrated using the GUI. 
1. Navigate to the OpenShift Console by selecting the menu at the top left of the screen and selecting *OpenShift Console*:   
  ![OpenShift Console](img/openshift.png)  
1. You will require to log in with the OpenShift credentials which are likely to be different from the Cloud Pak for Integration credentials. If you are unsure please as the OpenShift Administrator for this information.  
1. Select *Networking --> Routes**:    
  ![Open Routes](img/routes.png)   
1. Select *Create Route*:  
  ![Create Routes](img/createroute.png)  
1. To avoid any typos we have included the Route YAML below so it can be copied into. Click on *Edit YAML*, and paste in the below:
  ```
  apiVersion: route.openshift.io/v1
  kind: Route
  metadata:
    name: mq-traffic-nonpersistent-ibm-mq-qm 
    namespace: mq
  spec:
    host: mqnonpersistentsvr.chl.mq.ibm.com
    to:
      kind: Service
      name: mq-non-persistent-ibm-mq
    port:
      targetPort: 1414
    tls:
      termination: passthrough
  ```   
  Click *Create*:   
  ![Paste YAML](img/createrouteyaml.png)
  The above assumes that the channel name created is MQNONPERSISTENTSVR, if this is not the case please consult [SNI mapping rules](https://www.ibm.com/support/pages/ibm-websphere-mq-how-does-mq-provide-multiple-certificates-certlabl-capability) for further information. The entire process is also documented [here](https://www.ibm.com/support/knowledgecenter/SSFKSJ_9.1.0/com.ibm.mq.mcpak.doc/cc_conn_qm_openshift.htm).

### Testing the setup
To demonstrate access to MQ a number of tools can be used such as RFHUtil, MQ Explore, JMS Application or the MQ samples. As a demonstration the following uses the MQ samples:

Pre-requisites 
* Install MQ with the samples

1. We will use the High Availability MQ sample programs:
   * amqsphac: puts a message every 2 seconds to a queue
   * amqsghac: continuously gets messages from a queue
   These are described in more detail [here](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.1.0/com.ibm.mq.dev.doc/q024200_.htm).    
1. IBM MQ uses a client channel definition table (CCDT) to configure the connection information. This is a JSON format and to accelerate the user a sample has been included below. This is also available [here](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/resources/ccdt/nonpersistent.json). The only customization required is to change the <OPENSHIFT ENDPOINT> to your hostname:  
```
{
  "channel":
  [
    {
      "general":
      {
        "description": "MQ Non Persistent channel details"
      },
      "name": "MQNONPERSISTENTSVR",
      "clientConnection":
      {
        "connection":
        [
          {
            "host": "<OPENSHIFT ENDPOINT>",
            "port": 443
          }
        ],
        "queueManager": "mqnonpersistent"
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

  Create this file on your system and complete the customization required.
1. The MQ samples are configured to use the CCDT by specifying the MQCCDTURL environment. Depending on your platform and the location of the file you will need to customize but on our windows setup this was:
```
SET MQCCDTURL=file:///C:/temp/ccdtnonpresistent.json
```
1. The sample application also needs access to the TLS certificate that the MQ server will present. If you have used our default certificates specified in this document then you can simply download the [key files from here](https://github.ibm.com/CALLUMJ/MQonCP4I/tree/master/resources/tls).
1. Similar to the CCDT file the TLS certificates are configured using an environment variable:   
```
  SET MQSSLKEYR=C:\temp\ContainerLabs\NonPersistent\key
```
1. Start the sample PUT application by running:   
```
  amqsphac In mqnonpersistent
```
  This should output the following:
```
C:\Users\CallumJackson>amqsphac In mqnonpersistent
Sample AMQSPHAC start
target queue is In
message <Message 1>
message <Message 2>
message <Message 3>
message <Message 4>
message <Message 5>
message <Message 6>
message <Message 7>
message <Message 8>
message <Message 9>
```
  This show the sample application has successfully connected to Queue Manager and PUT messages.
1. To verify the messages can be retrieved run the following:    
```
  amqsghac In mqnonpersistent
```
  This should output the following:
```
C:\Users\CallumJackson>amqsghac In mqnonpersistent
Sample AMQSGHAC start
message <Message 1>
message <Message 2>
message <Message 3>
message <Message 4>
message <Message 5>
message <Message 6>
message <Message 7>
message <Message 8>
message <Message 9>
```

## Container Image Locations
With the Cloud Pak for Integration there are two method for obtaining the MQ certified container. Using the entitled registry, or using the installed certified containers at installation time. The instructions above use the installed certified containers at installation time to avoid the need to setup and configure the entitled registry. For details on the IBMers process for the entitled registry consult the [following](https://github.ibm.com/UnifiedKubeMarketplace/KubeMarketplace/issues/45).
