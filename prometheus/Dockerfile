ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:11.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
ENV PROMETHEUS_VERSION=2.33.1

# Copy root filesystem
COPY rootfs /

# hadolint ignore=DL3003
RUN \
    ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    \
    && apk --no-cache add \
        python3=3.9.7-r4 \
        py3-idna=3.3-r0 \
        py3-certifi=2020.12.5-r1 \
        py3-chardet=4.0.0-r2 \
        py3-yaml=5.4.1.1-r1 \
        py3-urllib3=1.26.7-r0 \
        py3-requests=2.26.0-r1 \
    && apk --no-cache add --virtual .builddeps \
        py-pip=20.3.4-r1 \
    \
    && curl -J -L -o /tmp/prometheus.tar.gz \
        "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-${ARCH}.tar.gz" \
    && adduser -s /bin/false -D -H prometheus \
    && cd /tmp \
    && tar -xvf /tmp/prometheus.tar.gz \
    && mkdir -p /etc/prometheus \
    && cp prometheus-${PROMETHEUS_VERSION}.linux-${ARCH}/promtool /usr/local/bin/ \
    && cp prometheus-${PROMETHEUS_VERSION}.linux-${ARCH}/prometheus /usr/local/bin/ \
    && cp -R prometheus-${PROMETHEUS_VERSION}.linux-${ARCH}/console_libraries/ /etc/prometheus/ \
    && cp -R prometheus-${PROMETHEUS_VERSION}.linux-${ARCH}/consoles/ /etc/prometheus/ \
    && rm -r prometheus-${PROMETHEUS_VERSION}.linux-${ARCH} \
    && chown -R prometheus:prometheus /etc/prometheus \
    && pip3 install \
        --no-cache-dir \
        --prefer-binary \
        --find-links "https://wheels.home-assistant.io/alpine-3.14/${BUILD_ARCH}/" \
        -r /opt/prometheus-configgen/requirements.txt \
    \
    && apk --no-cache del .builddeps \
    && rm -f -r \
        /tmp/*

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Prometheus" \
    io.hass.description="Cloud native metrics" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Robbert Müller <homeassistant@grols.ch>" \
    org.opencontainers.image.title="Prometheus" \
    org.opencontainers.image.description="Cloud native metrics" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Robbert Müller <homeassistant@grols.ch>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/hassio-addons/addon-prometheus" \
    org.opencontainers.image.documentation="https://github.com/hassio-addons/addon-prometheus/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
