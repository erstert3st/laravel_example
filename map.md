| Service                 | Image / Build                   | Ports      | Protocol | Beschreibung / Abhängigkeiten                |
| ------------------------| ------------------------------- | ---------- | -------- | ---------------------------------------------|
| **apache**              | serversideup/php:8.4-fpm-apache | 8080, 9000 | HTTP, HTTPS | Webserver, Healthcheck auf 8080           |
| **alloy**               | grafana/alloy:v1.5.1            | 12345      | HTTP     | OpenTelemetry collecter ->ltm                |
| **mimir**               | grafana/mimir:2.14.3            | 9009       | HTTP     | TSDB für Prometheus                          |
| **loki**                | grafana/loki:3.4.1              | 3100       | HTTP     | Log Aggregation                              |
| **tempo**               | grafana/tempo:2.7.0             | 3200, 4317 | HTTP, gRPC | Distributed Tracing Backend                |
| **pyroscope**           | grafana/pyroscope:1.5.0         | 4040       | HTTP     | Profiling Tool                               |
| **mariadb**             | mariadb:latest                  | 3306       | MySQL    | Datenbank                                    |
| **phpfpmexporter**      | hipages/php-fpm_exporter        | 9253       | HTTP     | Exporter für PHP-FPM ( <- apache:9000/status/php-fpm)|
| **apacheexporter**      | bitnami/apache-exporter         | 9117       | HTTP     | Exporter für Apache Status ( <- apache:80) |
| **mysqldexporter**      | prom/mysqld-exporter            | 9104       | HTTP     | Exporter für MariaDB                         |
| **grafana**             | grafana/grafana:12.0.0          | 3000       | HTTP     | Dashboard UI, Healthcheck auf /healthz       |
| **install_dashboard**   | build: images/jb                | —          | —        | jb install, hängt von Grafana ab             |
| **provision-dashboards**| build: images/grizzly           | —          | —        | Dashboard Provisioning mit grr               |
| **watch-dashboards**    | build: images/grizzly           | —          | —        | Beobachtet Dashboards, hängt von install ab  |

### usefull links
- devContainer        → http://localhost:8000
- alloy:12345         → http://localhost:1234
- apache:80         → http://localhost:8080
- modsecurity:8080    → http://localhost:81
- grafana:3000        → http://localhost:3000
- pyroscope:4040      → http://localhost:4040
- apacheexporter:9117 → http://localhost:9117
- phpfpmexporter:9253 → http://localhost:9253