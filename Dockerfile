FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y bash git wget xxd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget --no-verbose -O /tmp/idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2020.3.4.tar.gz && \
    tar -xzf /tmp/idea.tar.gz -C /opt && \
    mv /opt/idea* /opt/idea && \
    rm /tmp/idea.tar.gz

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chown -R ${USER}:${USER} /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
