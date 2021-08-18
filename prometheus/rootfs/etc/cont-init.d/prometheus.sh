#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Prometheus
# Configures Prometheus
# ==============================================================================
echo "${SUPERVISOR_TOKEN}" > '/run/home-assistant.token'
