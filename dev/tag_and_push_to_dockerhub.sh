#!/usr/bin/env bash
set -xeuo pipefail

docker tag openldap:almalinux diegogslomp/openldap:latest
docker push diegogslomp/openldap:latest
docker rmi diegogslomp/openldap:latest

# Cleanup
docker image prune -f
docker images