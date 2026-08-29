#!/bin/bash
# Sobe o kit nesta placa. Rodar como root a partir de /opt/stacks.
set -euo pipefail
cd /opt/stacks
ENV_FILE=/opt/stacks/.env

docker network inspect edge >/dev/null 2>&1 || docker network create edge

# --env-file só no Beszel: o .env do WUD tem $apr1$ e o Compose interpola isso.
for stack in caddy dozzle wud dockge; do
  docker compose \
    -f "/opt/stacks/${stack}/compose.yaml" \
    --project-directory "/opt/stacks/${stack}" \
    up -d
done
docker compose --env-file "$ENV_FILE" \
  -f /opt/stacks/beszel/compose.yaml \
  --project-directory /opt/stacks/beszel \
  up -d

echo "kit up. Caddy em 127.0.0.1:80 (Dockge/Dozzle/Beszel) e 127.0.0.1:3000 (WUD)."
