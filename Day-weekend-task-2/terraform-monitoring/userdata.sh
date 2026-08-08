#!/bin/bash
set -e
echo "Starting monitoring stack installation..."
# Update system
dnf update -y
# wget and tar are already available on Amazon Linux 2023
# ==================================================
# Docker
# ==================================================
dnf install -y docker

systemctl enable docker
systemctl start docker

usermod -aG docker ec2-user


# ==================================================
# Node Exporter
# ==================================================

cd /opt

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz

tar -xzf node_exporter-1.9.1.linux-amd64.tar.gz

mv node_exporter-1.9.1.linux-amd64 node_exporter

useradd --no-create-home --shell /bin/false node_exporter || true

chown -R node_exporter:node_exporter /opt/node_exporter

cat > /etc/systemd/system/node_exporter.service <<'SERVICE'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter


# ==================================================
# Prometheus
# ==================================================

useradd --no-create-home --shell /bin/false prometheus || true

mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

cd /opt

wget https://github.com/prometheus/prometheus/releases/download/v3.5.0/prometheus-3.5.0.linux-amd64.tar.gz

tar -xzf prometheus-3.5.0.linux-amd64.tar.gz

mv prometheus-3.5.0.linux-amd64 prometheus

cp /opt/prometheus/prometheus /usr/local/bin/
cp /opt/prometheus/promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool


# Prometheus configuration

cat > /etc/prometheus/prometheus.yml <<'PROM'
global:
  scrape_interval: 15s

scrape_configs:

  - job_name: "node-exporter"
    static_configs:
      - targets:
          - "localhost:9100"

PROM

chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus


# Prometheus systemd service

cat > /etc/systemd/system/prometheus.service <<'SERVICE'
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple

ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
SERVICE

systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus


# ==================================================
# Grafana
# ==================================================

cat > /etc/yum.repos.d/grafana.repo <<'REPO'
[grafana]
name=grafana
baseurl=https://rpm.grafana.com
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://rpm.grafana.com/gpg.key
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
REPO

dnf install -y grafana

systemctl enable grafana-server
systemctl start grafana-server

echo "Monitoring stack installation completed."