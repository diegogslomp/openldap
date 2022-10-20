#!/usr/bin/env bash
set -xeuo pipefail

ldapsearch -h localhost -xLLL -b '' -s base '(objectclass=*)' namingContexts