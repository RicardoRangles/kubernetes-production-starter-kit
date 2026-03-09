# Kubernetes Production Starter Kit

A production-ready baseline for deploying observability and operational tooling in Kubernetes clusters.

This repository provides a structured starting point for organizations that want to quickly bootstrap a Kubernetes platform with monitoring, logging, and operational scripts using modern cloud-native tools.

The goal is to provide **a clean, modular, and reproducible setup** that can be deployed across environments.

---

# Architecture Overview

This project organizes Kubernetes platform components into independent modules.

```
kubernetes-production-starter-kit
│
├── configs/                 # Shared configuration files
│
├── monitoring/              # Monitoring stack
│   └── prometheus-values.yaml
│
├── logging/                 # Logging stack
│   └── fluent-bit/
│       ├── fluent-bit-values.yaml
│       └── config/
│           └── filters-audit.conf
│
├── networking/              # Ingress / networking configuration
│
├── scripts/                 # Installation scripts
│   ├── install-monitoring.sh
│   └── install-logging.sh
│
├── docs/                    # Additional documentation
│
└── README.md
```

Each component can be installed independently.

---

# Observability Stack

The repository provides a baseline observability stack for Kubernetes environments.

It includes:

Monitoring

* Prometheus
* Grafana

Logging

* Fluent Bit
* Elasticsearch
* Kibana

---

# Monitoring Stack

The monitoring stack provides metrics collection and visualization for Kubernetes clusters.

Components:

Prometheus
Collects metrics from Kubernetes nodes, pods, and services.

Grafana
Provides dashboards for infrastructure and application metrics.

Metrics sources include:

* node exporter
* kube-state-metrics
* application exporters

---

## Install Monitoring

Run the installation script:

```bash
./scripts/install-monitoring.sh
```

This script deploys the monitoring stack using Helm.

Default namespace used in this project:

```
monitoring
```

---

# Logging Stack

The logging stack collects Kubernetes audit logs and sends them to Elasticsearch for indexing and analysis.

Components:

Fluent Bit
Collects logs from Kubernetes nodes.

Elasticsearch
Stores and indexes logs.

Kibana
Provides a visualization interface to explore logs.

---

## Kubernetes Audit Logging

This project focuses on collecting **Kubernetes audit logs**, which are useful for:

* security investigations
* operational troubleshooting
* compliance auditing

Audit logs must be enabled in the Kubernetes API server.

Typical audit log path:

```
/var/log/kubernetes/audit/audit.log
```

Fluent Bit reads logs from this location using a DaemonSet running on cluster nodes.

---

## Log Filtering

The configuration includes filtering rules to reduce noise from common Kubernetes operations.

Examples of filtered events:

* list operations
* watch operations
* get requests
* service account traffic
* API discovery calls

This ensures Elasticsearch stores **only relevant security and operational events**.

Configuration file:

```
logging/fluent-bit/config/filters-audit.conf
```

---

## Install Logging

Run the installation script:

```bash
./scripts/install-logging.sh
```

This installs Fluent Bit as a DaemonSet across the cluster.

Namespace used:

```
logging
```

---

# Installation Requirements

Before deploying the platform components, ensure the following tools are available:

* Kubernetes cluster
* Helm
* kubectl

Optional but recommended:

* Elasticsearch cluster
* Kibana instance

---

# Repository Philosophy

This repository follows a modular approach.

Each infrastructure capability is separated into its own directory:

* monitoring
* logging
* networking
* backup
* security

This allows organizations to adopt only the components they need.

---

# Future Modules

Additional platform modules may include:

* cluster backups
* ingress controllers
* security policies
* centralized authentication

Potential tools to integrate:

* Velero
* NGINX Ingress Controller

---

# Use Cases

This project can be used for:

* Kubernetes platform bootstrap
* DevOps environments
* production cluster observability
* internal platform engineering teams

---

# License

This project is intended as a reusable baseline for Kubernetes platform deployments.
