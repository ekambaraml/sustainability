# 1.0 IBM Sterling 


Sizing factoring includes:
* Number of transactions processed.
* Amount of data being transferred.
* Whether you run Sterling B2B Integrator with or without perimeter servers.
* Whether your environment is clustered (multiple node) or non-clustered (single node).

### 1.1 Hardware Requirements

* Loadbalancer

Node | Count |CPU | Memory | Storage | Firewall Rules,Ports 
-----|-------|-----|--------|---------|---------------------
Bastion | 1 | 4 vcpu | 8 GB | 100 GB |
Master  | 3 | 4 vcpu | 16 GB | 200 GB |
Worker  | 3 | 8 vcpu | 32 FB | 300 GB |



## 2.0 Deploy OpenShift Cluster



## 3.0 PreRequirements
### 3.1 Deploy Persistent Volume storages
Sizing the storage should be reviewed and minimum required storage 

check the Storage classes deployed in the cluster

```
oc get sc

NAME                            PROVISIONER       RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
managed-nfs-storage (default)   nfs/provisioner   Delete          Immediate           false                  50m
```
<img width="1200" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/dd7426d2-9db7-470d-bda2-0c577fa52263">

### 3.2 Database Setup
* [ ] Sterling B2B Integrator tables have a minimum page size of 16K

* DB2 Database setup
https://www.ibm.com/docs/en/b2b-integrator/6.2.0?topic=database-configuring-db2

## 4.0 Deploying the SFT

### 4.1 Download the Sterling B2Bi Images/charts

### 4.2 Create Namespace for SFG Deployment

```
 oc new-project sfg-dev
```


### 4.3 Role based Access Control
* Namespace : sfg-dev
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

* Pod Security Admission
  
```
cat <<EOF |oc apply -f -
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: "ibm-b2bi-psp"
  labels:
    app: "ibm-b2bi-psp"
  
spec:
  privileged: false
  allowPrivilegeEscalation: false
  hostPID: false
  hostIPC: false
  hostNetwork: false
  allowedCapabilities:
  requiredDropCapabilities:
  - MKNOD
  - AUDIT_WRITE
  - KILL
  - NET_BIND_SERVICE
  - NET_RAW
  - FOWNER
  - FSETID
  - SYS_CHROOT
  - SETFCAP
  - SETPCAP
  - CHOWN
  - SETGID
  - SETUID
  - DAC_OVERRIDE
  allowedHostPaths:
  runAsUser:
    rule: MustRunAsNonRoot
  runAsGroup:
    rule: MustRunAs
    ranges:
    - min: 1
      max: 4294967294
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: MustRunAs
    ranges:
    - min: 1
      max: 4294967294
  fsGroup:
    rule: MustRunAs  
    ranges:
    - min: 1
      max: 4294967294
  volumes:
  - configMap
  - emptyDir
  - projected
  - secret
  - downwardAPI
  - persistentVolumeClaim
  - nfs
  forbiddenSysctls:
  - '*'
EOF
```

* Custom Role for the custom PodSecurityPolicy:
```
cat <<EOF |oc apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: "ibm-b2bi-psp"
  labels:
    app: "ibm-b2bi-psp"
rules:
- apiGroups:
  - policy
  resourceNames:
  - "ibm-b2bi-psp"
  resources:
  - podsecuritypolicies
  verbs:
  - use
EOF
```

* Custom Role binding for the custom PodSecurityPolicy:
```
export NAMESPACE=sfg-dev
cat <<EOF |oc apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: "ibm-b2bi-psp"
  labels:
    app: "ibm-b2bi-psp"
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: "ibm-b2bi-psp"
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:serviceaccounts
  namespace: {{ NAMESPACE }}
EOF
```
  
### 4.4 Helm value.yaml Generation

```
# Define all custom values
export PULLSECRET=imagepull-secret

# Generate the values, this is to prevent typo erros
cat > custom-values.yaml << EOF

EOF


#ls -l custom-values.yaml

```
