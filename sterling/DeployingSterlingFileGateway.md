# Deploying IBM Sterling File Gateway on OpenShift Cluster

Sterling File Gateway allows integration with IBM Partner Engagement Manager to help manage the onboarding of trading partners.

## 1.0 Architecture

## 2.0 Requirements
* [ ] Database
* [ ] Storage
* [ ] Sterling B2B Integrator 5.2 License
* [ ] Sterling File Gateway 2.2.6 License
* [ ] IBM Partner Engagement Manager (PEM) integration

## 3.0 Downloading the product

## 4.0 Environment Setup

### 4.1 Prepare Client machine

* Log into your OCP cluster
```
oc login --token=<token> --server=<server>
```

* Install the Kubeseal CLI
```
yum install kubeseal -y 
```
### 4.1 DB2 Setup
```
DB2_SKIPDELETED = ON
DB2_SKIPINSERTED = ON
Database Code Set UTF-8
```
Setting up a test DB2 environment on a RHEL VM
```
export DOCKER_DEFAULT_PLATFORM=linux/amd64
docker run -itd --name sterling-db2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=password -e DBNAME=STRDB -v /data/sterlingdb:/database ibmcom/db2
```


### 4.3 Create Role Based Access
```
cat <<EOF |oc apply -f -

apiVersion: v1
kind: Secret
metadata:
  name: b2b-system-passphrase-secret
type: Opaque
stringData:  
  SYSTEM_PASSPHRASE: sterling123
EOF
```  

## 5.0 Installing the product
### 5.1 Sterling B2Bi 6.1.2


#### 5.1.1 Property files
Five different kinds of property files exist in Sterling B2B Integrator.

- 5.1.1.1 Initial Settings for Property Files
  
### 5.6 IBM Sterling Partnet Engagement Manager (PEM) 6.2.2
https://www.ibm.com/docs/en/spems/6.2.2?topic=container-installing-chart-using-helm-command-line

## 6.0 Configuration

## 7.0 Validation
