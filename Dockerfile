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
RUN mkdir -p slapd.d && \
  mkdir -p /usr/local/var/openldap-data

COPY domain.ldif domain.ldif
COPY sbin /usr/local/sbin

CMD update-etc-files && start-slapd

VOLUME /usr/local
EXPOSE 389 636
