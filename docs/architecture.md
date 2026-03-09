# Kubernetes Observability Architecture

This document describes the observability architecture used in this repository.

The platform integrates monitoring and logging components to provide operational visibility and troubleshooting capabilities for Kubernetes clusters.

---

# Architecture Overview

The platform is composed of two main observability layers:

Monitoring
Logging

Monitoring focuses on **metrics collection and visualization**, while logging focuses on **audit and operational logs**.

---

# Monitoring Stack

Monitoring is implemented using:

* Prometheus
* Grafana

Prometheus collects metrics from:

* Kubernetes nodes
* Pods
* Services
* Exporters

Common exporters include:

* node-exporter
* kube-state-metrics

Grafana provides dashboards for cluster health and performance metrics.

---

# Logging Stack

Logging is implemented using:

* Fluent Bit
* Elasticsearch
* Kibana

Fluent Bit runs as a **DaemonSet** on Kubernetes nodes and collects audit logs from the Kubernetes API server.

These logs are forwarded to Elasticsearch for indexing and search.

Kibana provides dashboards and search capabilities for investigating cluster events.

---

# Data Flow

The following diagram shows how observability data flows through the system.

```
                    +----------------------+
                    |   Kubernetes API     |
                    |      Server          |
                    +----------+-----------+
                               |
                               | Audit Logs
                               |
                     /var/log/kubernetes/audit
                               |
                               v
                     +------------------+
                     |    Fluent Bit    |
                     |   (DaemonSet)    |
                     +--------+---------+
                              |
                              | Log Forwarding
                              |
                              v
                     +------------------+
                     |   Elasticsearch  |
                     |   Log Storage    |
                     +--------+---------+
                              |
                              |
                              v
                     +------------------+
                     |      Kibana      |
                     |   Log Analysis   |
                     +------------------+


           Metrics Flow
           -------------
     +------------------------+
     | Kubernetes Nodes/Pods  |
     +-----------+------------+
                 |
                 | Metrics
                 |
                 v
           +-----------+
           | Prometheus|
           +-----+-----+
                 |
                 |
                 v
            +--------+
            | Grafana|
            +--------+
```

---

# Observability Goals

The observability platform provides:

Cluster Monitoring

* infrastructure metrics
* node health
* pod performance
* resource utilization

Security Visibility

* Kubernetes audit logs
* RBAC activity
* API server access logs

Operational Troubleshooting

* cluster event investigation
* workload failure analysis
* system debugging

---

# Future Platform Extensions

This architecture can be extended with additional capabilities such as:

* cluster backups
* network observability
* security policy enforcement

Example tools that may be integrated in future modules:

* Velero
* NGINX Ingress Controller
