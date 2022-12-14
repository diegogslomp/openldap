# openldap

[![gh-actions](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml/badge.svg)](https://github.com/diegogslomp/openldap/actions/workflows/almalinux-image.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

OpenLDAP Server Image

1. Domain info:
   ```
   export DN="dc=my-domain,dc=com" \
   export PASSWD="secret" \
   export NAME="My Domain"
   ```
   
2. Run image:
   ```
   docker run -d --network=host \
     --restart=unless-stopped \
     -e DN="${DN}" \
     -e PASSWD="${PASSWD}" \
     -e NAME="${NAME}" \
     -v ldap-local:/usr/local \
     --name ldap diegogslomp/openldap
   ```

3. Add domain organization:
   ```
   docker exec ldap ldapadd -x -D "cn=manager,${DN}" -w "${PASSWD}" -f domain.ldif
   ```

4. Tests:
   ```
   docker exec ldap ldapsearch -xLLL -b '' -s base '(objectclass=*)' namingContexts
   docker exec ldap ldapsearch -xLLL -b "${DN}" '(objectclass=*)'
   ```

5. Or clone, build and run:
   ```
   git clone --single-branch https://github.com/diegogslomp/openldap
   cd openldap
   docker compose build
   docker compose up -d
   ```

Official site: https://www.openldap.org/doc/admin26/quickstart.html
