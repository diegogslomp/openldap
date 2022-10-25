#!/usr/bin/env bash
set -euo pipefail

# Colored printf
_info() {
  local BLUE='\e[1;34m'
  local YELLOW='\e[1;33m'
  local NC='\e[0m'
  local MESSAGE="$*"
  printf "${BLUE}# $(hostname):${YELLOW} ${MESSAGE}${NC}\n"
}

export DN="dc=dgs,dc=net"
export PASSWD="secret"

_info "Add domain organization"
docker exec ldap ldapadd -x -D "cn=manager,${DN}" -w "${PASSWD}" -f domain.ldif || true

_info Show namingContexts
ldapsearch -xLLL -b '' -s base '(objectclass=*)' namingContexts

_info Search all domain entries
ldapsearch -xLLL -b "${DN}" '(objectclass=*)'