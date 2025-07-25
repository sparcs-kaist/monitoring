#!/bin/bash

# 버전 정보
NODE_EXPORTER_VERSION="1.9.1"
NODE_EXPORTER_DIR="/opt/node_exporter"
NODE_EXPORTER_BIN="${NODE_EXPORTER_DIR}/node_exporter"

# 1. node_exporter 다운로드 및 압축 해제
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

tar xvfz node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz

# 2. 실행 바이너리 이동
sudo mkdir -p ${NODE_EXPORTER_DIR}
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter ${NODE_EXPORTER_BIN}
sudo chmod +x ${NODE_EXPORTER_BIN}
sudo chown -R wheel:wheel ${NODE_EXPORTER_DIR}

# 3. systemd 서비스 파일 작성
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Prometheus Node Exporter
After=network.target

[Service]
User=wheel
Group=wheel
Type=simple
Restart=always
ExecStart=${NODE_EXPORTER_BIN}

[Install]
WantedBy=multi-user.target
EOF

# 4. systemd 재로드
sudo systemctl daemon-reload

# 5. 안내 메시지
echo
echo "✅ Run the following command to enable and start node_exporter:"
echo "   sudo systemctl enable --now node_exporter"
echo
echo "📍 Metrics available at: http://localhost:9100/metrics"
