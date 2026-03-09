#!/bin/bash

set -e

echo "===================================="
echo "Kubernetes Production Starter Kit"
echo "Starting deployment..."
echo "===================================="

echo "Checking kubectl..."

if ! command -v kubectl &> /dev/null
then
    echo "kubectl not installed"
    exit
fi

echo "Checking Helm..."

if ! command -v helm &> /dev/null
then
    echo "helm not installed"
    exit
fi

echo "Adding Helm repositories..."

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add jetstack https://charts.jetstack.io
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add vmware-tanzu https://vmware-tanzu.github.io/helm-charts

helm repo update

echo "Installing cert-manager..."

kubectl create namespace cert-manager --dry-run=client -o yaml | kubectl apply -f -

helm install cert-manager jetstack/cert-manager \
--namespace cert-manager \
--set installCRDs=true

echo "Installing NGINX Ingress..."

kubectl create namespace ingress-nginx --dry-run=client -o yaml | kubectl apply -f -

helm install ingress-nginx ingress-nginx/ingress-nginx \
--namespace ingress-nginx

echo "Installing monitoring stack..."

kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

helm install monitoring prometheus-community/kube-prometheus-stack \
--namespace monitoring

echo "Installing logging..."

kubectl create namespace logging --dry-run=client -o yaml | kubectl apply -f -

helm install fluent-bit fluent/fluent-bit \
--namespace logging

echo "Installing Velero backup system..."

kubectl create namespace velero --dry-run=client -o yaml | kubectl apply -f -

helm install velero vmware-tanzu/velero \
--namespace velero

echo "===================================="
echo "Deployment completed successfully"
echo "===================================="
