# IBM Fustion Storage Installation using local disk


## 1. Requirements


## 2. Pre-requisites

* Create IBM operator catalog

```
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: ibm-operator-catalog
  namespace: openshift-marketplace
spec:
  displayName: IBM Operator Catalog
  publisher: IBM
  sourceType: grpc
  image: icr.io/cpopen/ibm-operator-catalog:latest
  updateStrategy:
    registryPoll:
      interval: 45m
```

Check Status 
```
oc get CatalogSources, pods -n openshift-marketplace
```

## 3. Deployments

![image](https://github.com/ekambaraml/sustainability/assets/26153008/9aedb595-9fc0-4ef6-8d1d-edbca765a685)


Install IBM Storage Fusion via Catalog
![image](https://github.com/ekambaraml/sustainability/assets/26153008/d1aec1e2-8716-4d10-afe6-74d2b49fd04b)


![image](https://github.com/ekambaraml/sustainability/assets/26153008/a6d8c3e4-c325-44d4-b4bd-bcf7e549eb7a)

![image](https://github.com/ekambaraml/sustainability/assets/26153008/4f88d7f9-06e3-4c2d-978b-fadb5d805a98)

![image](https://github.com/ekambaraml/sustainability/assets/26153008/a04159b9-37bb-4e82-ac24-03ad94dd2a2b)

![image](https://github.com/ekambaraml/sustainability/assets/26153008/a052f722-e1c3-4b10-8eb5-85348bae0f3d)

Create Spectrum Fusion Cluster

![image](https://github.com/ekambaraml/sustainability/assets/26153008/0b944d04-bd89-4989-a21b-962ffa54fef1)

Local Storage
![image](https://github.com/ekambaraml/sustainability/assets/26153008/cdb4dc38-6278-4f61-91fc-3d435571e0e9)

![image](https://github.com/ekambaraml/sustainability/assets/26153008/a2d71954-f461-40e9-a70a-e78b2ba4c15a)


## 4. Validation



