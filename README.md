# Kubernetes Production Starter Kit

[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge\&logo=kubernetes\&logoColor=white)](https://kubernetes.io/)
[![Helm](https://img.shields.io/badge/Helm-0F172A?style=for-the-badge\&logo=helm\&logoColor=white)](https://helm.sh/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)](https://www.docker.com/)
[![MinIO](https://img.shields.io/badge/MinIO-0052CC?style=for-the-badge\&logo=minio\&logoColor=white)](https://min.io/)

---

## Overview

**A production-ready baseline** for deploying observability, logging, backup, and operational tooling in Kubernetes clusters. Perfect for quickly bootstrapping a platform with modular, reusable components.

### Features

* Monitoring: Prometheus & Grafana
* Logging: Fluent Bit, Elasticsearch, Kibana
* Backup & Disaster Recovery: Velero & etcd snapshots
* Automated deployment scripts

---

## Architecture

```
kubernetes-production-starter-kit
│
├── configs/
├── monitoring/
│   └── prometheus-values.yaml
├── logging/
│   └── fluent-bit/
│       ├── fluent-bit-values.yaml
│       └── config/filters-audit.conf
├── backup/
│   ├── velero/velero-values.yaml
│   └── etcd/
│       ├── etcd-backup-cronjob.yaml
│       └── etcd-secret-example.yaml
├── networking/
├── scripts/
│   ├── deploy.sh
│   ├── install-monitoring.sh
│   ├── install-logging.sh
│   └── velero-schedule.sh
├── docs/
└── README.md
```

> Each module can be installed independently.

---

## Observability

### Monitoring

* **Prometheus**: Collect metrics from nodes, pods, services
* **Grafana**: Dashboards for cluster & app metrics

**Install Monitoring:**

```bash
./scripts/install-monitoring.sh
```

Namespace: `monitoring`

### Logging

* **Fluent Bit**: Log collection
* **Elasticsearch**: Index & store logs
* **Kibana**: Visualization dashboards

**Audit Logs Path:** `/var/log/kubernetes/audit/audit.log`

**Fluent Bit filters** reduce noise (list/watch/get requests, service account traffic, API discovery calls)

**Configuration:** `logging/fluent-bit/config/filters-audit.conf`

**Install Logging:**

```bash
./scripts/install-logging.sh
```

Namespace: `logging`

---

## Backup & Disaster Recovery

### Velero Backups

* Backup: namespaces, deployments, PVs, configmaps, secrets
* Storage: S3-compatible (AWS S3, MinIO, Ceph, DigitalOcean Spaces)

**Example Architecture:**

```
Kubernetes Cluster
        │
      Velero
        │
   S3 Object Storage
        │
       MinIO
```

**Configuration:** `backup/velero/velero-values.yaml`

**Schedule Backups:**

```bash
./scripts/velero-schedule.sh
```

### etcd Snapshots

* CronJob automates snapshots & uploads to S3/MinIO
* Secret template: `backup/etcd/etcd-secret-example.yaml`

---

## Deployment

**Requirements:**

* Kubernetes ≥1.26
* Helm & kubectl
* Optional: Elasticsearch, Kibana, S3-compatible storage

**Deploy All Components:**

```bash
./scripts/deploy.sh
```

Installs:

* cert-manager
* NGINX Ingress Controller
* Prometheus monitoring stack
* Fluent Bit logging stack
* Velero backup system

---

## Philosophy

* Modular approach: monitoring, logging, networking, backup, security
* Pick only what you need

**Future Modules:** Network observability, security policies, centralized auth, automated DR validation

---

## Use Cases

* Kubernetes platform bootstrap
* DevOps environments
* Production cluster observability
* Internal platform engineering teams

---

## License

Reusable baseline for Kubernetes platform deployments

---

## Documentation

See detailed architecture: `docs/architecture.md`
