FROM ubuntu:jammy-20231004

# Set environment variables for non-interactive installs
ENV \
    DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive" \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE="DontWarn"

WORKDIR /app

# Change to a more reliable mirror
RUN sed -i 's/archive.ubuntu.com/mirrors.ubuntu.com/g' /etc/apt/sources.list

# Increase timeout for apt-get operations to avoid network-related issues
RUN apt-get -o Acquire::http::Timeout="60" -qq update \
    && apt-get -o Acquire::http::Retries="3" -qq install --no-install-recommends -y \
        intel-gpu-tools \
        python3-pip \
        tini \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/cache/apt/* \
        /var/tmp/*

# Copy application files into the container
COPY . .

# Define the entrypoint and the command
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/python3"]
CMD ["/app/exporter.py"]

LABEL \
    org.opencontainers.image.title="intel-gpu-exporter" \
    org.opencontainers.image.authors="mutra-vamsi <vamsimutra@gmail.com>" \
    org.opencontainers.image.source="https://github.com/mutra-vamsi/intel-gpu-exporter"

