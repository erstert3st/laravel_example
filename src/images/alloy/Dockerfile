FROM  grafana/alloy:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -qy --no-install-recommends \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENTRYPOINT ["/bin/alloy"]
# CMD ["run", "/etc/alloy/config.alloy", "--storage.path=/var/lib/alloy/data"]