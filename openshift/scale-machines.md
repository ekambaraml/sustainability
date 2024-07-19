# Scaling Worker nodes in existing OpenShift Cluster


## Clusters provisioned using UPI can be scaled using machineSet
https://docs.redhat.com/en/documentation/openshift_container_platform/4.14/html/machine_management/manually-scaling-machineset#machineset-manually-scaling_manually-scaling-machineset
```
oc get machinesets -n openshift-machine-api
```

```
oc get machine -n openshift-machine-api
```

### Delete machine
```
oc annotate machine/<machine_name> -n openshift-machine-api machine.openshift.io/delete-machine="true"
```
### Scale machines
```
oc scale --replicas=2 machineset <machineset> -n openshift-machine-api
```
or
```
oc edit machineset <machineset> -n openshift-machine-api
```
```yaml
apiVersion: machine.openshift.io/v1beta1
kind: MachineSet
metadata:
  name: <machineset>
  namespace: openshift-machine-api
spec:
  replicas: 2
  ```

### The compute machine set deletion policy
```yaml
spec:
  deletePolicy: <delete_policy>
  replicas: <desired_replica_count>
```

```
random, Newest, and Oldest are the three supported deletion options. The default is Random.
```
