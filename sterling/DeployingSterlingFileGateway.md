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

* Registry login verification
```
podman login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY_SERVER} --tls-verify=false
```


* Create pull secret
```
kubectl create secret docker-registry <name of secret> --docker-server=<your-registry-server> --docker-username=<your-username> --docker-password=<your-password> --docker-email=<your-email>
```

* Global pull secret setup

```
# add-pull-secret.sh
#!/bin/bash

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <repo-url> <artifactory-user> <API-key>" >&2
  exit 1
fi

# set -x

REPO_URL=$1
REPO_USER=$2
REPO_API_KEY=$3

pull_secret=$(echo -n "$REPO_USER:$REPO_API_KEY" | base64 -w0)
oc get secret/pull-secret -n openshift-config -o jsonpath='{.data.\.dockerconfigjson}' | base64 -d | sed -e 's|:{|:{"'$REPO_URL'":{"auth":"'$pull_secret'","email":"not-used"\},|' > /tmp/dockerconfig.json
oc set data secret/pull-secret -n openshift-config --from-file=.dockerconfigjson=/tmp/dockerconfig.json


```
* Verify pull secrets
```
oc get secret/pull-secret -n openshift-config -o jsonpath='{.data.\.dockerconfigjson}' | base64 -d | jq
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
