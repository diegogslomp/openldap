# openldap

[![gh-actions](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml/badge.svg)](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

OpenLDAP Server Image

1. Default config run:
```
docker run -d --network=host \
  --restart=unless-stopped \
  -v ldap-local:/usr/local \
  --name ldap diegogslomp/openldap
```

1. Or clone, build and run:
```
git clone --single-branch https://github.com/diegogslomp/openldap
cd openldap
# Edit slapd.ldif
docker compose build
docker compose up -d
```

3. Tests:
```
docker exec -it ldap \
  ldapsearch -x -b '' -s base '(objectclass=*)' namingContexts
```

Official site: https://www.openldap.org/doc/admin26/quickstart.html
