# Kubernetes Production Starter Kit

Production-ready Kubernetes baseline for monitoring, networking and operations.

This project provides a **ready-to-use foundation** for running Kubernetes clusters with essential production components such as monitoring, dashboards, ingress configuration and operational best practices.

The goal is simple: **save hours of setup and provide a clean, production-oriented starting point**.

---

# Features

• Prometheus monitoring stack
• Grafana dashboards for Kubernetes clusters
• Alertmanager configuration
• Persistent storage for monitoring components
• NGINX Ingress configuration
• Production-oriented resource limits
• Modular folder structure for easy customization

---

# Architecture Overview

Monitoring stack included:

* Prometheus
* Grafana
* Alertmanager

Dashboards included:

* Cluster Health
* Control Plane Metrics
* ETCD Monitoring
* Node Metrics
* Pod Resource Usage

These dashboards provide visibility into **cluster health, workloads and infrastructure metrics**.

---

# Project Structure

```
kubernetes-production-starter-kit
│
├── configs
│   ├── prometheus-values.yaml
│   └── grafana-values.yaml
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
└── docs
```

---

# Requirements

Before using this starter kit you should have:

* A running Kubernetes cluster
* kubectl configured
* NGINX Ingress Controller installed
* Prometheus stack installed
* Grafana installed

This repository **does not install the cluster itself**, it provides production-ready configuration for it.

---

# Monitoring Configuration

Prometheus configuration includes:

* Persistent storage
* Resource limits
* Metric retention
* Alertmanager integration

Grafana configuration includes:

* Persistent storage
* Admin configuration
* Resource limits

All dashboards are stored in:

```
monitoring/grafana/dashboards/
```

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

Ingress configuration is located in:

```
networking/monitoring-ingress.yaml
```

---

# Usage

Clone the repository:

```
git clone https://github.com/YOUR_USER/kubernetes-production-starter-kit.git
cd kubernetes-production-starter-kit
```

Apply configurations according to your environment.

Example:

```
kubectl apply -f networking/monitoring-ingress.yaml
```

Import Grafana dashboards from:

```
monitoring/grafana/dashboards/
```

---

# Customization

This starter kit is designed to be **environment-agnostic**.

Users should adapt:

* Storage classes
* Domains
* TLS configuration
* Resource limits

according to their infrastructure.

---

# Roadmap

Future modules planned:

* Security baseline
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

Infrastructure & Kubernetes operations toolkit designed for production environments.
