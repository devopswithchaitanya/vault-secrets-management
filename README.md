# 🔐 HashiCorp Vault — Secrets Management

Production-grade HashiCorp Vault setup with Kubernetes integration. Covers dynamic secrets, PKI, and automated secrets injection into pods via Vault Agent.

## Features

- Dynamic database credentials (auto-rotated)
- Kubernetes Auth for pod-level secrets access
- Vault Agent Sidecar injection
- PKI certificate management
- AWS IAM secrets engine

## Quick Start

```bash
# Start Vault dev server
docker-compose up -d

# Initialize & configure
./vault-config/init.sh
```

## Kubernetes Integration

```bash
kubectl apply -f k8s/vault-agent-injector.yaml
kubectl apply -f k8s/example-app-with-vault.yaml
```

## Tech Stack
`HashiCorp Vault` `Kubernetes` `Docker` `AWS IAM` `PKI`
