FROM centos:7

LABEL maintainer xps2

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y java-1.8.0-openjdk-headless sudo supervisor && \
  yum clean all

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
