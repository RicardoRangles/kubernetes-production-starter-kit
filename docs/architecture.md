# Kubernetes Observability Architecture

This document describes the observability and backup architecture used in this repository.

The platform integrates monitoring, logging, and backup components to provide operational visibility, security auditing, and disaster recovery capabilities for Kubernetes clusters.

---

# Architecture Overview

The platform is composed of three main operational layers:

Monitoring  
Logging  
Backup & Disaster Recovery  

Monitoring focuses on **metrics collection and visualization**, logging focuses on **audit and operational logs**, and backup ensures **cluster state protection and recovery**.

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

# Backup and Disaster Recovery

The platform includes a backup strategy to protect both Kubernetes resources and the cluster control plane state.

Two complementary backup mechanisms are implemented:

Velero Backups  
etcd Snapshots

---

## Velero Backups

Velero is used to back up Kubernetes resources such as:

* namespaces
* deployments
* services
* persistent volumes
* configmaps
* secrets

Velero stores backups in **S3-compatible object storage**.

Supported storage systems include:

* AWS S3
* MinIO
* Ceph Object Storage

For on-premise environments, **MinIO is commonly used as the S3 backend**.

Velero backups are typically scheduled from a **bastion or administration host** using the Velero CLI.

---

## etcd Cluster Backups

Kubernetes cluster state is stored in **etcd**, which must also be protected.

This repository includes a **Kubernetes CronJob** that performs automated etcd snapshots.

The process performs the following tasks:

* create an etcd snapshot
* upload the snapshot to object storage
* clean older snapshots automatically

Snapshots are stored in the same **S3 / MinIO bucket used by Velero**.

This ensures that both:

* Kubernetes resources
* Kubernetes control plane state

are protected for disaster recovery scenarios.

---

# Data Flow

The following diagram shows how observability and backup data flows through the system.

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
             v
        +--------+
        | Grafana|
        +--------+


       Backup Flow
       -----------


    +----------------------+
    |      Velero          |
    | Kubernetes Backups   |
    +----------+-----------+
               |
               v
    +----------------------+
    |   S3 Object Storage  |
    |   (MinIO / S3)       |
    +----------+-----------+
               |
               v
    +----------------------+
    |     etcd Snapshots   |
    |   Cluster State DR   |
    +----------------------+



---

# Observability Goals

The platform provides the following operational capabilities:

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

Disaster Recovery

* Kubernetes resource backups
* etcd cluster snapshots
* object storage backup retention

---

# Future Platform Extensions

This architecture can be extended with additional capabilities such as:

* network observability
* security policy enforcement
* automated restore testing
* multi-cluster backup strategies

Example tools that may be integrated in future modules:

* NGINX Ingress Controller
* Velero
