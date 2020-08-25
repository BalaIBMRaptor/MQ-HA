# Securing IBM MQ using mutual TLS
IBM MQ can be secured in a number of ways, two common approaches include:
* Username / Password
* Mutual TLS

This lab will demonstrate how you can use mutual TLS for authentication and authorization. 
The lab is dependant on a number of resources included within this GitHub repository. 

## Pre-reqs
To run the following you need to have installed:
* The MQ client or server as it uses GSKit and shipped MQ utilities
* OpenSSL to generate the raw certificates and keys
* The IBM Common Services, IBM Operator Catalog and Cloud Pak for Integration. [Instructions on how to install them.](https://github.ibm.com/CALLUMJ/MQonCP4I/tree/master/instructions/cp4i2020.2/gettingstarted)

## Step 1 - Download this github repository
- Option 1: clone this repository using `git`:
   ```sh
   git clone git@github.ibm.com:CALLUMJ/MQonCP4I.git
   ```
   **Warning** you need to setup ssh access to github.ibm.com prior to running this command, see https://github.ibm.com/settings/tokens or https://github.ibm.com/settings/ssh for details. 
- Option 2: Download the repository as a .zip file and navigate to it on your terminal.

## Step 2 - Optionally re-generate the TLS Certificates and Keys
1. Once you have cloned/downloaded the github repository, navigate to the *MQonCP4I/resources/cp4i2020.2/securemtls/createcerts* directory.

1. Run the command **rm appl\* serv\*** to delete all the existing default TLS certificates and keys.

1. Then run the command **./generate-test-cert.sh** to generate new unique TLS certificates and keys.
   ![Generating new keys](img/1.png)

## Step 3 - Deploy the MQ Queue Manager with associated resources
1. Log into the OpenShift environment, and then click on your username on the top right menu. Then click on **Copy Login Command**. Click on **Display Token**, copy the token and run on your terminal.
   ![Top right menu in the Openshit environment](img/2.png)

1. Run the command: **oc project cp4i** to navigate to the cp4i project.

1. To start deploying, navigate to *../deploy* directory and run **./install.sh** command. Three new files will be created including *mtlsqm.yaml* - this file includes all of the configuration which you have just installed to your OpenShift environment.
   ![Deployment](img/3.png)

1. To check the status of your queue manager, you can run the **oc describe queuemanager mtlsqm**. It should show *Running*. 
   ![Checking that MQ is Running](img/4.png)

## Step 4 - Test the deployment
Navigate to *../test* directory. You will find three files: CCDT.JSON, getMessage.sh, and sendMessage.sh. Open them in any text editor.

1. In the CCDT.JSON file, you need to update the host next to *host:* with your own host name. To get your host name, run the **oc get routes | grep mtlsqm** command on your terminal. Your host name should start with *mtlsqm-ibm-mq-qm*:
   ![Choosing the right host name](img/5.png)

1. In the getMessage.sh and sendMessage.sh files, you need to replace the first three parts of the paths in the two export commands in each file. To get the new path, run the **pwd** command on your terminal and copy the first three parts of the path. It should look something similar to: *home/name/2020.2*.
   ![Selecting the first three parts of the path](img/6.png)

1. To initiate the testing, run the **./sendMessage.sh** command. It will then connect to MQ and ask you for a message to send. Then run the **./getMessage.sh** and it should show you the message that you just sent.
   ![Cleaning up](img/7.png)

1. You can clean up after this process by navigating to the *../deploy* directory and running the command **./cleanup.sh**. This will delete everything.
   ![Cleaning up](img/8.png)
