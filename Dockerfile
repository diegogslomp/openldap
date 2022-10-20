FROM almalinux:9

RUN yum install gcc man diffutils -y && \
  yum clean all -y

ARG VERSION=2.5.13

WORKDIR /usr/local/src
RUN curl -O "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-${VERSION}.tgz" && \
  tar zxvf "openldap-${VERSION}.tgz" && \
  mv "openldap-${VERSION}" openldap && \
  rm -rf "openldap-${VERSION}.tgz"

WORKDIR /usr/local/src/openldap
RUN ./configure && \
  make depend && \
  make && \
  make test && \
  make install && \
  rm -rf /usr/local/src/openldap

WORKDIR /usr/local/etc/openldap
RUN mkdir -p /usr/local/etc/slapd.d && \
  mkdir -p /usr/local/var/openldap-data && \
  mv slapd.ldif slapd.ldif.ORIG && \
  mv slapd.conf slapd.conf.ORIG

COPY slapd/* .
COPY sbin /usr/local/sbin

CMD set-domain-on-configfiles && start-slapd
VOLUME /usr/local
EXPOSE 389 636
