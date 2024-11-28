# terraform-scale-k8s-on-gcp-monitoring
Terraform script outline to deploy a scalable web application using GKE with monitoring using Prometheus

1. Prometheus install from helm is issue currently same for grafana.
2. I have setup separately Prometheus and Grafana using port forword, container ip
3. sharing useful links for reference below

Grafana
a. https://grafana.com/docs/grafana/latest/datasources/prometheus/configure-prometheus-data-source/

b. https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/

c. https://grafana.com/docs/grafana/latest/administration/provisioning/


Prometheus
a. https://prometheus.io/docs/prometheus/latest/querying/basics/

b. [https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/#:~:text=To%20access%20the%20Prometheus%20dashboard,node%20IP's%20on%20port%2030000%20.)](https://devopscube.com/setup-prometheus-monitoring-on-kubernetes/#:~:text=To%20access%20the%20Prometheus%20dashboard,node%20IP's%20on%20port%2030000%20.)


Port forword
a. https://kubernetes.io/docs/reference/kubectl/generated/kubectl_port-forward/


