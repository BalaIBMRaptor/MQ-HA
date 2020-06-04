# IBM MQ on the Cloud Pak for Integration
This repository demonstrates how to get started with IBM MQ on the Cloud Pak for Integration. There are separate sections that highlight how to complete common initial tasks:

## Basic configuration
* [RECOMMENDED - Deploy a persistent Queue Manager in a High Availability mode suitable for demonstration](instructions/multiInstance.md)
* [Deploy a simple non-persistent Queue Manager suitable for demonstration](instructions/nonPersistent.md)
* [Connecting MQ Explorer to a deployed Queue Manager](instructions/MQExplore.md)

## Advanced bolt-ons
* [ADVANCED - Building a OpenShift Pipeline that automatically configures MQ LDAP configuration](instructions/MQBuildWithLDAPEnabled.md)
* [ADVANCED - Loading MQSC configuration using a configMap](instructions/configMap.md)
* [ADVANCED - Building a Uniform Cluster](instructions/uniformCluster/instructions.md)

## Learning the basics of IBM MQ using your own laptop
* [Learning the basics of IBM MQ using your own laptop](instructions/docker/MQGettingStarted.md)

## Other resources that you may find useful
* [Cloud Pak Adoption Team Repository](https://github.ibm.com/cpat/integration-chapter/tree/master/mq/docs)
