FROM centos:7

LABEL maintainer xps2

RUN \
  yum update -y && \
  yum install -y epel-release && \
  yum install -y java-1.8.0-openjdk net-tools hostname inotify-tools yum-utils supervisor && \
  yum clean all

ADD CollabNetSubversionEdge-5.2.4_linux-x86_64.tar.gz /opt

ENV JAVA_HOME /usr/lib/jvm/jre
ENV RUN_AS_USER collabnet

RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial

EXPOSE 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]
