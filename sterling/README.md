# IBM Sterling 


Sizing factoring includes:
* Number of transactions processed.
* Amount of data being transferred.
* Whether you run Sterling B2B Integrator with or without perimeter servers.
* Whether your environment is clustered (multiple node) or non-clustered (single node).


## Deploy OpenShift Cluster

## Deploy Persistent Volume storages
check the Storage classes deployed in the cluster

```
oc get sc

NAME                            PROVISIONER       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
managed-nfs-storage (default)   nfs/provisioner   Delete          Immediate           false                  50m
```
<img width="1200" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/dd7426d2-9db7-470d-bda2-0c577fa52263">

## Create Namespace for SFG Deployment

```
 oc new-project sfg-dev
```


## Role based Access Control
## Namespace : sfg-dev
```
cat <<EOF |oc apply -f -
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ibm-b2bi-role-sfg-dev
  namespace: sfg-dev
rules:
  - apiGroups: ['route.openshift.io']
    resources: ['routes','routes/custom-host']
    verbs: ['get', 'watch', 'list', 'patch', 'update']
  - apiGroups: ['','batch']
    resources: ['secrets','configmaps','persistentvolumes','persistentvolumeclaims','pods','services','cronjobs','jobs']
    verbs: ['create', 'get', 'list', 'delete', 'patch', 'update']
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ibm-b2bi-rolebinding-sfg-dev
  namespace:sfg-dev
subjects:
  - kind: ServiceAccount
    name: sfg-dev-sa
    namespace: sfg-dev
roleRef:
  kind: Role
  name: ibm-b2bi-role-sfg-dev
  apiGroup: rbac.authorization.k8s.io
EOF
```
