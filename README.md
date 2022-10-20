# openldap

[![gh-actions](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml/badge.svg)](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

OpenLDAP Server Image

1. Run image:
   ```
   export DN="dc=my-domain,dc=com"
   export PASSWD="secret"
   export NAME="My Domain"

   docker run -d --network=host \
     --restart=unless-stopped \
     -e DN="${DN}" \
     -e PASSWD="${PASSWD}" \
     -e NAME="My Domain" \
     -v ldap-local:/usr/local \
     --name ldap diegogslomp/openldap
   ```

2. Add organization:
   ```
   docker exec ldap \
      ldapadd -x -D "cn=manager,${DN}" -w "${PASSWD}" -f domain.ldif
   ```

3. Tests:

   2.1 Show namingContexts:
   ```
   docker exec ldap ldapsearch -xLLL -b '' -s base '(objectclass=*)' namingContexts
   ```

   2.2 Search all domain entries:
   ```
   docker exec ldap ldapsearch -xLLL -b "${DN}" '(objectclass=*)'
   ```

4. Or clone, build and run:
   ```
   git clone --single-branch https://github.com/diegogslomp/openldap
   cd openldap
   docker compose build
   docker compose up -d
   ```

Official site: https://www.openldap.org/doc/admin26/quickstart.html
