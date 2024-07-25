#How to taint or remove taint for a Node

https://docs.openshift.com/container-platform/4.14/nodes/scheduling/nodes-scheduler-taints-tolerations.html


Adding a taint to an existing OpenShift Container Platform - Node can be done with the below command

```
oc adm taint nodes node1 key1=value1:NoSchedule
```


To remove the taint added by the command above, run the command as shown below:

```
oc adm taint nodes node1 key1:NoSchedule-
```



## Uninstall ODF
https://docs.redhat.com/en/documentation/red_hat_openshift_data_foundation/4.9/html/deploying_openshift_data_foundation_using_ibm_z_infrastructure/uninstalling_openshift_data_foundation#uninstalling_openshift_data_foundation
