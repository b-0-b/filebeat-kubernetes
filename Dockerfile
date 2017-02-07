FROM jessie-slim

MAINTAINER Amanpreet Singh <aps.sids@gmail.com>

ENV FILEBEAT_VERSION 5.2.0
ENV LOGSTASH_HOSTS log0.elk0.byf0.bwcom.net
ENV LOG_LEVEL info

RUN apt-get update && \
    apt-get -y install wget && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    echo "$(wget -qO - https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz.sha1) filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz" | sha1sum -c - && \
    tar xzf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64/filebeat /usr/local/bin && \
    rm -rf /filebeat* && \
    apt-get -y remove wget && \
    apt-get -y autoremove

COPY filebeat.yml /etc/filebeat/
COPY log0.elk0.byf0.bwcom.net.crt /etc/filebeat/log0.elk0.byf0.bwcom.net.crt 


CMD ["/usr/local/bin/filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]

