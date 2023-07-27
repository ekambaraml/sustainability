# Deploying DB2 server on a standalone RHEL server.


## Requirements


## RHEL server setup

* 1. Required Linux package
     user: root
```
# Linux package
yum install gcc ksh mksh libaio* binutil* zlib* perl-Sys-Syslog -y
yum install libstdc++.i686 pam-devel.i686 -y
```

* 2. Disable Security-enhanced Linux

     user: root
     
     Set it in permissive mode and run the setenforce 0 command as a superuser to temporarily disable SELinux.
     
     ```
     setenforce 0
     vi  /etc/sysconfig/selinux

     reboot
     ```
     
## Install DB2 pre-requisits

## Install DB2 servers

## Validates

##
