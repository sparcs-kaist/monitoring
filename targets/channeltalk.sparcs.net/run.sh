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
    --collect.engine_innodb_status \
    --collect.global_status \
    --collect.global_variables \
    --collect.info_schema.clientstats \
    --collect.info_schema.innodb_metrics \
    --collect.info_schema.innodb_tablespaces \
    --collect.info_schema.innodb_cmp \
    --collect.info_schema.innodb_cmpmem \
    --collect.info_schema.processlist \
    --collect.info_schema.processlist.min_time=0 \
    --collect.info_schema.query_response_time \
    --collect.info_schema.replica_host \
    --collect.info_schema.tables \
    --collect.info_schema.tables.databases=‘*’ \
    --collect.info_schema.tablestats \
    --collect.info_schema.schemastats \
    --collect.info_schema.userstats \
    --collect.mysql.user \
    --collect.perf_schema.eventsstatements \
    --collect.perf_schema.eventsstatements.digest_text_limit=120 \
    --collect.perf_schema.eventsstatements.limit=250 \
    --collect.perf_schema.eventsstatements.timelimit=86400 \
    --collect.perf_schema.eventsstatementssum \
    --collect.perf_schema.eventswaits \
    --collect.perf_schema.file_events \
    --collect.perf_schema.file_instances \
    --collect.perf_schema.file_instances.remove_prefix=false \
    --collect.perf_schema.indexiowaits \
    --collect.perf_schema.memory_events \
    --collect.perf_schema.memory_events.remove_prefix=false \
    --collect.perf_schema.tableiowaits \
    --collect.perf_schema.tablelocks \
    --collect.perf_schema.replication_group_members \
    --collect.perf_schema.replication_group_member_stats \
    --collect.perf_schema.replication_applier_status_by_worker \
    --collect.slave_status \
    --collect.slave_hosts \
    --collect.heartbeat \
    --collect.heartbeat.database=true \
    --collect.heartbeat.table=true \
    --collect.heartbeat.utc

[Install]
WantedBy=multi-user.target

EOF

sudo systemctl daemon-reload

printf "Run \`sudo systemctl enable --now mysqld-exporter.service\` to run exporter\n"
printf "Make sure \`/etc/mysqld_exporter.my.cnf\` exists\n"

