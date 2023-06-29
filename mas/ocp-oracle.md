# Running Oracle DB on OpenShift cluster

## Environment variables:
```
export ORACLE_NAMESPACE=oracledb
export ORACLE_SID
export ORACLE_PDB
export ORACLE_DATA_SIZE
export ORACLE_STORAGECLASS
export ORACLE_ADMINPASSWORD
export ORACLE_REGISTRY_CONFIG
```

## YAML file to create Oracle instance
```
---
kind: Namespace
apiVersion: v1
metadata:
  name: {{ORACLE_NAMESPACE}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: oracle-settings
  namespace: {{ORACLE_NAMESPACE}}
data:
  oracle.sid: {{ORACLE_SID}}
  oracle.pdb : {{ORACLE_PDB}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: oracle-data-pvc
  namespace: {{ORACLE_NAMESPACE}}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: {{ORACLE_DATA_SIZE}}
  storageClassName: {{ORACLE_STORAGECLASS}}
  volumeMode: Filesystem
---
kind: Secret
apiVersion: v1
metadata:
  name: oracle-admin-password
  namespace: {{ORACLE_NAMESPACE}}
data:
  password: {{ORACLE_ADMINPASSWORD}}
type: Opaque
---
kind: Secret
apiVersion: v1
metadata:
  name: oracle-pull-secret
  namespace: {{ORACLE_NAMESPACE}}
data:
  .dockerconfigjson: >-
    {{ORACLE_REGISTRY_CONFIG}}
type: kubernetes.io/dockerconfigjson
---
kind: ServiceAccount
apiVersion: v1
metadata:
  name: oracle-sa
  namespace: {{ORACLE_NAMESPACE}}
imagePullSecrets:
  - name: oracle-pull-secret
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: 'system:openshift:scc:anyuid'
  namespace: {{ORACLE_NAMESPACE}}
subjects:
  - kind: ServiceAccount
    name: oracle-sa
    namespace: {{ORACLE_NAMESPACE}}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: 'system:openshift:scc:anyuid'
---
kind: Deployment
apiVersion: apps/v1
metadata:
  labels:
    app: oracle-db-app
    app.kubernetes.io/component: oracle
    app.kubernetes.io/instance: oracle-db-app
    app.openshift.io/runtime-namespace: {{NAMESPACE}}
  name: oracle
  namespace: {{ORACLE_NAMESPACE}}
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: oracle-db-app
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: oracle-db-app
        deploymentconfig: oracle
    spec:
      containers:
      - name: oracle
        env:
        - name: ORACLE_SID
          valueFrom:
            configMapKeyRef:
              name: oracle-settings
              key: oracle.sid
        - name: ORACLE_PDB
          valueFrom:
            configMapKeyRef:
              name: oracle-settings
              key: oracle.pdb
        - name: ORACLE_PWD
          valueFrom:
            secretKeyRef:
              key: password
              name: oracle-admin-password
        image: container-registry.oracle.com/database/enterprise:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 1521
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /opt/oracle/oradata
          name: oracle-data-pvc
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      serviceAccountName: oracle-sa
      volumes:
      - name: oracle-data-pvc
        persistentVolumeClaim:
          claimName: oracle-data-pvc-db
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app: oracle-db-app
    app.kubernetes.io/component: oracle
    app.kubernetes.io/instance: oracle-db-app
    app.kubernetes.io/name: oracle
  name: oracle-db-app
  namespace: {{ORACLE_NAMESPACE}}
spec:
  ports:
  - name: 1521-tcp
    port: 1521
    protocol: TCP
    targetPort: 1521
  selector:
    app: oracle-db-app
    deploymentconfig: oracle
  type: ClusterIP​
```
