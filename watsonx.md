# Deploying WatsonX on-perm



## Configure OpenShift Cluster 


${CPDM_OC_LOGIN}

cpd-cli manage add-icr-cred-to-global-pull-secret \
--entitled_registry_key=${IBM_ENTITLEMENT_KEY}


Create new projects

```yaml
${OC_LOGIN}

oc new-project ${PROJECT_CERT_MANAGER}
oc new-project ${PROJECT_LICENSE_SERVICE}
oc new-project ${PROJECT_CPD_INST_OPERATORS} 
oc new-project ${PROJECT_CPD_INST_OPERANDS}
```


Install cert manager and license manager
```yaml
cpd-cli manage apply-cluster-components --release=${VERSION} \
 --license_acceptance=true --cert_manager_ns=${PROJECT_CERT_MANAGER} \
 --licensing_ns=${PROJECT_LICENSE_SERVICE}
```

Setup required permissions for namespaces and service accounts
```yaml
cpd-cli manage authorize-instance-topology \
--cpd_operator_ns=${PROJECT_CPD_INST_OPERATORS} \
--cpd_instance_ns=${PROJECT_CPD_INST_OPERANDS}
```

Authorize admin user:

```yaml
export INSTANCE_ADMIN=admin

oc adm policy add-role-to-user admin ${INSTANCE_ADMIN} \
--namespace=${PROJECT_CPD_INST_OPERATORS} \
--rolebinding-name="cpd-instance-admin-rbac"

oc adm policy add-role-to-user admin ${INSTANCE_ADMIN} \
--namespace=${PROJECT_CPD_INST_OPERANDS} \
--rolebinding-name="cpd-instance-admin-rbac"

oc adm policy add-role-to-user admin ${INSTANCE_ADMIN} \
--namespace=${PROJECT_CPD_INSTANCE_TETHERED} \
--rolebinding-name="cpd-instance-admin-rbac"
```

Apply OLM Role

```yaml
oc apply -f - << EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: cpd-instance-admin-apply-olm
  namespace: ${PROJECT_CPD_INST_OPERATORS}
rules:
- apiGroups:
  - operators.coreos.com
  resources:
  - catalogsources
  - operatorgroups
  - subscriptions
  - clusterserviceversions
  - installplans
  verbs:
  - create
  - update
  - patch
  - get
  - list
EOF



oc adm policy add-role-to-user cpd-instance-admin-apply-olm ${INSTANCE_ADMIN} \
--namespace=${PROJECT_CPD_INST_OPERATORS} \
--role-namespace=${PROJECT_CPD_INST_OPERATORS} \
--rolebinding-name="cpd-instance-admin-apply-olm-rbac"
```

## Install IBM Cloud Pak Foundational services

```yaml
cpd-cli manage setup-instance-topology \
--release=${VERSION} \
--cpd_operator_ns=${PROJECT_CPD_INST_OPERATORS} \
--cpd_instance_ns=${PROJECT_CPD_INST_OPERANDS} \
--license_acceptance=true \
--block_storage_class=${STG_CLASS_BLOCK}
```

## Install Cloud Pak for Data platform (cpd_platform) component

```yaml
cpd-cli manage get-license \
--release=${VERSION} \
--license-type=EE

cpd-cli manage apply-olm \
--release=${VERSION} \
--cpd_operator_ns=${PROJECT_CPD_INST_OPERATORS} \
--components=cpd_platform

cpd-cli manage apply-cr \
--release=${VERSION} \
--cpd_instance_ns=${PROJECT_CPD_INST_OPERANDS} \
--components=cpd_platform \
--block_storage_class=${STG_CLASS_BLOCK} \
--file_storage_class=${STG_CLASS_FILE} \
--license_acceptance=true
```

After apply-cr step is completed successfully, you can run cr-status command to make sure all requested components have been installed successfully
```yaml
cpd-cli manage get-cr-status --cpd_instance_ns=${PROJECT_CPD_INST_OPERANDS}
```

## Install WatsonX


