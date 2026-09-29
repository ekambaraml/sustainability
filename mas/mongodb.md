# Using MongoDB in Maximo Application Suite


### Log into OpenShift cluster
```yaml
# oc login --token=<YOUR_TOKEN> --server=https://<YOUR_OPENSHIFT_CLUSTER_URL>:6443
oc login
```

### Change to mongodb project name
```
oc project mongoce
```

### Connect to MongoCe
```
PASSWORD=`oc get secret mas-mongo-ce-admin-admin -n mongoce -o jsonpath='{.data.password}' | base64 --decode;`

oc exec -it mas-mongo-ce-0 -n mongoce -- mongosh -u admin -p ${PASSWORD} --authenticationDatabase admin
```


## Using Mongo Client "mongosh"
```
oc login --token=<YOUR_TOKEN> --server=https://<YOUR_OPENSHIFT_CLUSTER_URL>:6443
oc project mongoce
oc get svc
oc port-forward service/mas-mongo-ce-svc 27017:27017 -n mongoce
PASSWORD=`oc get secret mas-mongo-ce-admin-admin -n mongoce -o jsonpath='{.data.password}' | base64 --decode;`
mongosh "mongodb://localhost:27017" --username admin --password ${PASSWORD} --authenticationDatabase admin --tls --tlsAllowInvalidCertificates
```
<img width="1037" height="445" alt="image" src="https://github.com/user-attachments/assets/f943611c-09d9-4106-a8d4-43b053a79659" />

## commands:

* $ show dbs


<img width="346" height="199" alt="image" src="https://github.com/user-attachments/assets/3b711ad3-8c65-490e-b410-4cbd6b8803a9" />


* $ use mas_dev1_core


<img width="429" height="36" alt="image" src="https://github.com/user-attachments/assets/bc02ba4c-5e0c-4620-b7f3-190f26cb99e2" />


* $ show collections


<img width="463" height="188" alt="image" src="https://github.com/user-attachments/assets/242c5e08-c9ed-4df7-a32c-dc288ae1a70e" />

* $ db.OauthClient.find()
* 
