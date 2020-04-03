# Develop your first JMS application with MQ

Point to point with JMS
=======================

### Write and run your first IBM MQ JMS application

What you will learn
-------------------

1.  JMS 2.0 basics
2.  How JMS client objects map to MQ server objects
3.  Simplest way to put and get a message to and from a queue

What you will need
------------------

1.  [JMS classes – JMS.jar](https://repo1.maven.org/maven2/javax/jms/javax.jms-api/2.0.1/javax.jms-api-2.0.1.jar)
2.  [IBM and IBM MQ classes for JMS – com.ibm.mq.allclient.jar](https://repo1.maven.org/maven2/com/ibm/mq/com.ibm.mq.allclient/9.1.4.0/com.ibm.mq.allclient-9.1.4.0.jar)
3.  [Java Software Development Kit (JDK)](https://developer.ibm.com/javasdk/downloads/sdk8/) – to develop and run applications
4.  [JmsPutGet.java](https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/jms/JmsPutGet.java) sample

* * *

#### Contents

* * *

1.  [Point to point with JMS and IBM MQ](#ptp-jms-apps-with-mq)
2.  [Set up your environment](#set-up-environment)
3.  [Point to point sample walkthrough](#ptp-sample-walkthrough)
4.  [Compile and run your application](#run-sample)
5.  [Learn more about JMS](#jms-20)

Point to point with JMS and IBM MQ
----------------------------------

JMS stands for Java Message Service. JMS is a standard that defines how you can access enterprise messaging systems from Java programs. JMS API is implemented by messaging service providers like IBM MQ to allow JMS client applications to access the provider’s messaging service.

Say you want to send data from your application to a single queue.
In this tutorial, you’ll put a message that holds your data to a queue and the consuming application will get it from the queue.
You’ll be using the JMS API to connect to your messaging provider which in this case is IBM MQ.

Your application has to be able to do these things:

*   Connect to the queue manager
*   Open a queue
*   Put a message
*   Get a message
*   Close the queue
*   Disconnect from the queue manager

We assume that these MQ objects are set up on the MQ server that you are connecting to:

*   Queue manager QM1
*   Queue DEV.QUEUE.1
*   Channel DEV.APP.SVRCONN
*   Port 1414

Adjust accordingly if you are using your own objects, or go to [Ready, Set, Connect](/messaging/ready-set-connect) to get started.
If you’ve worked through Ready, Set, Connect, your queue manager should already be configured correctly.
If not, you need to set up authorisation on the queue manager to accept connection from the application through a named channel and the application has to be authorised to put and get messages to and from the queue.
If you already have a JMS application but want some help with performance or debugging, [try this tutorial](http://developer.ibm.com/messaging/learn-mq/mq-tutorials/slow-lost-messages-high-cpu-improve-your-mq-app/).

Set up your environment
-----------------------

To develop and run MQ JMS client applications you need access to:

1.  JMS classes – JMS.jar
2.  IBM and IBM MQ classes for JMS – com.ibm.mq.allclient.jar
3.  Java Software Development Kit (JDK) to develop, compile and run applications
4.  A simple editor to write your applications

Create a directory to save the files needed for the sample, for example in your home directory:

[Copy]

    mkdir MQClient

From the MQClient folder, first download the pre-reqs by using wget OR curl:

*   Get the latest version of the IBM MQ com.ibm.mq.allclient.jar:

    [Copy]

        wget https://repo1.maven.org/maven2/com/ibm/mq/com.ibm.mq.allclient/9.1.4.0/com.ibm.mq.allclient-9.1.4.0.jar

    [Copy]

        curl -o com.ibm.mq.allclient-9.1.4.0.jar https://repo1.maven.org/maven2/com/ibm/mq/com.ibm.mq.allclient/9.1.4.0/com.ibm.mq.allclient-9.1.4.0.jar

*   Get the latest JMS API jms.jar:

    [Copy]

        wget https://repo1.maven.org/maven2/javax/jms/javax.jms-api/2.0.1/javax.jms-api-2.0.1.jar

    [Copy]

        curl -o javax.jms-api-2.0.1.jar https://repo1.maven.org/maven2/javax/jms/javax.jms-api/2.0.1/javax.jms-api-2.0.1.jar

*   If you don’t already have a Java JDK version 8, you can download it from [here](https://developer.ibm.com/javasdk/downloads/sdk8/). Select the right download for your platform and install.

    On Linux, depending on which package you downloaded you need to run it to install. For example, if you downloaded ibm-java-sdk-8.0-5.10-x86\_64-archive.bin, run:

    [Copy]

        ./ibm-java-sdk-8.0-5.10-x86_64-archive.bin

    For Windows you need to download the Eclipse package that contains the JDK.
    Ensure that the JDK is on the system path:

    On Linux:

    [Copy]

        PATH=~/ibm-java-x86_64-80/bin:$PATH


Point-to-point sample walkthrough
---------------------------------

Lets get the sample from GitHub, save it on your local machine and look through some of the key JMS constructs and where you can add the host, port, channel and queue details so your sample can connect to the queue manager.

In your MQClient directory, create the following directory structure:
com/ibm/mq/samples/jms

On Linux:

[Copy]

    mkdir -p com/ibm/mq/samples/jms

From the MQClient/com/ibm/mq/samples/jms directory, issue ONE of the commands to grab the JmsPutGet.java sample from GitHub.

[Copy]

    wget https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/jms/JmsPutGet.java

[Copy]

    curl -o JmsPutGet.java https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/jms/JmsPutGet.java

Edit the JMSPutGet.java file. Replace the host, port and app password variables to match your queue manager configuration.

[Copy]

    // Create variables for the connection to MQ
    private static final String HOST = "_YOUR_HOSTNAME_"; // Host name or IP address
    private static final int PORT = 1414; // Listener port for your queue manager
    private static final String CHANNEL = "DEV.APP.SVRCONN"; // Channel name
    private static final String QMGR = "QM1"; // Queue manager name
    private static final String APP_USER = "app"; // User name that application uses to connect to MQ
    private static final String APP_PASSWORD = "_APP_PASSWORD_"; // Password that the application uses to connect to MQ
    private static final String QUEUE_NAME = "DEV.QUEUE.1"; // Queue that the application uses to put and get messages to and from

Create the connection factory programatically by using WMQConstants parameters. WMQConstants refers to MQ specific property names and values that can be set through the client. IBM MQ classes for JMS contain a set of extensions to the JMS API, called [IBM JMS extensions](https://www.ibm.com/support/knowledgecenter/en/SSFKSJ_9.0.0/com.ibm.mq.dev.doc/q032180_.htm). Your application can use these extensions to create connection factories and destinations dynamically, at runtime, and set MQ specific object properties.

[Copy]

    // Create a connection factory
    JmsFactoryFactory ff = JmsFactoryFactory.getInstance(WMQConstants.WMQ_PROVIDER);
    JmsConnectionFactory cf = ff.createConnectionFactory();

You need to include declarations for the ibm.com connection factory classes and the WMQ Constants classes that all extend JMS classes:

[Copy]

    import com.ibm.msg.client.jms.JmsConnectionFactory;
    import com.ibm.msg.client.jms.JmsFactoryFactory;
    import com.ibm.msg.client.wmq.WMQConstants;

You are creating JMS objects that will map to MQ objects. The following MQ Constants properties are used by the connection factory to create a connection when the application is run:

[Copy]

    // Set the properties
    cf.setStringProperty(WMQConstants.WMQ_HOST_NAME, HOST);
    cf.setIntProperty(WMQConstants.WMQ_PORT, PORT);
    cf.setStringProperty(WMQConstants.WMQ_CHANNEL, CHANNEL);
    cf.setIntProperty(WMQConstants.WMQ_CONNECTION_MODE, WMQConstants.WMQ_CM_CLIENT);
    cf.setStringProperty(WMQConstants.WMQ_QUEUE_MANAGER, QMGR);
    cf.setStringProperty(WMQConstants.WMQ_APPLICATIONNAME, "JmsPutGet (JMS)");
    cf.setBooleanProperty(WMQConstants.USER_AUTHENTICATION_MQCSP, true);
    cf.setStringProperty(WMQConstants.USERID, APP_USER);
    cf.setStringProperty(WMQConstants.PASSWORD, APP_PASSWORD);

In production, you would use a JNDI store to look this information up. We’ve mentioned the objects that are set up on the MQ server side. The WMQConstants properties for host name and port map obviously to the MQ server objects. An additional property for the connection factory object is connection mode. We’ll be connecting in client mode. Applications can connect to the queue manager in client or bindings modes. Bindings mode for JMS uses Java Native Interface (JNI) when both the MQ server and client are running in the same environment. Client mode uses the TCP /IP protocol when MQ server and client are running on different environments.

Use the connection factory to create the context and use the context to create the destination. Without the JNDI store to look up the destination, pass in the actual queue name that you’re aiming for on the MQ server.

[Copy]

    // Create JMS objects
    context = cf.createContext();
    destination = context.createQueue("queue:///" + QUEUE_NAME);

    //Set up the message
    long uniqueNumber = System.currentTimeMillis() % 1000;
    TextMessage message = context.createTextMessage("Your lucky number today is " + uniqueNumber);

Include the declarations for the JMS context, destination and the JMS text message:

[Copy]

    import javax.jms.Destination;
    import javax.jms.JMSContext;
    import javax.jms.TextMessage;

Use the context to create the producer. The producer sends the message using the destination to put the message to the right queue:

[Copy]

    producer = context.createProducer();
    producer.send(destination, message);
    System.out.println("Sent message:\n" + message);

Include the declaration for the JMS producer:

[Copy]

    import javax.jms.JMSProducer;

Use the context to create the consumer. The consumer uses the destination to receive the message from the right queue.

[Copy]

    consumer = context.createConsumer(destination); // autoclosable
    String receivedMessage = consumer.receiveBody(String.class, 15000); // in ms or 15 seconds

Include the declaration for the JMS consumer:

[Copy]

    import javax.jms.JMSConsumer;

The sample also has a couple of class utility methods for printing exceptions.

Go ahead and include the declaration for the JMS exceptions:

[Copy]

    import javax.jms.JMSException;

You should now be able to compile your application and run it.

Compile and run your application
--------------------------------

This is where you’ll finally connect your application to the queue manager and put and get messages to and from the queue.

To compile the sample, go to your MQClient directory.

Use javac to compile your application.

On Linux:

[Copy]

    javac -cp ./com.ibm.mq.allclient-9.1.4.0.jar:./javax.jms-api-2.0.1.jar com/ibm/mq/samples/jms/JmsPutGet.java

To confirm that the sample is compiled:


On Linux, run the ls command:

[Copy]

    ls -l com/ibm/mq/samples/jms/

You should now see a .class file accompanying the .java file.

On Linux:

\-rw-r--r-- 1 root root 3788 Feb 22 18:34 JmsPutGet.class
-rw-r--r-- 1 root root 5099 Feb 22 18:22 JmsPutGet.java

Run your application:

On Linux:

[Copy]

    java -cp ./com.ibm.mq.allclient-9.1.4.0.jar:./javax.jms-api-2.0.1.jar:. com.ibm.mq.samples.jms.JmsPutGet

You should see output like this:

Sent message:

  JMSMessage class: jms\_text
  JMSType:          null
  JMSDeliveryMode:  2
  JMSDeliveryDelay: 0
  JMSDeliveryTime:  1519399851110
  JMSExpiration:    0
  JMSPriority:      4
  JMSMessageID:     ID:414d5120514d312020202020202020208731905a21a55202
  JMSTimestamp:     1519399851110
  JMSCorrelationID: null
  JMSDestination:   queue:///DEV.QUEUE.1
  JMSReplyTo:       null
  JMSRedelivered:   false
    JMSXAppID: JmsPutGet (JMS)
    JMSXDeliveryCount: 0
    JMSXUserID: app
    JMS\_IBM\_PutApplType: 28
    JMS\_IBM\_PutDate: 20180223
    JMS\_IBM\_PutTime: 15305112
Your lucky number today is 95

Received message:
Your lucky number today is 95
SUCCESS

Congratulations! You wrote, edited and compiled your first JMS application, sent a message to an IBM MQ queue and got it from the queue. You also set up your environment with everything you need to develop with JMS and IBM MQ.
You have a basic understanding of what you’re aiming to hit on the MQ server side with the objects in your JMS application and how JMS helps you achieve that.
If you want to make sure your JMS application is going to perform reliably and well, [have a look at this tutorial](http://developer.ibm.com/messaging/learn-mq/mq-tutorials/slow-lost-messages-high-cpu-improve-your-mq-app/).

Learn more about JMS
--------------------

Click to see the JMS summary with diagrams
------------------------------------------

This tutorial is based on JMS 2.0 or simplified JMS API. Earlier versions can still be used to support backward compatibility. Check out the JMS 2.0 specification [here](http://download.oracle.com/otndocs/jcp/jms-2_0-fr-eval-spec/index.html).

JMS takes messaging objects that are common to different messaging providers and defines them in a way that can be reused regardless of the JMS messaging provider.
It also provides facilities for encapsulating concepts that are specific to each provider, in a way that can minimise how much a developer needs to know about how each messaging provider works.

IBM MQ implements JMS and provides a set of classes that your application can use. You need to have access to these classes as well as the JMS API.

![Diagram shows three columns with four boxes, from left, first box represents the JMS Provider or IBM MQ server with the queue manager, host name, port, channel and queue; the second box represents the JMS application with JMS context, connection factory, destination, message producer and consumer, in the third column the third box represents the IBM MQ allclient jar wit MQ classes for JMS and IBM JMS classes and the lower fourth box that is also in column three represents the JMS jar with the JMS API.](/static/site-id/18/images/svg/jms_diagram_1.svg)

Figure 1. Overview of components: MQ server, MQ JMS client, MQ and JMS classes.

JMS supports two messaging styles, point to point and publish/subscribe.
Components of a JMS application are JMS client, messages, JMS provider and administered objects.
JMS Administered objects are connection factory and destination.

The objects or interfaces that JMS 2.0 provides are the main building blocks for your JMS application:
Message – BytesMessage, MapMessage, ObjectMessage, StreamMessage, TextMessage.
Queue – administered object that encapsulates the identity of a message destination for point to point messaging.
Topic – administered object that encapsulates the identity of a message destination for publish subscribe messaging.
Destination – the common supertype of Queue and Topic objects.

Connection factory – administered object used by a client to create a connection.
JMS context – active connection to a JMS Provider and a single threaded context for sending and receiving messages.
JMS producer – object created by a JMS Context that is used for sending messages to a queue or topic.
JMS consumer – object created by a JMS Context that is used for receiving messages sent to a queue or topic.

![The diagram shows the relationships between JMS objects and JMS administered objects. The connection factory administered object creates JMS Context object. The JMS Context object creates JMS Consumer, Producer and Message objects. JMS Producer and JMS Consumer both use the Destination administered objects to send and receive messages.](/static/site-id/18/images/svg/jms_diagram_2.svg)

Figure 2. Overview of the simplified JMS API objects.

On your client application side, the JMS API provides ways to access messaging provider (MQ) objects.
In production environments, your JMS administered objects would access information about the objects on the provider (MQ server) side, from a JNDI store that is separate from the client and the messaging server. Your application would not use each MQ parameter directly as this means it would be tightly coupled to the queue manager, channel and the queue.
Each time something changed with any of those, you would have to make changes to your application too.
The MQ administrator usually manages a store where connection factory and destination name-object pairs are bound, see [Figure 3](#figure-3).

![The diagram shows how the JNDI stores are bound by the admin tool and contain connection factory and destination stores. the JMS client looks up the connection factory and destination objects in JNDI. The JMS client also as a logical connection to the JMS Provider.](/static/site-id/18/images/svg/jms_diagram_3.svg)

Figure 3. How a JMS client looks up connection factory and destination objects in a JNDI store.

Rather than including the information about the queue, queue manager, host and channel in your application directly, you would program the connection factory and destination to look up this information through JNDI.
JMS encourages you to decouple your application from the messaging provider to minimise change and improve maintainability. You also want to decouple your application logic from your messaging provider so that the application is easily portable between providers.

Although JMS is really helping you in the long run by abstracting certain details away from your application, this can make JMS more difficult to understand. In this tutorial, we’ve set up the application to be tightly coupled to the queue manager and queue because this is the easiest way to understand what is happening.

![Diagram shows three boxes; one represents the IBM MQ server, one represents the development environment with the client application and the third expands the client application box to show how the JMS components are used and how they interact with MQ server objects.The connecting arrows show how different components interact.](/static/site-id/18/images/svg/jms_diagram_4.svg)

Figure 4. Overview of the working structure of a simple MQ JMS point-to-point application

Your application uses the connection factory to create the connection to the queue manager and the destination defines the queue object that you need to use to send messages to the actual MQ queue.

You’re ready to explore more tutorials that will expand your understanding of JMS and MQ.
