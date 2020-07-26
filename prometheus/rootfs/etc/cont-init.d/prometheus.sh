#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Prometheus
# Configures Prometheus
# ==============================================================================
readonly CONFIG="/etc/prometheus/prometheus.yml"

echo "${HASSIO_TOKEN}" > '/run/home-assistant.token'

