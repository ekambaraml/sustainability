#!/bin/bash
# Create Routes for Maximo core and manage

MAXIMO_ROUTES={
"admin.mastest.apps.mas-ml.cp.fyre.ibm.com"
"api.mastest.apps.mas-ml.cp.fyre.ibm.com"
"auth.mastest.apps.mas-ml.cp.fyre.ibm.com"
"home.mastest.apps.mas-ml.cp.fyre.ibm.com"
"maxinst.manage.mastest.apps.mas-ml.cp.fyre.ibm.com"
"testws-ui.manage.mastest.apps.mas-ml.cp.fyre.ibm.com"
"testws.home.mastest.apps.mas-ml.cp.fyre.ibm.com"
"testws.manage.mastest.apps.mas-ml.cp.fyre.ibm.com"
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
  
