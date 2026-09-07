export NGINX_INSTANCE=nginx-maximo

# Create deployment.yaml

cat > deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${NGINX_INSTANCE}
  labels:
    app: ${NGINX_INSTANCE}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${NGINX_INSTANCE}
  template:
    metadata:
      labels:
        app: ${NGINX_INSTANCE}
    spec:
      containers:
        - name: nginx
          image: "image-registry.openshift-image-registry.svc:5000/a-http-server/${NGINX_INSTANCE}"
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
          tty: true
          stdin: true
          serviceAccount: default
      terminationGracePeriodSeconds: 5
EOF      
