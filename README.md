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


2. Tests:

   2.1 Show namingContexts:
   ```
   docker exec ldap ldapsearch -xLLL -b '' -s base '(objectclass=*)' namingContexts
   ```

   2.2 Add my-domain organization:
   ```
   docker exec ldap ldapadd -x -D "cn=manager,dc=my-domain,dc=com" -w secret -f domain.ldif
   ```

   2.3 Search all domain entries:
   ```
   docker exec ldap ldapsearch -xLLL -b "dc=my-domain,dc=com" '(objectclass=*)'
   ```
  
3. Or clone, build and run:
```
git clone --single-branch https://github.com/diegogslomp/openldap
cd openldap
# Edit my-domain inside slapd folder files
docker compose build
docker compose up -d
```

Official site: https://www.openldap.org/doc/admin26/quickstart.html
