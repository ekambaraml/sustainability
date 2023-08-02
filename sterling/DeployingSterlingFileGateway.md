# Deploying IBM Sterling File Gateway on OpenShift Cluster


## 1.0 Architecture

## 2.0 Requirements
* [ ] Database
* [ ] Storage
* [ ] Sterling B2B Integrator License
* [ ] Sterling File Gateway License

## 3.0 Downloading the product

## 4.0 Environment Setup

### 4.1 DB2 Setup
Setting up a test DB2 environment on a RHEL VM
```
export DOCKER_DEFAULT_PLATFORM=linux/amd64
docker run -itd --name sterling-db2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=password -e DBNAME=STRDB -v /data/sterlingdb:/database ibmcom/db2
```



## 5.0 Installing the product

## 6.0 Configuration

## 7.0 Validation
