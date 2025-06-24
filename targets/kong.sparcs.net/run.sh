sudo true
sudo tee /etc/systemd/system/mysqld-exporter.service <<'EOF'
[Unit]
Description=Prometheus MySQL Exporter
After=network.target

[Service]
User=wheel
Group=wheel
Type=simple
Restart=always
ExecStart=/opt/mysqld_exporter/mysqld_exporter \
    --config.my-cnf=/etc/mysqld_exporter.my.cnf \
    --mysqld.address=127.0.0.1:3006

EOF

sudo systemctl daemon-reload

printf "Run \`sudo systemctl enable --now mysqld-exporter.service\` to run exporter\n"
printf "Make sure \`/etc/mysqld_exporter.my.cnf\` exists\n"

