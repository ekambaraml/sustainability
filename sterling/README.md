# IBM Sterling 


Sizing factoring includes:
* Number of transactions processed.
* Amount of data being transferred.
* Whether you run Sterling B2B Integrator with or without perimeter servers.
* Whether your environment is clustered (multiple node) or non-clustered (single node).



## Role based Access Control

kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: ibm-b2bi-role-<namespace>
  namespace: <namespace>
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
  name: ibm-b2bi-rolebinding-<namespace>
  namespace: <namespace>
subjects:
  - kind: ServiceAccount
    name: <service-account>
    namespace: <namespace>
roleRef:
  kind: Role
  name: ibm-b2bi-role-<namespace>
  apiGroup: rbac.authorization.k8s.io
