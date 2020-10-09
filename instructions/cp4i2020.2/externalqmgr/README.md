# Connect an External IBM MQ Queue Manager on the Cloud Pak for Integration
These instructions will document the process to deploy an external MQ queue manager on the Cloud Pak for Integration (CP4I) 2020.2.1.

## Pre-reqs
To run the following you need to have installed:
* The MQ client or server as it uses GSKit and shipped MQ utilities
* The IBM Common Services, IBM Operator Catalog and Cloud Pak for Integration. [Instructions on how to install them.](https://github.ibm.com/CALLUMJ/MQonCP4I/tree/master/instructions/cp4i2020.2/gettingstarted)

## Step 1 - Download this GitHub repository
- Option 1: clone this repository using `git`:
   ```sh
   git clone git@github.ibm.com:CALLUMJ/MQonCP4I.git
   ```
   **Warning:** You need to setup ssh access to github.ibm.com prior to running this command, see https://github.ibm.com/settings/tokens or https://github.ibm.com/settings/ssh for details. 
- Option 2: Download the repository as a .zip file and navigate to it on your terminal.

## Step 2 - Deploy the MQ Queue Manager with associated resources
1. Once you have cloned/downloaded the GitHub repository, navigate to the *MQonCP4I/resources/cp4i2020.2/externalqmgr* directory.

1. Log into the OpenShift environment, and then click on your username on the top right menu. Then click on **Copy Login Command**. Click on **Display Token**, copy the token and run on your terminal.
OpenShift environment. 
   <img src="img/1.png" width="400" alt="Top right menu in the Openshit environment">

1. Run the command: **oc project cp4i** to navigate to the cp4i project.

1. To start deploying, navigate to *../deploy* directory and run **./install.sh** command. Four new files will be created. 
   <img src="img/2.png" width="600" alt="Deployment">
   
1. To view your running pod, run the **oc get pod | grep external** command. It might need up to a minute for the pod to start.     
   <img src="img/3.png" width="600" alt="Running pods">

## Step 3 - Test the deployment
Navigate to *../test* directory. You will find three files: CCDT.JSON, getMessage.sh, and sendMessage.sh. Open them in any text editor.

1. In the CCDT.JSON file, you need to update the host next to *host:* with your host name. To get your host name, run the **oc get route | grep external** command on your terminal. Your host name should start with *externalmq-ibm-mq-qm*:   
   <img src="img/4.png" width="550" alt="Choosing the right host name">

1. In the getMessage.sh and sendMessage.sh files, you need to replace the first three parts of the paths in the two export commands in each file. To get the new path, run the **pwd** command on your terminal and copy the first three parts of the path. It should look something similar to: *home/name/2020.2*.    
   <img src="img/4-2.png" width="400" alt="Replacing the first three parts of the path">
   
1. To initiate the testing, run the **./sendMessage.sh** command. It will then connect to MQ and start sending messages incessantly.   
   <img src="img/5.png" width="600" alt="Sending messages">

1. Open another command window and run the **./getMessage.sh** command. You should get a list of the all messages that have been previously sent before running the command and the ones that are being sent after.  
   <img src="img/6.png" width="600" alt="Receiving messages">

1. You can clean up after this process by navigating to the *../deploy* directory and running the command **./cleanup.sh**. This will delete everything.    
   <img src="img/8.png" width="600" alt="Cleaning up">
