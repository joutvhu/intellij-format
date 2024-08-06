FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y bash git wget xxd bsdmainutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget --no-verbose -O /tmp/idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2020.3.4.tar.gz && \
    tar -xzf /tmp/idea.tar.gz -C /opt && \
    mv /opt/idea* /opt/idea && \
    rm /tmp/idea.tar.gz && \
    mkdir -p "$(eval echo ~$USER)/.config/JetBrains/IntelliJIdea2020.3/eval" && \
    cd "$(eval echo ~$USER)/.config/JetBrains/IntelliJIdea2020.3/eval" && \
    printf %x $(echo -$(($(date +%s%N)/1000000))) > evaluation-date.txt && \
    xxd -r -p evaluation-date.txt idea203.evaluation.key && \
    rm evaluation-date.txt && \
    hexdump -C idea203.evaluation.key && \
    echo $(pwd)/idea203.evaluation.key

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chown -R ${USER}:${USER} /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
