# Basic Administration within IBM MQ
This lab will guide you through some of the core concepts of Administrating IBM MQ, and separate into the following sections:    

* Understanding the basics of problem determination
  * Resolving an error using the Web Console and mqrc command
  * Resolving an error using the error log
* Understand Queues in IBM MQ

## Pre-requisites
You have already complete the [Starting IBM MQ within a container lab](https://github.ibm.com/CALLUMJ/MQonCP4I/blob/master/instructions/docker/ReadySetConnect.md#starting-ibm-mq-within-a-container) and [Testing the environment using the Web Console and command line](https://github.ibm.com/CALLUMJ/MQonCP4I/edit/master/instructions/docker/WebConsole101.md).

## Understanding the basics of problem determination
This section will understand highlight the basics of IBM MQ problem determination, we will deliberately cause an error to demonstrate the various capabilities that exist to resolve the problem. 

### Resolving an error using the Web Console and mqrc command
In the previous lab we created a queue called *DEV.MY.QUEUE* and set the maximum depth to be 3 messages. 
In this section we will demostrate what happens when you attempt to exceed the limit.    
1. We will complete this testing using the command line. Open a new terminal window:    
   ![Open Terminal](img/openterminal.png)       

1. We will exec into the running container but to do this we need to determine the container ID. This can be found by running:       
   ```
   docker ps
   ```

   You should see output like this:
   ```
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                                      NAMES
   9b389a6f9d69        ibmcom/mq:latest    "runmqdevserver"    2 minutes ago       Up 2 minutes        0.0.0.0:1414->1414/tcp, 0.0.0.0:9443->9443/tcp, 9157/tcp   upbeat_goldstine
   ```

1. Copy your own container id (from the previous step) and use it to get command line access inside the container, for example:     
   ```
   docker exec -ti <your container id> /bin/bash
   ```        

   You should see output like this:        

   ```
   bash-4.4$
   ```      

1. IBM MQ ships sample applications that can be used to test and verify your environment. These can be found in the following location ```/opt/mqm/samp/bin```. These are samples that can be used as provided, and the source code is provided as reference allowing users to customize based on their requirements. The source can be found in the parent directory: ```/opt/mqm/samp```. A full list of the samples can be found [here](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.1.0/com.ibm.mq.dev.doc/q023900_.htm). Within this lab we will use *amqsput*. This allows us to connect to a local queue manager and PUT messages to a queue. Lets try it out, change to the sample bin directory:     
   ```
   cd /opt/mqm/samp/bin
   ```
1. Run the command to place the first message:   
   ```
   echo "Test message 1" | ./amqsput DEV.MY.QUEUE QM1
   ```      
   This should complete with the following output:      
   ```
   Sample AMQSPUT0 start
   target queue is DEV.MY.QUEUE
   Sample AMQSPUT0 end
   ```
1. Repeat this another 3 times and on the final attempt you should see an error:      
   ```
   bash-4.4$ echo "Test message 2" | ./amqsput DEV.MY.QUEUE QM1
   Sample AMQSPUT0 start
   target queue is DEV.MY.QUEUE
   Sample AMQSPUT0 end

   bash-4.4$ echo "Test message 3" | ./amqsput DEV.MY.QUEUE QM1
   Sample AMQSPUT0 start
   target queue is DEV.MY.QUEUE
   Sample AMQSPUT0 end

   bash-4.4$ echo "Test message 4" | ./amqsput DEV.MY.QUEUE QM1
   Sample AMQSPUT0 start
   target queue is DEV.MY.QUEUE
   MQPUT ended with reason code 2053
   Sample AMQSPUT0 end
   ```
1. MQ provides an utility program called *mqrc* that converts MQ return codes into a human readable format. This can be a simple way to start the problem determination. In the above case *2053* was returned, run the following to understand what this corresponds to:     
   ```
   mqrc 2053
   ```
   This returns the following:    
   ```
   2053  0x00000805  MQRC_Q_FULL
   ```
1. In addition if you return to the web console and viewed the Queue Manager you will see the maximum depth has been reached and highlighted:     
   ![Max Depth](img/maxdepthconsole.png)       

1. Both of the above mechanisms provide a straight forward way to determine the underlying issue. 
In our case we will address this by reading the message, simulating an application coming back on line.        
   ```
   /opt/mqm/samp/bin/amqsget DEV.MY.QUEUE QM1
   ```
   You should see the following output:      
   ```
   bash-4.4$ /opt/mqm/samp/bin/amqsget DEV.MY.QUEUE QM1
   Sample AMQSGET0 start
   message <Test message 1>
   message <Test message 2>
   message <Test message 3>
   ```
   If you now re-attempt the amqsput command this will now work.
 

### Resolving an error using the error log
IBM MQ has a feature rich authentication and authorization capability. In our lab we have not exposed many of these controls but behind the scenes it is still completing these checks. In this section we will specify a user who can not be authenticated and understand how we can troubleshoot this issue. 

1. The sample programs can be configured to specify a username for the connection by setting an environment variable called: ```MQSAMP_USER_ID```. We will use this to cause an error when we attempt to PUT a message. 
Set the variable using the following command:         
   ```
   export MQSAMP_USER_ID=nouser
   ```
   Now lets try and PUT a message to the queue:      
   ```
   bash-4.4$ echo "Test message 1" | ./amqsput DEV.MY.QUEUE QM1
   Sample AMQSPUT0 start
   Enter password: MQCONNX ended with reason code 2035
   ```
   We can see that this failed with a return code of 2035. We can use the mqrc command to view what this command means:       
   ```
   bash-4.4$ mqrc 2035

      2035  0x000007f3  MQRC_NOT_AUTHORIZED
   ```
   At this stage we can understand that we were not Authorized (which also covers authentication in this context), but this may be inadequate information to resolve the issue. 
   It is standard practice to provide limited troubleshooting information in the case of a security error as we do not want to assist hackers.
1. IBM MQ provides comprehensive error logs on the MQ server that can provide additional context to resolve this issue.
IBM MQ error logs are located in ```/var/mqm/qmgrs/<Queue Manager Name>/errors```. As our queue manager is called QM1 so change directories to this location:   
   ```
   cd /var/mqm/qmgrs/QM1/errors/
   ```
1. Within this directory by default there are two sets of three files:     
   * Traditionally formatted MQ log files
      * AMQERR01.LOG  
      * AMQERR02.LOG
      * AMQERR03.LOG
   * JSON formatted MQ log files
      * AMQERR01.json
      * AMQERR02.json
      * AMQERR03.json
   Error messages will be written to these files, starting with AMQERR01, and when this becomes full writing will continue in AMQERR02. 
   This rolling process occurs until all three files are full before wrapping back to the first error log. 
   In our case we only have a small number of entries and therefore we can simply output the last few lines of AMQERR01 to see the details of the error:      
   ```
   tail -n 35 AMQERR01.LOG
   ```
   You should be an output similar to the below:
   ```
   ----- amqzfuca.c : 4736 -------------------------------------------------------
   04/03/20 12:09:43 - Process(329.19) User(mqm) Program(amqzlaa0)
                       Host(1b7e5920616d) Installation(Installation1)
                       VRMF(9.1.5.0) QMgr(QM1)
                       Time(2020-04-03T12:09:43.823Z)
                       CommentInsert1(nouser)
                       CommentInsert2(DEV.AUTHINFO)
                       CommentInsert3(CHCKLOCL(OPTIONAL))
                   
   AMQ5542I: The failed authentication check was caused by the queue manager
   CONNAUTH CHCKLOCL(OPTIONAL) configuration.

   EXPLANATION:
   The user ID 'nouser' and its password were checked because the queue manager
   connection authority (CONNAUTH) configuration refers to an authentication
   information (AUTHINFO) object named 'DEV.AUTHINFO' with CHCKLOCL(OPTIONAL). 

   This message accompanies a previous error to clarify the reason for the user ID
   and password check.
   
   ACTION:
   Refer to the previous error for more information. 

   Ensure that a password is specified by the client application and that the
   password is correct for the user ID. The authentication configuration of the
   queue manager connection determines the user ID repository. For example, the
   local operating system user database or an LDAP server. 

   If the CHCKCLNT setting is OPTIONAL, the authentication check can be avoided by
   not passing a user ID across the channel. For example, by omitting the MQCSP
   structure from the client MQCONNX API call. 

   To avoid the authentication check, you can amend the authentication
   configuration of the queue manager connection, but you should generally not
   allow unauthenticated remote access.
   ----- amqzfuca.c : 4759 -------------------------------------------------------
   ```
   If you read the *EXPLANATION* text you will see that the user *nouser* can not be authenticated and therefore fails. 
   The fix in this case is straight forward, as username and password is optional if we unset the environment variable and try again it will work:     
   ```
   bash-4.4$ unset MQSAMP_USER_ID
   bash-4.4$ echo "Test message 1" | ./amqsput DEV.MY.QUEUE QM1
   Sample AMQSPUT0 start
   target queue is DEV.MY.QUEUE
   Sample AMQSPUT0 end
   ```

## Understand Queues in IBM MQ
An IBM MQ queue is a named object on which applications can put messages, and from which applications can get messages. 
There are several types of Queue that you can define:
* Local queues: is the only type of queue that stores messages for applications
* Alias queues: points to another queue or a topic on the same Queue Manager
* Remote queues: similar to alias queues by the target is on another Queue Manager. 
* Model queues: when an application opens a model queue, a local queue with the same attributes as the model queue is automatically created. 
In previous sections we create a local queue, we will now create a alias for this queue and demonstrate why this may be valuable. 
To demonstrate the other administrative interfaces we will complete this using the command line.

1. In the same terminal window that you had from the previous section run:      
   ```
   runmqsc QM1
   ```
   This starts a MQSC session to QM1 and you will see the following output:     
   ```
   5724-H72 (C) Copyright IBM Corp. 1994, 2020.
   Starting MQSC for queue manager QM1.
   ```
1. From here you can complete administrative commands to create, modify and delete MQ objects. We will use it to create a new Alias Queue. Type the following:      
   ```
   define qa('DEV.ALIAS.MY.QUEUE') TARGET('DEV.MY.QUEUE')
   ```
   This will create a new alias queue called *DEV.ALIAS.MY.QUEUE* that point to *DEV.MY.QUEUE*.
   The properties of this alias queue can be displayed by running: 
   ```
   dis qa('DEV.ALIAS.MY.QUEUE')
   ```
   You will see the following output:      
   ```
   dis qa('DEV.ALIAS.MY.QUEUE')
     5 : dis qa('DEV.ALIAS.MY.QUEUE')
   AMQ8409I: Display Queue details.
   QUEUE(DEV.ALIAS.MY.QUEUE)               TYPE(QALIAS)
   ALTDATE(2020-04-03)                     ALTTIME(16.34.46)
   TARGET(DEV.MY.QUEUE)                    CLUSNL( )
   CLUSTER( )                              CLWLPRTY(0)
   CLWLRANK(0)                             CUSTOM( )
   DEFBIND(OPEN)                           DEFPRTY(0)
   DEFPSIST(NO)                            DEFPRESP(SYNC)
   DEFREADA(NO)                            DESCR( )
   GET(ENABLED)                            PUT(ENABLED)
   PROPCTL(COMPAT)                         SCOPE(QMGR)
   TARGTYPE(QUEUE)                      
   ```
1. To exit the MQSC shell type ```exit```. Lets verify that we can now PUT a message to DEV.ALIAS.MY.QUEUE and GET it from DEV.MY.QUEUE. Run the following:    
   ```
   echo "Putting to the alias queue" | ./amqsput DEV.ALIAS.MY.QUEUE QM1
   ```
   Lets get the message now from DEV.MY.QUEUE:
   ```
   ./amqsget DEV.MY.QUEUE QM1
   Sample AMQSGET0 start
   message <Test message 1>
   message <Test message 1>
   message <Putting to the alias queue>
   no more messages
   Sample AMQSGET0 end
   ```
   So why are alias queue useful, well it provides an opportunity to specify different access permissions and settings for 
   individual queues, while consolidating all the messages into a single local queue for consumption.


