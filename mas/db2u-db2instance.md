Create DB2 Instance using DB2U operator

https://www.ibm.com/docs/en/db2/11.5?topic=resource-deploying-db2-using-db2uinstance-custom


```
apiVersion: db2u.databases.ibm.com/v1
kind: Db2uInstance
metadata:
  name: db2-example
spec:
  account:
    privileged: true
  environment:
    authentication:
      ldap:
        enabled: false
    databases:
    - dbConfig:
        APPLHEAPSZ: "25600"
        LOGPRIMARY: "50"
        LOGSECOND: "35"
        STMTHEAP: 51200 AUTOMATIC
      name: BLUDB
      storage:
        - name: data
          type: template
          spec:
            accessModes:
              - ReadWriteOnce
            resources:
              requests:
                storage: 100Gi
            storageClassName: ocs-storagecluster-ceph-rbd
        - name: activelogs
          type: template
          spec:
            accessModes:
              - ReadWriteOnce
            resources:
              requests:
                storage: 10Gi
            storageClassName: ocs-storagecluster-ceph-rbd           
    dbType: db2oltp 
    instance:
      dbmConfig:
        DIAGLEVEL: "2"
      registry:
        DB2_4K_DEVICE_SUPPORT: "ON"
        DB2_ATS_ENABLE: "NO"
        DB2_DISPATCHER_PEEKTIMEOUT: "2"
        DB2_OBJECT_STORAGE_SETTINGS: "OFF"
    partitionConfig:
      dataOnMln0: true
      total: 1
      volumePerPartition: true
  license:
    accept: true
  nodes: 1
  podTemplate:
    db2u:
      resource:
        db2u:
          limits:
            cpu: 4
            memory: 16Gi
  storage:
  - name: meta
    spec:
      accessModes:
      - ReadWriteMany
      resources:
        requests:
          storage: 10Gi
      storageClassName: ocs-storagecluster-cephfs
    type: create
  - name: backup
    spec:
      accessModes:
      - ReadWriteMany
      resources:
        requests:
          storage: 10Gi
      storageClassName: ocs-storagecluster-cephfs
    type: create
  - name: archivelogs
    spec:
      accessModes:
      - ReadWriteMany
      resources:
        requests:
          storage: 100Gi
      storageClassName: ocs-storagecluster-cephfs
    type: create
  version: s11.5.9.0-cn2
```
