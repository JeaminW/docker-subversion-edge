FROM registry.access.redhat.com/ubi7-minimal

LABEL maintainer xps2

RUN \
  microdnf update -y && \
  rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  microdnf install -y file-libs java-1.8.0-openjdk-headless sudo supervisor && \
  microdnf clean all

ADD CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz /opt

ENV JAVA_HOME /usr/lib/jvm/jre
ENV RUN_AS_USER collabnet

RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    chown root:collabnet /opt/csvn/lib/httpd_bind/httpd_bind && \
    chmod u+s /opt/csvn/lib/httpd_bind/httpd_bind && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial

EXPOSE 80 443 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]
