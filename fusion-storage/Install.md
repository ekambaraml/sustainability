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


# Install OpenShift Data Foundation


<img width="1564" alt="image" src="https://github.com/user-attachments/assets/bf173ccb-b3b1-4280-9b78-7f9cf0d31702">

```
# oc get pods,subs -n openshift-storage
NAME                                                  READY   STATUS    RESTARTS   AGE
pod/csi-addons-controller-manager-d9b47d8f7-9hgp9     2/2     Running   0          54s
pod/noobaa-operator-858b4df6b-2k78x                   2/2     Running   0          74s
pod/ocs-metrics-exporter-76649d74ff-vhchw             1/1     Running   0          53s
pod/ocs-operator-67c8cb844f-j8qjd                     1/1     Running   0          54s
pod/odf-console-7b4698b9f8-8zkz7                      1/1     Running   0          82s
pod/odf-operator-controller-manager-74d84f574-vk2xt   2/2     Running   0          82s
pod/rook-ceph-operator-57688f7d57-8zzrf               1/1     Running   0          42s
pod/ux-backend-server-6494646d87-9rb8t                2/2     Running   0          53s

NAME                                                                                                           PACKAGE                   SOURCE             CHANNEL
subscription.operators.coreos.com/mcg-operator-stable-4.14-redhat-operators-openshift-marketplace              mcg-operator              redhat-operators   stable-4.14
subscription.operators.coreos.com/ocs-operator-stable-4.14-redhat-operators-openshift-marketplace              ocs-operator              redhat-operators   stable-4.14
subscription.operators.coreos.com/odf-csi-addons-operator-stable-4.14-redhat-operators-openshift-marketplace   odf-csi-addons-operator   redhat-operators   stable-4.14
subscription.operators.coreos.com/odf-operator                                                                 odf-operator              redhat-operators   stable-4.14
```

## Install Local storage


<img width="1564" alt="image" src="https://github.com/user-attachments/assets/33f32a77-5291-469d-b13b-1119b7f80f6d">

<img width="1564" alt="image" src="https://github.com/user-attachments/assets/f5544bc8-d87e-4261-9275-451ba6aab514">

<img width="1564" alt="image" src="https://github.com/user-attachments/assets/f0e25d97-6cab-409f-907c-bd80e94f6dd7">
```
oc get pods,subs -n openshift-local-storage
NAME                                          READY   STATUS    RESTARTS   AGE
pod/diskmaker-manager-26f92                   2/2     Running   0          26s
pod/diskmaker-manager-7s94t                   2/2     Running   0          26s
pod/diskmaker-manager-8k8c2                   2/2     Running   0          26s
pod/diskmaker-manager-ft7s2                   2/2     Running   0          26s
pod/diskmaker-manager-hm78d                   2/2     Running   0          26s
pod/diskmaker-manager-hsjnp                   2/2     Running   0          26s
pod/diskmaker-manager-l5vwq                   2/2     Running   0          26s
pod/diskmaker-manager-m8c8z                   2/2     Running   0          26s
pod/diskmaker-manager-qpxtk                   2/2     Running   0          26s
pod/diskmaker-manager-rx2bw                   2/2     Running   0          26s
pod/diskmaker-manager-sl8h6                   2/2     Running   0          26s
pod/diskmaker-manager-t956b                   2/2     Running   0          26s
pod/diskmaker-manager-ttbwg                   2/2     Running   0          26s
pod/local-storage-operator-669bb5bcf4-jl8bk   1/1     Running   0          3m47s

NAME                                                       PACKAGE                  SOURCE             CHANNEL
subscription.operators.coreos.com/local-storage-operator   local-storage-operator   redhat-operators   stable
```

<img width="1858" alt="image" src="https://github.com/user-attachments/assets/e0f15fbd-4851-44d5-910c-b1e6e2420a44">
