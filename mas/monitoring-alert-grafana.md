# Monitoring and Alerting with Grafana
https://www.ibm.com/docs/en/maximo-manage/continuous-delivery?topic=dashboards-configuring-red-hat-openshift-monitoring-service

To configure the monitoring dashboard, complete the following tasks:

* [ ] Configure a Red Hat® OpenShift® monitoring service.
* [ ] Configure the PodMonitor custom resource for the Maximo Manage application to monitor pods.
* [ ] Verify IBM® Maximo Monitor data.
* [ ] Configure Grafana.
* [ ] Load the Maximo Manage dashboards into Grafana.


## 1. Configuring OpenShift Monitoring service

#### 1.1 Cluster monitoring Config Map

* enableUserWorkload parameter is false, set the parameter to true
* Increase the Prometheus retention policy, add storage class ocs-storagecluster-cephfs, and specify the size.
The default retention policy is 24 hours.
* Increase the Prometheus retention policy, add storage class ocs-storagecluster-cephfs, and specify the size.
The default retention policy is 24 hours.

```
oc describe configmap cluster-monitoring-config -n openshift-monitoring

oc get cm cluster-monitoring-config  -n openshift-monitoring
```
```yaml
cat <<EOF |oc apply -f -
kind: ConfigMap
apiVersion: v1
metadata:
  name: cluster-monitoring-config
  namespace: openshift-monitoring
data:
  config.yaml: |
    enableUserWorkload: true
    prometheusK8s:
      retention: 90d
      volumeClaimTemplate:
        spec:
        storageClassName: ocs-storagecluster-cephfs
        resources:
            requests:
            storage: 300Gi
    alertmanagerMain:
    volumeClaimTemplate:
        spec:
        storageClassName: ocs-storagecluster-cephfs
        resources:
            requests:
            storage: 20Gi
EOF
```

Verify
```
oc describe configmap cluster-monitoring-config -n openshift-monitoring
oc get pods -n openshift-monitoring
```


#### 1.2 User Workload monitoring
```
oc get cm user-workload-monitoring-config  -n openshift-user-workload-monitoring

```


user-workload-monitoring-config.yml
```yaml
cat <<EOF |oc apply -f -

apiVersion: v1
kind: ConfigMap
data:
  config.yaml: |
    prometheus:
      logLevel: info
      enforcedSampleLimit: 50000
      retention: 90d
      volumeClaimTemplate:
        spec:
        storageClassName: ocs-storagecluster-cephfs
        resources:
            requests:
            storage: 300Gi
    alertmanagerMain:
    volumeClaimTemplate:
        spec:
        storageClassName: ocs-storagecluster-cephfs
        resources:
            requests:
            storage: 20Gi
metadata:
  name: user-workload-monitoring-config
  namespace: openshift-user-workload-monitoring

EOF
```

Verify
```
oc describe cm user-workload-monitoring-config  -n openshift-user-workload-monitoring
oc get pods -n openshift-user-workload-monitoring
```
All changes are reflected and pods are all up.

## 2 Configure PodMonitor for Maximo Manage 
In the Red Hat® OpenShift® Container Platform console, configure the PodMonitor custom resource to monitor the pods for Maximo® Manage.

Create the pod monitors to monitor the server-level serverBundle pod and instance-level monitorAgent pod.

#### 2.1 server level monitor agent

```yaml
cat <<EOF |oc apply -f -

apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
    labels:
        k8s-app: maximo-monitoragent
    name: maximo-serverlevel-monitoragent
    namespace: mas-dev-manage
spec:
    podMetricsEndpoints:
        - interval: 30s
          scheme: https
          targetPort: 9444
          tlsConfig:
            insecureSkipVerify: true  
    selector: 
      matchLabels:
        mas.ibm.com/appType: serverBundle

EOF
```

#### 2.2 Instance level monitor agent

```yaml
cat <<EOF |oc apply -f -
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
    labels:
        k8s-app: maximo-monitoragent
    name: maximo-instancelevel-monitoragent
    namespace: mas-dev-manage
spec:
    podMetricsEndpoints:
         - interval: 30s
           scheme: https
           targetPort: 9444
           tlsConfig:
             insecureSkipVerify: true  
    selector:
       matchLabels:
        mas.ibm.com/appType: monitorAgent


EOF
```

#### 2.3 Verify the monitor data
- Log in to the Red Hat OpenShift Container Platform console and select your Maximo® Manage cluster.
- Select Observe > Metrics.
- Type mas_manage_mbo_total.

<img width="1913" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/fb1b121b-854f-47af-a00f-d1437dd661a8">
