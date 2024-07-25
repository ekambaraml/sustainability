# How to taint or remove taint for a Node

Adding a taint to an existing OpenShift Container Platform - Node can be done with the below command

```
oc adm taint nodes node1 key1=value1:NoSchedule
```


To remove the taint added by the command above, run the command as shown below:

```
oc adm taint nodes node1 key1:NoSchedule-
```
