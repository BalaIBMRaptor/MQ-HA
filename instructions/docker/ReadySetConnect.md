#### MQ in Containers

#### Contents

* * *

1.  [Install Docker](#docker-install-docker)
2.  [Get the MQ in Docker image](#docker-get-docker-image)
3.  [Run the container from the image](#docker-run-container)
4.  [Run the demo application in Docker](#docker-run-demo)
5.  [Put and get messages to and from a queue](#docker-put-get-messages)

#### "What do I need to start this tutorial?"

#### Just your laptop.

![](/static/site-id/18/images/svg/common_laptop.svg)

Install Docker
--------------

If you already have Docker version 17.06, continue to the [next section](#docker-get-docker-image). To find Docker for your platform, go to [Docker Community Edition](https://hub.docker.com/search/?type=edition&offering=community) and install. For example, if you're installing on Ubuntu, instructions are [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). If your Docker version is called docker or docker-engine, you need to uninstall these before installing the latest docker-ce version. Once you've installed Docker, come back to continue with the tutorial.

Get the MQ in Docker image
--------------------------

Containers are run from images and images are built from a specification listed in a Dockerfile. We will use a pre-built IBM MQ server image from Docker Hub so we can just run our container and end up with a working MQ installation and a pre-configured queue manager. For the MQ demo client application, we will download a Dockerfile and first build, then run the second container. We will use Docker to create a network for the containers to communicate. The client demo from the second container will connect to the queue manager that is running in the first container.

Pull the image from Docker hub that contains the latest version of the MQ server:

[Copy](javascript:;)

    docker pull ibmcom/mq:latest

When it’s done, check which images you have:

[Copy](javascript:;)

    docker images

You should see output like this:

REPOSITORY TAG IMAGE ID CREATED SIZE
ibmcom/mq latest 4c0dd6b16b70 2 days ago 773MB

Run the container from the image
--------------------------------

Now that the MQ server image is in your local Docker repository, you can run the container to stand up MQ in Ubuntu.

When you stand up a container, a filesystem is used that is deleted when the container is deleted.  
Queue manager and queue data is saved in the filesystem. To avoid losing the queue manager and queue data we can use volumes.  
Volumes are attached to containers when they are run and persist after the container is deleted. When you run a new container you can attach an existing volume and reuse your queue manager and queue data.

Use Docker to create a volume:

[Copy](javascript:;)

    docker volume create qm1data

Create a network that the MQ server container and the MQ client demo container can use to communicate:

[Copy](javascript:;)

    docker network create mq-demo-network

Run the MQ server container. Edit the command to set your own password for connecting applications. You will need this password later, for the client demo application and when you run your own client applications.

[Copy](javascript:;)

    docker run --env LICENSE=accept --env MQ_QMGR_NAME=QM1 --volume qm1data:/mnt/mqm --publish 1414:1414 --publish 9443:9443 --network mq-demo-network --network-alias qmgr --detach --env MQ_APP_PASSWORD=/your password here/ ibmcom/mq:latest

You're creating a queue manager which has been set up with some simple default configuration to help you connect your first client application.

We've added parameters to the docker run command, for example to accept the license for IBM MQ Advanced for developers and name the queue manager where our queue will live QM1.  
Because MQ running inside the container would be isolated from the rest of the world, we've opened a couple of ports that MQ uses.  
The queue manager listener listens on port 1414 for incoming connections and port 9443 is used by MQ console.  
The MQ demo client application will use the listener port and MQ Console dashboard can be seen in your browser on port 9443.

Give the container a moment to start, then check it’s running:

[Copy](javascript:;)

    docker ps

You should see output like this:

CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
<your container id> ibmcom/mq:latest "runmqdevserver" 33 seconds ago Up 29 seconds 0.0.0.0:1414->1414/tcp, 0.0.0.0:9443->9443/tcp dazzling\_ritchie

Congratulations! You've just created your first simple queue manager. It's called QM1 and it's running inside the container.  
To access it, you'll be connecting over TCP/IP, which is why you needed to expose the port 1414.

Copy your own container id and use it to get command line access inside the container, for example:

[Copy](javascript:;)

    docker exec -ti <your container id> /bin/bash

You should see output like this:

(mq:9.1.2.0)mqm@<your container id>:/#

You can display the MQ Installation and Data paths by running the ‘display MQ version’ command in your command line interface:

[Copy](javascript:;)

    dspmqver

You should see output like this:

Name: IBM MQ
Version: 9.1.2.0
Level: p912-L190313.DE
BuildType: IKAP - (Production)
Platform: IBM MQ for Linux (x86-64 platform)
Mode: 64-bits
O/S: Linux 4.9.49-moby
InstName: Installation1
InstDesc:
Primary: Yes
InstPath: /opt/mqm
DataPath: /var/mqm
MaxCmdLevel: 912
LicenseType: Developer

Display your running queue managers:

[Copy](javascript:;)

    dspmq

You should see output like this:

QMNAME(QM1) STATUS(Running)

To come out of the docker container and return to your Linux command line, type:

[Copy](javascript:;)

    exit

You have downloaded the pre-built Docker image and ran the container to get MQ running on Ubuntu. MQ objects and permissions that the client demo application needs to connect to a queue manager and put and get messages to and from the queue, are created automatically. Docker and MQ are using your host computer resources and connectivity. Inside the container, the MQ installation on Ubuntu has the following objects and permissions set:

*   Queue manager QM1
*   Queue DEV.QUEUE.1
*   Channel DEV.APP.SVRCONN
*   Listener DEV.LISTENER.TCP on port 1414

The queue that you will be using, DEV.QUEUE.1, 'lives' on the queue manager QM1.  
The queue manager also has a listener that listens for incoming connections, for example, on port 1414.  
Client applications connect to the queue manager and can open, put, and get messages, and close the queue.  
Applications use an MQ channel to connect to the queue manager. Access to these three objects is restricted in different ways.  
For example, user 'app', who is a member of the group ‘mqclient’ is permitted to use the channel ‘DEV.APP.SVRCONN’ to connect to the queue manager QM1 and is authorised to put and get messages to and from the queue DEV.QUEUE.1.  
All the MQ objects and permissions that the demo application needs are created and configured when you run the MQ server container.

![](/static/site-id/18/images/svg/rsc_docker_diagram.svg)

Run the demo application in Docker
----------------------------------

Now you have a queue manager running in a container and you know how to connect to it, the next step is to get the point-to-point demo application and see MQ in action. Download the Dockerfile from [here](https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/mq-demo-client-application/Dockerfile) and save it to a folder from which you can build the container with the MQ client demo application running inside it.  
You can also use wget or curl to download the Dockerfile directly from:

[Copy](javascript:;)

    https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/mq-demo-client-application/Dockerfile

Build the Docker image:

[Copy](javascript:;)

    docker build -t mq-demo .

Run the container to get the client demo application running:

[Copy](javascript:;)

    docker run --network mq-demo-network -ti mq-demo

You should see output like this:

Extracting to /tmp/mq-demo…
Initializing...

As we're using the queue manager that is configured as the demo expects, we can leave most of the configuration as defaults, the only thing you need to supply are the hostname of the queue manager container and the password you set for the application user. These were both set when we started the MQ container, the hostname is "qmgr" and you picked the password.

1\. Type the name of your queue manager (leave blank for QM1):
2. Type the host name or IP address for your queue manager:
qmgr
3. Type the listener port for your queue manager (leave blank for 1414):
4. Type the name of the application channel (leave blank for 'DEV.APP.SVRCONN'):
5. Type the name of the queue (leave blank for 'DEV.QUEUE.1'):
6. Type the application user name (leave blank for 'app'):
7. Type the password for this user:
(Type the MQ\_APP\_PASSWORD you set when you ran the MQ server Docker container)

You should see output like this:

Connecting to queue manager 'QM1'
at address 'mq-demo-network(1414)'
through channel 'DEV.APP.SVRCONN'
as user 'app'
. . .
Connected!
Type PUT \[number\] to put a given number of messages to the queue
Type GET \[number\] to get a given number of messages to the queue
Type AUTO \[seconds\] to put and get messages automatically for a given number of seconds
Type EXIT to quit
Type HELP to display this message

Put and get messages to and from a queue
----------------------------------------

You've connected. Now you can start to put and get some messages. For example:

\> > put 20
Attempting to put 20 messages to the queue...
Successfully put 20 messages
Check the MQ Console to see that these 20 messages have been added to the queue
> get 18
Attempting to get 18 messages from the queue...
Successfully retrieved 18 messages
Check the MQ Console to see that these 18 messages have been removed from the queue
> get 3
Attempting to get 3 messages from the queue...
Successfully retrieved 3 messages
Check the MQ Console to see that these 3 messages have been removed from the queue
> auto 6
The application will put and get messages for 6 seconds
Check the MQ Console to see these messages being added and removed to and from the queue
PUT: 4, GET: 3, elapsed: 5s
Terminated
> get 6
Attempting to get 6 messages from the queue...
Only 1 messages found
Successfully retrieved 1 messages
Check the MQ Console to see that these 1 messages have been removed from the queue
> exit
Exiting...
Successfully disconnected from queue manager.
Cleaning up...

You might remember we mentioned the MQ Console when we created the MQ server container. This is the web based way to view and administer queue managers. We assigned port 9443 for the MQ Console to use at the start, so if you point a browser on your local system to [https://localhost:9443/ibmmq/console/](https://localhost:9443/ibmmq/console/) you'll be able to take a look at QM1. The default configuration of QM1 limits administrative access to a user called "admin", so you'll need to log in as "admin" when asked. Also, as we didn't override the password when we created the container, this is set to "passw0rd".

You used the client demo application to configure the connection to the queue manager that is running inside the Docker container. The app opened a queue, put messages to it and then got messages from the same queue. The app demonstrates point-to-point style of messaging.  
It just so happens that the demo app first acts as the producer point when it puts a message and then as the consumer point when it gets the message from the queue.  
In IBM MQ, the queue manager is effectively the server part of the system and applications that connect to it are clients.  
Usually it is the administrators that look after the MQ server part where all the MQ objects are defined and the routing of messages happens. Clients are created by developers but MQ provides some resources that developers can include in their applications that address and use the MQ objects that admins have set up on the MQ server side.  
This tutorial shows that configuration is needed on both the server and the client sides for the messaging to work. While as a developer you would not usually worry about the MQ server, it helps to be aware of some of the particulars of it.  
Also, when you first start developing MQ client applications, it helps to have access to your own queue manager and a queue, for testing your client application against. The preconfigured MQ in Docker image and the container that you can easily run from it provide this in an easy and light weight way to get you going quickly.

![](/static/site-id/18/images/svg/rsc_docker_demo_diagram.svg)
