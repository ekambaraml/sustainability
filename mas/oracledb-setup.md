# Setup OracleDB for MAS Manage



## Download Oracle container Image
```
podman login -u <user> -p <password> container-registry.oracle.com
podman pull container-registry.oracle.com/database/enterprise:latest
docker run --rm --detach --name mas-db --shm-size=1g  -p 1521:1521 -p 8080:8080  -p 5500:5500  -v /data/oracle:/opt/oracle/oradata container-registry.oracle.com/database/enterprise:latest

root@cxdb-01-cxdb-001 ~]# docker run --rm --detach --name mas-db --shm-size=1g  -p 1521:1521 -p 8080:8080  -p 5500:5500  -v /data/oracle:/opt/oracle/oradata container-registry.oracle.com/database/enterprise:latest
7fcbeee2090a27f7a8814b5bb3a4608549587b3576399c4dbc6c46cc66113f24


[root@cxdb-01-cxdb-001 ~]# podman logs mas-db
[2023:06:28 19:52:00]: Acquiring lock .ORCLCDB.create_lck with heartbeat 30 secs
[2023:06:28 19:52:00]: Lock acquired
[2023:06:28 19:52:00]: Starting heartbeat
[2023:06:28 19:52:00]: Lock held .ORCLCDB.create_lck
ORACLE EDITION: ENTERPRISE

LSNRCTL for Linux: Version 21.0.0.0.0 - Production on 28-JUN-2023 19:52:00

Copyright (c) 1991, 2021, Oracle.  All rights reserved.

Starting /opt/oracle/product/21c/dbhome_1/bin/tnslsnr: please wait...

TNSLSNR for Linux: Version 21.0.0.0.0 - Production
System parameter file is /opt/oracle/homes/OraDB21Home1/network/admin/listener.ora
Log messages written to /opt/oracle/diag/tnslsnr/7fcbeee2090a/listener/alert/log.xml
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))

Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=IPC)(KEY=EXTPROC1)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 21.0.0.0.0 - Production
Start Date                28-JUN-2023 19:52:00
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /opt/oracle/homes/OraDB21Home1/network/admin/listener.ora
Listener Log File         /opt/oracle/diag/tnslsnr/7fcbeee2090a/listener/alert/log.xml
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=0.0.0.0)(PORT=1521)))
The listener supports no services
The command completed successfully
Prepare for db operation
8% complete
Copying database files

```


## Add user

```
show con_name
alter session set container=orclpdb1;
CREATE USER masadmin IDENTIFIED BY password;
GRANT CONNECT, RESOURCE, DBA TO masadmin ;
GRANT CONNECT TO masadmin ;
grant sysdba to masadmin ;
```

## Connection
```
Host: <ip>
Database: ORCLPDB1
username: masadmin
password: password
type: ServiceName
```
