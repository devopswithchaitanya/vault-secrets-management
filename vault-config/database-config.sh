#!/bin/bash
export VAULT_ADDR='http://localhost:8200'
export VAULT_TOKEN='root'

vault write database/config/myapp-db \
  plugin_name=mysql-database-plugin \
  connection_url="{{username}}:{{password}}@tcp(rds.example.com:3306)/appdb" \
  allowed_roles="myapp-role" \
  username="vault_admin" \
  password="vault_admin_password"

vault write database/roles/myapp-role \
  db_name=myapp-db \
  creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}'; GRANT SELECT, INSERT, UPDATE ON appdb.* TO '{{name}}'@'%';" \
  revocation_statements="DROP USER IF EXISTS '{{name}}'@'%';" \
  default_ttl="1h" \
  max_ttl="24h"

echo "✅ Dynamic DB credentials configured!"
