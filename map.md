
#### Intern  -> extern
- devContainer        → http://localhost:8000
- alloy:12345         → http://localhost:12345
- apache:8080         → http://localhost:8080
- grafana:3000        → http://localhost:3000
- pyroscope:4040      → http://localhost:4040
- apacheexporter:9117 → http://localhost:9117
- phpfpmexporter:9253 → http://localhost:9253

- apache:9000         → localhost:9000  PHP 
- mimir:9009          → localhost:9009  API
- loki:3100           → localhost:3100  API
- tempo:3200          → localhost:3200  API
- mysqldexporter:9104 → localhost:9104  API
- mariadb:3306        → localhost:3306  DB
- tempo:4317          → localhost:4317  gRPC



| Service                            | Image / Build                   | Ports      | Beschreibung / Abhängigkeiten                          |
| ---------------------------------- | ------------------------------- | ---------- | ------------------------------------------------------ |
| **apache**                         | serversideup/php:8.4-fpm-apache | 8080, 9000 | Webserver, Healthcheck auf 8080                        |
| **alloy**                          | grafana/alloy\:v1.5.1           | 12345      | OpenTelemetry Agent, spricht mit `mimir`, `loki`, etc. |
| **mimir**                          | grafana/mimir:2.14.3            | 9009       | TSDB für Prometheus                                    |
| **loki**                           | grafana/loki:3.4.1              | 3100       | Log Aggregation                                        |
| **tempo**                          | grafana/tempo:2.7.0             | 3200, 4317 | Distributed Tracing Backend                            |
| **pyroscope**                      | grafana/pyroscope:1.5.0         | 4040       | Profiling Tool                                         |
| **mariadb**                        | mariadb\:latest                 | 3306       | Datenbank                                              |
| **phpfpmexporter**                 | hipages/php-fpm\_exporter       | 9253       | Exporter für PHP-FPM (scraped apache:9000/status)      |
| **apacheexporter**                 | bitnami/apache-exporter         | 9117       | Exporter für Apache Status (scraped apache:8080)       |
| **mysqldexporter**                 | prom/mysqld-exporter            | 9104       | Exporter für MariaDB                                   |
| **grafana**                        | grafana/grafana:12.0.0          | 3000       | Dashboard UI, Healthcheck auf /healthz                 |
| **install-dashboard-dependencies** | build: images/jb                | —          | jb install, hängt von Grafana ab                       |
| **provision-dashboards**           | build: images/grizzly           | —          | Dashboard Provisioning mit grr                         |
| **watch-dashboards**               | build: images/grizzly           | —          | Beobachtet Dashboards, hängt von install ab            |
