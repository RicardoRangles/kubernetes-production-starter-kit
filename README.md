Kubernetes Production Starter Kit

A production-ready baseline for deploying observability and operational tooling in Kubernetes clusters.

This repository provides a structured starting point for organizations that want to quickly bootstrap a Kubernetes platform with monitoring, logging, backup, and operational scripts using modern cloud-native tools.

The goal is to provide a clean, modular, and reproducible setup that can be deployed across environments.

Architecture Overview

This project organizes Kubernetes platform components into independent modules.

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
├── backup/                  # Backup and disaster recovery
│   ├── velero/
│   │   └── velero-values.yaml
│   │
│   └── etcd/
│       ├── etcd-backup-cronjob.yaml
│       └── etcd-secret-example.yaml
│
├── networking/              # Ingress / networking configuration
│
├── scripts/                 # Installation scripts
│   ├── deploy.sh
│   ├── install-monitoring.sh
│   ├── install-logging.sh
│   └── velero-schedule.sh
│
├── docs/                    # Additional documentation
│
└── README.md

Each component can be installed independently.

Observability Stack

The repository provides a baseline observability stack for Kubernetes environments.

It includes:

Monitoring

Prometheus

Grafana

Logging

Fluent Bit

Elasticsearch

Kibana

Monitoring Stack

The monitoring stack provides metrics collection and visualization for Kubernetes clusters.

Components:

Prometheus
Collects metrics from Kubernetes nodes, pods, and services.

Grafana
Provides dashboards for infrastructure and application metrics.

Metrics sources include:

node exporter

kube-state-metrics

application exporters

Install Monitoring

Run the installation script:

./scripts/install-monitoring.sh

This script deploys the monitoring stack using Helm.

Default namespace used in this project:

monitoring
Logging Stack

The logging stack collects Kubernetes audit logs and sends them to Elasticsearch for indexing and analysis.

Components:

Fluent Bit
Collects logs from Kubernetes nodes.

Elasticsearch
Stores and indexes logs.

Kibana
Provides a visualization interface to explore logs.

Kubernetes Audit Logging

This project focuses on collecting Kubernetes audit logs, which are useful for:

security investigations

operational troubleshooting

compliance auditing

Audit logs must be enabled in the Kubernetes API server.

Typical audit log path:

/var/log/kubernetes/audit/audit.log

Fluent Bit reads logs from this location using a DaemonSet running on cluster nodes.

Log Filtering

The configuration includes filtering rules to reduce noise from common Kubernetes operations.

Examples of filtered events:

list operations

watch operations

get requests

service account traffic

API discovery calls

This ensures Elasticsearch stores only relevant security and operational events.

Configuration file:

logging/fluent-bit/config/filters-audit.conf
Install Logging

Run the installation script:

./scripts/install-logging.sh

This installs Fluent Bit as a DaemonSet across the cluster.

Namespace used:

logging
Backup and Disaster Recovery

The platform includes a backup strategy to protect both Kubernetes resources and the cluster state.

Two backup mechanisms are used:

Velero backups

etcd snapshots

Using both mechanisms together ensures the cluster can be fully restored during a disaster recovery scenario.

Velero Backups

Velero is used to back up Kubernetes resources such as:

namespaces

deployments

services

persistent volumes

configmaps

secrets

Velero stores backups in S3-compatible object storage.

Supported storage systems include:

AWS S3

MinIO

Ceph Object Storage

DigitalOcean Spaces

For on-premise clusters, MinIO is commonly used as the S3-compatible storage backend.

Example architecture:

Kubernetes Cluster
        │
        │
      Velero
        │
        │
   S3 Object Storage
        │
       MinIO

Configuration file:

backup/velero/velero-values.yaml

Velero can be installed using Helm or through the repository deployment scripts.

Velero Backup Scheduling

Backup schedules can be created using the Velero CLI.

This repository provides a helper script that creates standard backup schedules.

Script location:

scripts/velero-schedule.sh

This script is typically executed from a bastion host or administrative workstation that has access to the Kubernetes cluster.

Example:

./scripts/velero-schedule.sh

Typical schedules include:

daily cluster backups

weekly backups

Once created, these schedules run automatically within the cluster.

etcd Cluster Backups

While Velero backs up Kubernetes resources, the cluster control plane state is stored in etcd.

To ensure full disaster recovery capability, the repository also includes automated etcd snapshots.

File location:

backup/etcd/etcd-backup-cronjob.yaml

This Kubernetes CronJob performs the following tasks:

creates etcd snapshots

uploads snapshots to object storage

cleans old snapshots automatically

Snapshots are stored in the same S3 / MinIO bucket used by Velero.

Credentials for the object storage are stored using a Kubernetes Secret.

Example secret template:

backup/etcd/etcd-secret-example.yaml

This approach ensures that both:

Kubernetes resource definitions

Kubernetes control plane state

are safely backed up.

Installation Requirements

Before deploying the platform components, ensure the following tools are available:

Kubernetes cluster

Helm

kubectl

Optional but recommended:

Elasticsearch cluster

Kibana instance

S3 compatible storage (MinIO or AWS S3)

Platform Deployment

To deploy the platform components automatically, run:

./scripts/deploy.sh

This script installs:

cert-manager

NGINX Ingress Controller

Prometheus monitoring stack

Fluent Bit logging stack

Velero backup system

Repository Philosophy

This repository follows a modular approach.

Each infrastructure capability is separated into its own directory:

monitoring

logging

networking

backup

security

This allows organizations to adopt only the components they need.

Future Modules

Additional platform modules may include:

network observability

security policy enforcement

centralized authentication

automated disaster recovery validation

Potential tools to integrate:

Velero

NGINX Ingress Controller

Falco

Cilium

Use Cases

This project can be used for:

Kubernetes platform bootstrap

DevOps environments

production cluster observability

internal platform engineering teams

License

This project is intended as a reusable baseline for Kubernetes platform deployments.

Extra Documentation

Additional architecture documentation can be found in:

docs/architecture.md
