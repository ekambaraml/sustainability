#!/bin/bash
export NGINX_INSTANCE=nginix-maximo

# Create service.yaml

cat > service.yaml << EOF
apiVersion: v1
kind: Service
metadata:
  name: ${NGINX_INSTANCE}
  namespace: a-http-server
spec:
  selector:
    app: ${NGINX_INSTANCE}
  ports:
    - protocol: TCP
      port: 9443
      targetPort: 9443
EOF
