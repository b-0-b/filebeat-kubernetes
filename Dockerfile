FROM debian:jessie-slim

MAINTAINER Anders Bomberg <anders@brandwatch.com>

ENV FILEBEAT_VERSION 5.2.0

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
COPY ca-chain.cert.pem /etc/filebeat/ca-chain.cert.pem
COPY logger.sh /logger.sh


CMD ["/usr/local/bin/filebeat", "-e", "-c", "/etc/filebeat/filebeat.yml"]

