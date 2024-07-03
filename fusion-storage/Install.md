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

## 4. Validation



