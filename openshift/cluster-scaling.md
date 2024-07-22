# Scaling cluster


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
