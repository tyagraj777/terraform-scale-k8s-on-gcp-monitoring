provider "google" {
  project = "cool-agility-442507-c5"
  region  = "us-central1"
  zone    = "us-central1-a"
}

variable "region" {
  description = "The region for the GKE cluster"
  type        = string
  default     = "us-central1"
}

resource "google_container_cluster" "gke_cluster" {
  name               = "gke-web-cluster"
  location           = var.region
#  initial_node_count = 1

  node_pool {
    name       = "default-pool"
    node_count = 1

    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }

    node_config {
      machine_type = "e2-medium"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}

# Helm chart to deploy Prometheus and Grafana
provider "helm" {
  kubernetes {
    host                   = google_container_cluster.gke_cluster.endpoint
    client_certificate     = base64decode(google_container_cluster.gke_cluster.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.gke_cluster.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate)
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  chart      = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  namespace  = "monitoring"
  create_namespace = true
}

resource "helm_release" "grafana" {
  name       = "grafana"
  chart      = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"
  create_namespace = true

  set {
    name  = "adminPassword"
    value = "admin123" # Change this to a secure password
  }
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "grafana_dashboard" {
  value = "http://<EXTERNAL_IP>:3000" # Replace with a load balancer/service IP.
}
