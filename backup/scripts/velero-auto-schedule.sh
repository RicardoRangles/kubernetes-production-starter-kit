#!/bin/bash
set -euo pipefail

# ==========================================
# Velero Auto Schedule Script
#
# ¿Qué hace este script?
# - Detecta automáticamente namespaces que tienen PVC
# - Crea UN schedule diario de Velero por namespace (si no existe)
# - Evita duplicados (idempotente)
# - NO crea backups manuales
# - NO borra backups ni objetos en MinIO
# - El TTL del schedule controla la retención
#
# Cuándo se ejecuta:
# - Pensado para ejecutarse por cron a las 5 am
#
# Requisitos:
# - kubectl configurado
# - velero CLI configurado
# - BackupStorageLocation operativo
# ==========================================

# -----------------------------
# CONFIGURACIÓN
# -----------------------------
SCHEDULE_TIME="0 5 * * *"      # 5 am
TTL="48h"                      # 2 días de retención
STORAGE_LOCATION="default"     # BackupStorageLocation activo
LOG_PREFIX="[VELERO-AUTO]"

echo "$LOG_PREFIX Inicio $(date)"

# -----------------------------
# OBTENER NAMESPACES CON PVC
# -----------------------------
namespaces=$(kubectl get pvc -A \
  -o jsonpath='{range .items[*]}{.metadata.namespace}{"\n"}{end}' \
  | sort -u)

for ns in $namespaces; do

  # -----------------------------
  # FILTROS DE SEGURIDAD
  # -----------------------------
  if [[ "$ns" =~ ^(kube-|openshift-|velero$) ]]; then
    continue
  fi

  schedule_name="${ns}-daily-backup"

  # -----------------------------
  # VERIFICAR SI YA EXISTE
  # -----------------------------
  if velero schedule get "$schedule_name" &>/dev/null; then
    echo "$LOG_PREFIX Schedule ya existe: $schedule_name"
    continue
  fi

  # -----------------------------
  # CREAR SCHEDULE
  # -----------------------------
  echo "$LOG_PREFIX Creando schedule para namespace: $ns"

  velero schedule create "$schedule_name" \
    --schedule "$SCHEDULE_TIME" \
    --include-namespaces "$ns" \
    --default-volumes-to-fs-backup \
    --storage-location "$STORAGE_LOCATION" \
    --ttl "$TTL"

done

echo "$LOG_PREFIX Fin $(date)"
