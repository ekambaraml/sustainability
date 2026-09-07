#!/bin/bash
# Create Routes for Maximo core and manage

export SOURCE_CLUSTER_DOMAIN=ibmsmoc.cp.fyre.ibm.com
export SOURCE_MAXIMO_INSTANCE_WORKSPACE=dev


MAXIMO_ROUTES={
"admin.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"api.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"auth.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"maxinst.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"${SOURCE_MAXIMO_INSTANCE_WORKSPACE}-ui.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.home.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
"${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.manage.${SOURCE_MAXIMO_INSTANCE_WORKSPACE}.apps.${SOURCE_CLUSTER_DOMAIN}"
}

kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: ${MAXIMO_ROUTES}
  namespace: a-http-server
spec:
  host: ${MAXIMO_ROUTES}
  to:
    kind: Service
    name: nginx
    weight: 100
  port:
    targetPort: 9443
  tls:
    termination: passthrough
  wildcardPolicy: None
  
