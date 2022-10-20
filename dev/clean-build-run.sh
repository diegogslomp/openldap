#!/usr/bin/env bash
set -xeuo pipefail

docker compose down -v
docker compose build
docker image prune -f
docker compose up -d
docker compose logs -f