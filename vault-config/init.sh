#!/bin/bash
export VAULT_ADDR='http://localhost:8200'
export VAULT_TOKEN='root'

echo "==> Enabling KV secrets engine..."
vault secrets enable -path=secret kv-v2

echo "==> Enabling database secrets engine..."
vault secrets enable database

echo "==> Enabling AWS secrets engine..."
vault secrets enable aws

echo "==> Enabling PKI secrets engine..."
vault secrets enable pki
vault secrets tune -max-lease-ttl=87600h pki

echo "==> Enabling Kubernetes auth method..."
vault auth enable kubernetes

echo "==> Writing application secrets..."
vault kv put secret/myapp/config \
  db_host="rds.example.com" \
  db_port="3306" \
  api_key="my-api-key" \
  jwt_secret="my-jwt-secret"

echo "==> Creating app policy..."
vault policy write myapp-policy - <<EOF
path "secret/data/myapp/*" {
  capabilities = ["read"]
}
path "database/creds/myapp-role" {
  capabilities = ["read"]
}
EOF

echo "==> Configuring Kubernetes auth..."
vault write auth/kubernetes/config \
  kubernetes_host="https://kubernetes.default.svc" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
  token_reviewer_jwt=@/var/run/secrets/kubernetes.io/serviceaccount/token

echo "==> Creating Kubernetes role..."
vault write auth/kubernetes/role/myapp \
  bound_service_account_names=myapp-sa \
  bound_service_account_namespaces=production \
  policies=myapp-policy \
  ttl=24h

echo "✅ Vault initialized successfully!"
