# MAS9 Install

```
[ibmmas/cli:10.7.3]mascli$ mas install

IBM Maximo Application Suite Admin CLI v10.7.3
Powered by https://github.com/ibm-mas/ansible-devops/ and https://tekton.dev/


1) Set Target OpenShift Cluster
Already connected to OCP Cluster:
 https://console-openshift-console.apps.masai.cp.fyre.ibm.com

Proceed with this cluster? y

2) IBM Maximo Operator Catalog Selection
┌─────┬─────────────────┬───────────┬─────────┬──────────┬────────┬──────────┬───────────┬─────────────┬───────────┬──────────────┐
│   # │ catalog         │ release   │ core    │ assist   │ iot    │ manage   │ monitor   │ optimizer   │ predict   │ inspection   │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   1 │ v9-240730-amd64 │ 9.0.x     │ 9.0.1   │ 9.0.1    │ 9.0.1  │ 9.0.1    │ 9.0.1     │ 9.0.1       │ 9.0.0     │ 9.0.0        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   2 │ v9-240730-amd64 │ 8.11.x    │ 8.11.13 │ 8.8.5    │ 8.8.11 │ 8.7.10   │ 8.11.9    │ 8.5.7       │ 8.9.3     │ 8.9.4        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   3 │ v9-240730-amd64 │ 8.10.x    │ 8.10.16 │ 8.7.6    │ 8.7.15 │ 8.6.16   │ 8.10.12   │ 8.4.8       │ 8.8.3     │ 8.8.4        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   4 │ v9-240625-amd64 │ 9.0.x     │ 9.0.0   │ 9.0.0    │ 9.0.0  │ 9.0.0    │ 9.0.0     │ 9.0.0       │ 9.0.0     │ 9.0.0        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   5 │ v9-240625-amd64 │ 8.11.x    │ 8.11.12 │ N/A      │ 8.8.10 │ 8.7.9    │ 8.11.8    │ 8.5.6       │ 8.9.3     │ 8.9.3        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   6 │ v9-240625-amd64 │ 8.10.x    │ 8.10.15 │ N/A      │ 8.7.14 │ 8.6.15   │ 8.10.11   │ 8.4.7       │ N/A       │ 8.8.4        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   7 │ v8-240528-amd64 │ 8.11.x    │ 8.11.11 │ N/A      │ 8.8.9  │ 8.7.8    │ 8.11.7    │ 8.5.5       │ 8.9.2     │ 8.9.3        │
├─────┼─────────────────┼───────────┼─────────┼──────────┼────────┼──────────┼───────────┼─────────────┼───────────┼──────────────┤
│   8 │ v8-240528-amd64 │ 8.10.x    │ 8.10.14 │ N/A      │ 8.7.13 │ 8.6.14   │ 8.10.10   │ 8.4.6       │ N/A       │ 8.8.4        │
└─────┴─────────────────┴───────────┴─────────┴──────────┴────────┴──────────┴───────────┴─────────────┴───────────┴──────────────┘
Select catalog and release 1

3) License Terms
To continue with the installation, you must accept the license terms:
 - https://ibm.biz/MAS90-License
 - https://ibm.biz/MaximoIT90-License
 - https://ibm.biz/MAXArcGIS90-License
Do you accept the license terms? [y/n] y

4) Configure Storage Class Usage
Maximo Application Suite and it's dependencies require storage classes that support ReadWriteOnce (RWO) and ReadWriteMany (RWX) access modes:
  - ReadWriteOnce volumes can be mounted as read-write by multiple pods on a single node.
  - ReadWriteMany volumes can be mounted as read-write by multiple pods across many nodes.

Storage provider auto-detected: OpenShift Container Storage
  - Storage class (ReadWriteOnce): ocs-storagecluster-ceph-rbd
  - Storage class (ReadWriteMany): ocs-storagecluster-cephfs
Use the auto-detected storage classes? [y/n] y

5) Configure Product License
License file /home/masconfig/entitlement.lic
Contact e-mail address ekambara@us.ibm.com
Contact first name Lakshmana
Contact last name Ekambaram
IBM Data Reporter Operator (DRO) Namespace redhat-marketplace

6) Configure IBM Container Registry
IBM entitlement key ***************************************************************************************************************************************************
*****************************

7) Configure MAS Instance
Instance ID restrictions:
 - Must be 3-12 characters long
 - Must only use lowercase letters, numbers, and hypen (-) symbol
 - Must start with a lowercase letter
 - Must end with a lowercase letter or a number
Instance ID dev

Workspace ID restrictions:
 - Must be 3-12 characters long
 - Must only use lowercase letters and numbers
 - Must start with a lowercase letter
Workspace ID dev

Workspace display name restrictions:
 - Must be 3-300 characters long
Workspace name development

8) Configure Operational Mode
Maximo Application Suite can be installed in a non-production mode for internal development and testing, this setting cannot be changed after installation:
 - All applications, add-ons, and solutions have 0 (zero) installation AppPoints in non-production installations.
 - These specifications are also visible in the metrics that are shared with IBM and in the product UI.

  1. Production
  2. Non-Production
Operational Mode 2

9) Certificate Authority Trust
By default, Maximo Application Suite is configured to trust well-known certificate authoritories, you can disable this so that it will only trust the CAs that you explicitly define
Trust default CAs? [y/n] y

10) Cluster Ingress Secret Override
In most OpenShift clusters the installation is able to automatically locate the default ingress certificate, however in some configurations it is necessary to manually configure the name of the secret
Unless you see an error during the ocp-verify stage indicating that the secret can not be determined you do not need to set this and can leave the response empty
Cluster ingress certificate secret name

11) Configure Domain & Certificate Management
Configure domain & certificate management? [y/n] n

12) Single Sign-On (SSO)
Many aspects of Maximo Application Suite's Single Sign-On (SSO) can be customized:
 - Idle session automatic logout timer
 - Session, access token, and refresh token timeouts
 - Default identity provider (IDP), and seamless login
 - Brower cookie properties
Configure SSO properties? [y/n] n

13) Application Selection
Install IoT? [y/n] y
Install Monitor? [y/n] y
Install Manage? [y/n] y
Install Predict? [y/n] y
Install Assist? [y/n] y
Install Optimizer? [y/n] y
Install Visual Inspection? [y/n] y

14) Configure Maximo Manage
Customize your Manage installation, refer to the product documentation for more information

14.1) Maximo Manage Components
The default configuration will install Manage with Health enabled, alternatively choose exactly what industry solutions and add-ons will be configured
Select components to enable? [y/n] y
 - Asset Configuration Manager? [y/n] n
 - Aviation? [y/n] n
 - Civil Infrastructure? [y/n] n
 - Envizi? [y/n] y
 - Health? [y/n] y
 - Health, Safety and Environment? [y/n] y
 - Maximo IT? [y/n] n
 - Nuclear? [y/n] n
 - Oil & Gas? [y/n] n
 - Connector for Oracle Applications? [y/n] n
 - Connector for SAP Application? [y/n] n
 - Service Provider? [y/n] n
 - Spatial? [y/n] y
 - Strategize? [y/n] y
 - Transportation? [y/n] n
 - Tririga? [y/n] n
 - Utilities? [y/n] y
 - Workday Applications? [y/n] n

Maximo Spatial requires a map server provider in order to enable geospatial capabilities
You may choose your preferred map provider later or you can enable IBM Maximo Location Services for Esri now
This includes ArcGIS Enterprise as part of the Manage and Maximo Spatial bundle (Additional AppPoints required).
Include IBM Maximo Location Services for Esri? [y/n] y

IBM Maximo Location Services for Esri License Terms
For information about your IBM Maximo Location Services for Esri License visit: 
 https://ibm.biz/MAXArcGIS90-License
To continue with the installation, you must accept these additional license terms
Do you accept the license terms? [y/n] y

14.2) Maximo Manage Settings - Server Bundles
Define how you want to configure Manage servers:
 - You can have one or multiple Manage servers distributing workload
 - Additionally, you can choose to include JMS server for messaging queues

Configurations:
  1. Deploy the 'all' server pod only (workload is concentrated in just one server pod but consumes less resource)
  2. Deploy the 'all' and 'jms' bundle pods (workload is concentrated in just one server pod and includes jms server)
  3. Deploy the 'mea', 'report', 'ui' and 'cron' bundle pods (workload is distributed across multiple server pods)
  4. Deploy the 'mea', 'report', 'ui', 'cron' and 'jms' bundle pods (workload is distributed across multiple server pods and includes jms server)
Select a server bundle configuration 4
Only Manage JMS sequential queues (sqin and sqout) are enabled by default.
However, you can enable both sequential (sqin and sqout) and continuous queues (cqin and cqout)
Enable both Manage JMS sequential and continuous queues? [y/n] y

14.3) Maximo Manage Settings - Database
Customise the schema, tablespace, indexspace, and encryption settings used by Manage
Customize database settings? [y/n] n

14.4) Maximo Manage Settings - Customization
Provide a customization archive to be used in the Manage build process
Include customization archive? [y/n] n

14.5) Maximo Manage Settings - Other
Configure additional settings:
  - Demo data
  - Base and additional languages
  - Server timezone
  - Cognos integration (install Cloud Pak for Data)
  - Watson Studio Local integration (install Cloud Pak for Data)
Configure Additional Settings? [y/n] y
Create demo data? [y/n] y
Manage server timezone GMT

14.6) Maximo Manage Settings - Languages
Define the base language for Maximo Manage
Base language EN
Define the additional languages to be configured in Maximo Manage. provide a comma-separated list of supported languages codes, for example: 'JA,DE,AR'
A complete list of available language codes is available online:
    https://www.ibm.com/docs/en/mas-cd/mhmpmh-and-p-u/continuous-delivery?topic=deploy-language-support
Secondary languages
Integration with Cognos Analytics provides additional support for reporting features in Maximo Manage, for more information refer to the documentation online: 
    https://ibm.biz/BdMuxs
Enable integration with Cognos Analytics? [y/n] y
Enable integration with Watson Studio Local? [y/n] y

15) Configure Maximo Optimizer
Customize your Optimizer installation, 'full' and 'limited' install plans are available, refer to the product documentation for more information
Plan [full/limited] full

16) Configure Maximo Predict
Predict application supports integration with IBM SPSS and Watson Openscale which are optional services installed on top of IBM Cloud Pak for Data
Unless requested these will not be installed
Install IBM SPSS Statistics? [y/n] n
Install Watson OpenScale? [y/n] n

17) Configure Maximo Assist
Assist requires access to Cloud Object Storage (COS), this install supports automatic setup using either IBMCloud COS or in-cluster COS via OpenShift Container Storage/OpenShift Data Foundation (OCS/ODF)
COS Provider [ibm/ocs] ocs

18) Configure MongoDb
Install namespace mongoce

19) Configure Databases
The installer can setup one or more IBM Db2 instances in your OpenShift cluster for the use of applications that require a JDBC datasource (IoT, Manage, Monitor, & Predict) or you may choose to configure MAS to use an existing database

19.1) Database Configuration for Maximo IoT
Maximo IoT requires a shared system-scope Db2 instance because others application in the suite require access to the same database source
 - Only IBM Db2 is supported for this database
Create system Db2 instance using the IBM Db2 Universal Operator? [y/n] y

19.2) Database Configuration for Maximo Manage
Maximo Manage can be configured to share the system Db2 instance or use it's own dedicated database:
 - Use of a shared instance has a significant footprint reduction but is only recommended for development/test/demo installs
 - In most production systems you will want to use a dedicated database
 - IBM Db2, Oracle Database, & Microsoft SQL Server are all supported database options
Re-use System Db2 instance for Manage application? [y/n] n
Create manage dedicated Db2 instance using the IBM Db2 Universal Operator? [y/n] y
Available Db2 instance types for Manage:
  1. DB2 Warehouse (Default option)
  2. DB2 Online Transactional Processing (OLTP)
Select the Manage dedicated DB2 instance type 1

19.3) Installation Namespace
Install namespace db2u

19.4) Node Affinity and Tolerations
Note that the same settings are applied to both the IoT and Manage Db2 instances
Use existing node labels and taints to control scheduling of the Db2 workload in your cluster
For more information refer to the Red Hat documentation:
 - https://docs.openshift.com/container-platform/4.12/nodes/scheduling/nodes-scheduler-node-affinity.html
 - https://docs.openshift.com/container-platform/4.12/nodes/scheduling/nodes-scheduler-taints-tolerations.html
Configure node affinity? [y/n] n
Configure node tolerations? [y/n] n

19.5) Database CPU & Memory
Note that the same settings are applied to both the IoT and Manage Db2 instances
Customize CPU and memory request/limit? [y/n] n

19.6) Database Storage Capacity
Note that the same settings are applied to both the IoT and Manage Db2 instances
Customize storage capacity? [y/n] n

20) Configure Kafka
Maximo IoT requires a shared system-scope Kafka instance
Supported Kafka providers: Strimzi, Red Hat AMQ Streams, IBM Cloud Event Streams and AWS MSK
You may also choose to configure MAS to use an existing Kafka instance by providing a pre-existing configuration file
Create system Kafka instance using one of the supported providers? [y/n] y

Kafka Provider:
  1. Strimzi (opensource)
  2. Red Hat AMQ Streams (requires a separate license)
  3. IBM Cloud Event Streams (paid IBM Cloud service)
  4. AWS MSK (paid AWS service)
Select Kafka provider 1

Strimzi: Cluster Version
The version of the Strimzi operator available on your cluster will determine the supported versions of Kafka that can be deployed.
 - If you are using the latest available operator catalog then the default version below can be accepted
 - If you are using older operator catalogs (e.g. in a disconnected install) you should confirm the supported versions in your OperatorHub
Install namespace strimzi
Kafka version 3.7.0

21) Configure Grafana
Install namespace grafana5
Grafana storage size 10Gi

22) Configure Turbonomic
The IBM Turbonomic hybrid cloud cost optimization platform allows you to eliminate this guesswork with solutions that save time and optimize costs
 - Learn more: https://www.ibm.com/products/turbonomic
Configure IBM Turbonomic integration? [y/n] y
Turbonomic Target Name
Turbonomic Server URL
Turbonomic Server Version
Turbonomic Username
Turbonomic Password

23) Additional Configuration
Additional resource definitions can be applied to the OpenShift Cluster during the MAS configuration step
The primary purpose of this is to apply configuration for Maximo Application Suite itself, but you can use this to deploy ANY additional resource into your cluster
Use additional configurations? [y/n] n

24) Configure Pod Templates
The CLI supports two pod template profiles out of the box that allow you to reconfigure MAS for either a guaranteed or best effort QoS level
For more information about the Kubernetes quality of service (QoS) levels, see https://kubernetes.io/docs/concepts/workloads/pods/pod-qos/
You may also choose to use your own customized pod template definitions
Use pod templates? [y/n] y
Make a selection from the list below:

1. Guaranteed QoS
2. Best Effort QoS
3. Custom
Select pod templates profile 1
The following pod templates will be applied:
 - ibm-data-dictionary-assetdatadictionary.yml
 - ibm-mas-bascfg.yml
 - ibm-mas-coreidp.yml
 - ibm-mas-iot-actions.yml
 - ibm-mas-iot-auth.yml
 - ibm-mas-iot-datapower.yml
 - ibm-mas-iot-devops.yml
 - ibm-mas-iot-dm.yml
 - ibm-mas-iot-dsc.yml
 - ibm-mas-iot-edgeconfig.yml
 - ibm-mas-iot-fpl.yml
 - ibm-mas-iot-guardian.yml
 - ibm-mas-iot-iot.yml
 - ibm-mas-iot-mbgx.yml
 - ibm-mas-iot-mfgx.yml
 - ibm-mas-iot-monitor.yml
 - ibm-mas-iot-orgmgmt.yml
 - ibm-mas-iot-provision.yml
 - ibm-mas-iot-registry.yml
 - ibm-mas-iot-state.yml
 - ibm-mas-iot-webui.yml
 - ibm-mas-manage-healthextaccelerator.yml
 - ibm-mas-manage-healthextworkspace.yml
 - ibm-mas-manage-imagestitching.yml
 - ibm-mas-manage-manageaccelerators.yml
 - ibm-mas-manage-manageapp.yml
 - ibm-mas-manage-manageworkspace.yml
 - ibm-mas-manage-slackproxy.yml
 - ibm-mas-pushnotificationcfg.yml
 - ibm-mas-scimcfg.yml
 - ibm-mas-slscfg.yml
 - ibm-mas-smtpcfg.yml
 - ibm-mas-suite.yml
 - ibm-mas-visualinspection.yml
 - ibm-sls-licenseservice.yml
Are these the correct pod templates to apply? [y/n] y

25) Review Settings
Connected to:
 - https://console-openshift-console.apps.masai.cp.fyre.ibm.com

25.1) OpenShift Container Platform
  Storage Class Provider .................. ocs
  ReadWriteOnce Storage Class ............. ocs-storagecluster-ceph-rbd
  ReadWriteMany Storage Class ............. ocs-storagecluster-cephfs
  Certificate Manager ..................... redhat
  Cluster Ingress Certificate Secret ...... Default
  Single Node OpenShift ................... No
  Skip Pre-Install Healthcheck ............ No
  Skip Grafana-Install .................... No

25.2) IBM Container Registry Credentials
  IBM Entitlement Key ..................... eyJhbGci<snip>

25.3) IBM Data Reporter Operator (DRO) Configuration
  Contact e-mail .......................... ekambara@us.ibm.com
  First name .............................. Lakshmana
  Last name ............................... Ekambaram
  Install Namespace ....................... redhat-marketplace

25.4) IBM Suite License Service
  License File ............................ /home/masconfig/entitlement.lic
  IBM Open Registry ....................... icr.io/cpopen

25.5) IBM Maximo Application Suite
  Instance ID ............................. dev
  Workspace ID ............................ dev
  Workspace Name .......................... development

  Operational Mode ........................ Non-Production
  Install Mode ............................ Connected Install

  Manual Certificates ..................... Not Configured

  Catalog Version ......................... v9-240730-amd64
  Subscription Channel .................... 9.0.x

  IBM Entitled Registry ................... cp.icr.io/cp
  IBM Open Registry ....................... icr.io/cpopen

  Trust Default Cert Authorities .......... true

  Additional Config ....................... Not Configured
  Pod Templates ........................... /opt/app-root/lib64/python3.9/site-packages/mas/cli/templates/pod-templates/guaranteed

25.6) IBM Maximo Application Suite Applications
  IoT ..................................... 9.0.x
  + MQTT Broker Storage Class ............. ocs-storagecluster-ceph-rbd
  + FPL Storage Class ..................... ocs-storagecluster-ceph-rbd
  Monitor ................................. 9.0.x
  Manage .................................. 9.0.x
  + Components
    + ACM ................................. Disabled
    + Aviation ............................ Disabled
    + Civil Infrastructure ................ Disabled
    + Envizi .............................. Enabled
    + Health .............................. Enabled
    + HSE ................................. Enabled
    + Maximo IT ........................... Disabled
    + Nuclear ............................. Disabled
    + Oil & Gas ........................... Disabled
    + Connector for Oracle ................ Disabled
    + Connector for SAP ................... Disabled
    + Service Provider .................... Disabled
    + Spatial ............................. Enabled
    + Strategize .......................... Enabled
    + Transportation ...................... Disabled
    + Tririga ............................. Disabled
    + Utilities ........................... Enabled
    + Workday Applications ................ Disabled
  + Server bundle size .................... jms
  + Enable JMS queues ..................... true
  + Server Timezone ....................... GMT
  + Base Language ......................... EN
  + Additional Languages .................. Default
  + Database Settings
    + Schema .............................. Default
    + Username ............................ Default
    + Tablespace .......................... Default
    + Indexspace .......................... Default
  Loc Srv Esri (arcgis) ................... 9.0.x
  Predict ................................. 9.0.x
  Optimizer ............................... 9.0.x
   + Plan ................................. full
  Assist .................................. 9.0.x
  Visual Inspection ....................... 9.0.x
   + Storage Class ........................ ocs-storagecluster-cephfs

25.7) MongoDb
  Install Namespace ....................... mongoce

25.8) IBM Db2 Univeral Operator Configuration
  System Instance ......................... Install
  Dedicated Manage Instance ............... Install
   - Type ................................. db2wh
   - Timezone ............................. GMT

  Install Namespace ....................... db2u
  Subscription Channel .................... v110509.0

  CPU Request ............................. 4000m
  CPU Limit ............................... 6000m
  Memory Request .......................... 8Gi
  Memory Limit  ........................... 12Gi

  Meta Storage ............................ 20Gi
  Data Storage ............................ 100Gi
  Backup Storage .......................... 100Gi
  Temp Storage ............................ 100Gi
  Transaction Logs Storage ................ 100Gi

  Node Affinity ........................... None
  Node Tolerations ........................ None

25.9) Kafka
  Provider ................................ strimzi
  Version ................................. 3.7.0
  Install Namespace ....................... strimzi

25.10) IBM Cloud Pak for Data Configuration
  Version ................................. 4.8.0
  Watson Studio Local ..................... Install (Required by Maximo Predict)
  Watson Machine Learning ................. Install (Required by Maximo Predict)
  Analytics Engine ........................ Install (Required by Maximo Predict)
  Watson Openscale ........................ Do Not Install
  SPSS Modeler ............................ Do Not Install
  Cognos Analytics ........................ Install

25.11) Grafana
  Install Grafana ......................... Install

25.12) Turbonomic
  Turbonomic Integration .................. Disabled

Please carefully review your choices above, correcting mistakes now is much easier than after the install has begun
Proceed with these settings? [y/n] y

26) Launch Install
If you are using storage classes that utilize 'WaitForFirstConsumer' binding mode choose 'No' at the prompt below
Wait for PVCs to bind? [y/n] n
✅️ OpenShift Pipelines Operator is installed and ready to use
✅️ Namespace is ready (mas-dev-pipelines)
✅️ MAS CLI image deployment test completed
✅️ Latest Tekton definitions are installed (v10.7.3)
✅️ PipelineRun for dev install submitted

View progress:
  https://console-openshift-console.apps.masai.cp.fyre.ibm.com/k8s/ns/mas-dev-pipelines/tekton.dev~v1beta1~PipelineRun/dev-install-240817-0446
```
