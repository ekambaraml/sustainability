# Monitoring and Alerting with Grafana
https://www.ibm.com/docs/en/maximo-manage/continuous-delivery?topic=dashboards-configuring-red-hat-openshift-monitoring-service

To configure the monitoring dashboard, complete the following tasks:

* [ ] Configure a Red Hat® OpenShift® monitoring service.
* [ ] Configure the PodMonitor custom resource for the Maximo Manage application to monitor pods.
* [ ] Verify IBM® Maximo Monitor data.
* [ ] Configure Grafana.
* [ ] Load the Maximo Manage dashboards into Grafana.


## 1.0 Configuring OpenShift Monitoring service

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

#### 1.3 Server Bundles

```yaml
cat <<EOF |oc apply -f -
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  labels:
    k8s-app: maximo-monitoragent
  name: maximo-monitoragent
  namespace: mas-dev-manage
spec:
  podMetricsEndpoints:
    - interval: 30s
      scheme: http
      targetPort: 9081
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


## 2.0 Configure PodMonitor for Maximo Manage 
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


## 3.0 Configuring Grafana

```yaml
cat <<EOF |oc apply -f -

apiVersion: integreatly.org/v1alpha1
kind: Grafana
metadata:
  name: mas-grafana
  namespace: grafana
spec:
  ingress:
    enabled: true
  dataStorage:
    accessModes:
      - ReadWriteOnce
    size: 10Gi
    class: ocs-storagecluster-cephfs
  config:
    log:
      mode: "console"
      level: "warn"
    security:
      admin_user: "root"
      admin_password: "secret"
    auth:
      disable_login_form: False
      disable_signout_menu: True
    auth.anonymous:
      enabled: True
  dashboardLabelSelector:
    - matchExpressions:
        - {key: app, operator: In, values: [grafana]}

EOF
```

#### 3.2 Service account

```
oc project grafana
oc adm policy add-cluster-role-to-user cluster-monitoring-view -z grafana-serviceaccount
oc serviceaccounts get-token grafana-serviceaccount -n openshift-user-workload-monitoring
```

#### 3.3 Create GrafanaDataSource data source - prometheous
```yaml
cat <<EOF |oc apply -f -

apiVersion: integreatly.org/v1alpha1
kind: GrafanaDataSource
metadata:
  name: prometheus-grafanadatasource
  namespace:  grafana
spec:
  datasources:
    - access: proxy
      editable: true
      isDefault: true
      jsonData:
        httpHeaderName1: 'Authorization'
        timeInterval: 5s
        tlsSkipVerify: true
      name: Prometheus
      secureJsonData:
        httpHeaderValue1: 'Bearer ${BEARER_TOKEN}'
      type: prometheus
      url: 'https://thanos-querier.openshift-monitoring.svc.cluster.local:9091'
  name: prometheus-grafanadatasource.yaml

EOF
```

## 4.0 Load maximo manage dashboard into Grafana

#### 4.1 Download the latest mas manage dashboard from the pod
```
oc project mas-dev-manage

oc get pods -n mas-dev-manage | grep ws
dev-entitymgr-ws-7859f96b94-vn8r7                        1/1     Running     0          12h

# Copy the latest mas manage dashboard from the manage workspace container
mkdir dashboard
oc rsync dev-entitymgr-ws-7859f96b94-vn8r7:/opt/ansible/roles/manage-deployment/files/maximo-dashboard.json dashboard
```
#### 4.2 Import the dashboard json to grafana

![image](https://github.com/ekambaraml/sustainability/assets/26153008/53c1c3a4-f0c4-4c1f-82c3-0def38595a2c)

## 5.0 Alerts and SMTP server setup

#### 5.1 Configure Grafana with SMTP server for email alert notification

```
oc project grafana
oc get grafana -o yaml > grafana.yaml
```

update the grafana.yaml with your smtp details. Sample format is listed below
```
      smtp:
        enabled: true
        from_address: ekambara@us.ibm.com
        from_name: Grafana
        host: smtp.gmail.com:587
        password: smtp-password
        skip_verify: true
        user: test-user@gmail.com
```
![image](https://github.com/ekambaraml/sustainability/assets/26153008/e8b48e7f-a713-4373-a29e-42a5d9fa26c5)


save and apply the changes
```
oc apply -f grafana.yaml
```
wait for the grafana pods to be restarted.
```
oc get pods
```

#### 5.2 Create Notification Channels

* [ ] Notification channels are used to define the recivers for the email alerts. 
* [ ] You can define multiple channels.
* [ ] You can chose the channel to send alerts, Depends on the type of alert.


In Grafana dashboard, Select Alerting -> Notification channel to configuring notification.

<img width="301" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/3898602b-576e-4205-82d6-16e0b3c99cac">


Then update the channel with Notification heading and email addresses to send the altert notifications.
<img width="1105" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/2781ac68-3c18-40be-b05c-28b620901dbc">


#### 5.3 How to Create alert rules and validate email alerts

![image](https://github.com/ekambaraml/sustainability/assets/26153008/57aa85d2-e92e-4de0-a09e-86ee61e8b672)


#### 5.4 Alerts (Grafana-managed alert rule)
Grafana managed alerts support multi-dimensional alerting. Each alert rule can create multiple alert instances. This is exceptionally powerful if you are observing multiple series in a single expression.


#### 5.4.1 OpenShift Alerts
https://github.com/openshift/runbooks/tree/master/alerts/cluster-monitoring-operator

Alert             | Description                                               | Rules
------------------|-----------------------------------------------------------|-------
system_down       | Openshift node down alert                                 |
cpu_memory_high   | High memory/cpu utilization alert                         |
KubeletDown       | Kubelet has disappeared from Prometheus target discovery. | absent(up{job="kubelet",metrics_path="/metrics"} == 1)
HAProxyDown       | This alert fires when metrics report that HAProxy is down.| haproxy_up == 0
NodeFilesystemAlmostOutOfSpace | Filesystem has less than 3% space left. | (node_filesystem_avail_bytes{fstype!="",job="node-exporter"} / node_filesystem_size_bytes{fstype!="",job="node-exporter"} * 100 < 3 and node_filesystem_readonly{fstype!="",job="node-exporter"} == 0) KubePersistentVolumeFillingUp | The PersistentVolume claimed by {{ $labels.persistentvolumeclaim }} in Namespace {{ $labels.namespace }} is only {{ $value | humanizePercentage }} free. (kubelet_volume_stats_available_bytes{job="kubelet",metrics_path="/metrics",namespace=~"(openshift-.*|kube-.*|default)"} / kubelet_volume_stats_capacity_bytes{job="kubelet",metrics_path="/metrics",namespace=~"(openshift-.*|kube-.*|default)"}) < 0.03 and kubelet_volume_stats_used_bytes{job="kubelet",metrics_path="/metrics",namespace=~"(openshift-.*|kube-.*|default)"} > 0 unless on(namespace, persistentvolumeclaim) kube_persistentvolumeclaim_access_mode{access_mode="ReadOnlyMany",namespace=~"(openshift-.*|kube-.*|default)"} == 1 unless on(namespace, persistentvolumeclaim) kube_persistentvolumeclaim_labels{label_alerts_k8s_io_kube_persistent_volume_filling_up="disabled",namespace=~"(openshift-.*|kube-.*|default)"} == 1


#### 5.4.2 MAS Manage Alerts

Metrics in Maximo® Manage https://www.ibm.com/docs/en/maximo-manage/continuous-delivery?topic=monitoring-querying-metrics


Alert             | Description                          | Rules
------------------|--------------------------------------|-------
mas_down          | when one of more ocp nodes are down  |
Manage_down       | Manage application pods down         |
User_acess        | User access pod is down              |
DB Connection


## 6.0 AlertManager for sending prometheus alerts

on the OpenShift Admin Console

Administration -> Cluster Settings -> Configurations -> AlertManager -> Create Receiver
![image](https://github.com/ekambaraml/sustainability/assets/26153008/5cc39a74-2372-43c9-802a-198b9350e923)


* Receiver Configuration

![image](https://github.com/ekambaraml/sustainability/assets/26153008/a20f3a8e-2939-4949-97c5-7d73baf00426)

* Example of Critical Alerts:

Routing labels
```
severity = critical
```
<img width="1275" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/4db0960d-f6f3-4315-9965-589b5b9e1546">


## 6.1 Enabling alert routing for user-defined projects
```
oc -n openshift-monitoring edit configmap cluster-monitoring-config
```

```
data:
  config.yaml: |
    enableUserWorkload: true
    alertmanagerMain:
      enableUserAlertmanagerConfig: true
```
<img width="414" alt="image" src="https://github.com/ekambaraml/sustainability/assets/26153008/ca124587-546b-4d29-bde5-83917474c98b">

