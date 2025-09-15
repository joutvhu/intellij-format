FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG IDEA_VERSION=2025.2.1
ARG IDEA_EDITION=IU
ENV IDEA_HOME=/opt/idea

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl bash git xxd tar; \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    FILE="idea${IDEA_EDITION}-${IDEA_VERSION}.tar.gz"; \
    URL="https://download.jetbrains.com/idea/${FILE}"; \
    curl -fLso /tmp/idea.tar.gz "$URL"; \
    tar -xzf /tmp/idea.tar.gz -C /opt; \
    mv /opt/idea-* "${IDEA_HOME}"; \
    rm /tmp/idea.tar.gz

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
