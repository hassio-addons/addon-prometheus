#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: Prometheus
# Configures Prometheus
# ==============================================================================
echo "${SUPERVISOR_TOKEN}" > '/run/home-assistant.token'

mkdir -p /data/prometheus
chown prometheus:prometheus /data/prometheus
find /data/prometheus -not -perm 0644 -type f -exec chmod 0660 {} \;
find /data/prometheus -not -perm 0755 -type d -exec chmod 0770 {} \;
