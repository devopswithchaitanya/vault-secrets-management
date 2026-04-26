# Read application secrets
path "secret/data/myapp/*" {
  capabilities = ["read", "list"]
}

# Read dynamic DB credentials
path "database/creds/myapp-role" {
  capabilities = ["read"]
}

# Renew leases
path "sys/leases/renew" {
  capabilities = ["update"]
}

# Revoke own token
path "auth/token/revoke-self" {
  capabilities = ["update"]
}
