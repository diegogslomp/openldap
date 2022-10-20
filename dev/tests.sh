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

_info Show namingContexts
ldapsearch -xLLL -b '' -s base '(objectclass=*)' namingContexts

_info Add my-domain organization
ldapadd -x -D "cn=manager,dc=my-domain,dc=com" -w secret -f ./slapd/domain.ldif || true

_info Search all domain entries
ldapsearch -xLLL -b "dc=my-domain,dc=com" '(objectclass=*)'