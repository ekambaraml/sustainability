# Scaling cluster


https://github.com/openshift/machine-api-operator/tree/22fb20012fdbb98eb00190402fc2177a3e1de85f

## MachineSets

https://docs.redhat.com/en/documentation/openshift_container_platform/4.14/html/machine_management/manually-scaling-machineset#prerequisites
https://docs.redhat.com/en/documentation/openshift_container_platform/4.14/html/machine_management/modifying-machineset#machineset-modifying_modifying-machineset


## UPI
https://docs.redhat.com/en/documentation/openshift_container_platform/4.14/html/machine_management/more-rhel-compute#more-rhel-compute-preparing-image-cloud

https://docs.redhat.com/en/documentation/openshift_container_platform/4.14/html/machine_management/managing-user-provisioned-infrastructure-manually#machine-vsphere-machines_adding-vsphere-compute-user-infra

Approve CSR
```
oc get csr -o name | xargs oc adm certificate approve
```


## Adding worker outside of MachineSet

https://www.redhat.com/en/blog/adding-nodes-outside-of-a-machineset-in-vsphere-ipi-clusters

https://docs.redhat.com/en/documentation/openshift_container_platform/4.11/html-single/machine_management/index#capi-machine-management


## Nutanix IPI

https://www.nutanix.dev/2022/08/16/red-hat-openshift-ipi-on-nutanix-cloud-platform/

https://portal.nutanix.com/page/documents/solutions/details?targetId=TN-2030-Red-Hat-OpenShift-on-Nutanix:TN-2030-Red-Hat-OpenShift-on-Nutanix

https://portal.nutanix.com/page/documents/solutions/details?targetId=NVD-2177-Cloud-Native-6-5-OpenShift:openshift-scalability.html
