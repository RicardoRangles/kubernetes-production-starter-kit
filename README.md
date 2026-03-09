# Kubernetes Production Starter Kit

Production-ready Kubernetes baseline for monitoring, networking and operational best practices.

This project provides a **clean and practical starting point for running Kubernetes clusters in production environments**, including monitoring, dashboards and ingress configuration.

The goal is simple: **bootstrap a production-ready observability stack quickly and consistently**.

---

# Features

• Prometheus monitoring stack
• Grafana dashboards for Kubernetes clusters
• Alertmanager integration
• Persistent storage for monitoring components
• NGINX ingress configuration
• Production-oriented resource limits
• Automated installation script
• Modular and extensible repository structure

---

# Architecture

Monitoring stack based on:

* Prometheus
* Grafana
* Alertmanager
* Node Exporter
* kube-state-metrics

All deployed using Helm and the kube-prometheus-stack chart.

---

# Project Structure

```
kubernetes-production-starter-kit
│
├── configs
│   └── kube-prometheus-stack-values.yaml
│
├── monitoring
│   └── grafana
│       └── dashboards
│           ├── cluster-health.json
│           ├── control-plane.json
│           ├── etcd-cluster.json
│           ├── nodes-metrics.json
│           └── pods-overview.json
│
├── networking
│   └── monitoring-ingress.yaml
│
├── scripts
│   └── install-monitoring.sh
│
├── docs
│
└── README.md
```

---

# Requirements

Before using this starter kit you should have:

* A running Kubernetes cluster
* kubectl configured
* NGINX Ingress Controller installed
* Helm installed

---

# Monitoring Installation

The monitoring stack is installed using Helm and the kube-prometheus-stack chart.

Add Helm repository:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

Install monitoring stack:

```bash
helm install monitoring prometheus-community/kube-prometheus-stack \
-n monitoring \
--create-namespace \
-f configs/kube-prometheus-stack-values.yaml
```

This will deploy:

* Prometheus
* Grafana
* Alertmanager
* node-exporter
* kube-state-metrics

---

# Quick Installation

Monitoring stack can be installed automatically using the provided script.

```bash
./scripts/install-monitoring.sh
```

This script will:

* Add Helm repositories
* Create the monitoring namespace
* Install kube-prometheus-stack
* Deploy Prometheus, Grafana and Alertmanager
* Apply the monitoring ingress configuration

---

# Grafana Dashboards

Pre-built dashboards for Kubernetes monitoring are included.

Location:

```
monitoring/grafana/dashboards/
```

Dashboards included:

* Cluster Health
* Control Plane Metrics
* ETCD Monitoring
* Node Metrics
* Pod Resource Usage

These dashboards can be imported directly into Grafana.

---

# Ingress Configuration

Monitoring services can be exposed through NGINX Ingress.

Example domains:

```
grafana.k8s.local
prometheus.k8s.local
alertmanager.k8s.local
```

Ingress configuration:

```
networking/monitoring-ingress.yaml
```

Apply ingress configuration:

```bash
kubectl apply -f networking/monitoring-ingress.yaml
```

---

# Customization

This project is designed to be **environment-agnostic**.

Users should adapt:

* storage classes
* domains
* TLS configuration
* resource limits
* ingress configuration

according to their infrastructure.

---

# Roadmap

Upcoming modules planned for the starter kit:

* Kubernetes security baseline
* Network policies
* TLS automation with cert-manager
* ETCD backup strategy
* CI/CD templates
* Kubernetes operational runbooks

---

# License

MIT License

---

# Author

Kubernetes infrastructure and operations starter kit designed for production environments.
