opentel erweiterung in php -> for what exaclty ? it neeeds it 🤷‍♀️


pecl install opentelemetry
-> php.ini
[opentelemetry]
extension=opentelemetry.so
Keepsuit Laravel OpenTelemetry or  Spatie Laravel OpenTelemetry

| Feature             | Spatie Laravel OpenTelemetry | Keepsuit Laravel OpenTelemetry        |
| ------------------- | ---------------------------- | ------------------------------------- |
| Fokus               | Tracing                      | Tracing + Metrics + Logs              |
| Einfachheit         | Sehr einfach zu integrieren  | Etwas komplexer, mächtiger            |
| Grafana Integration | Über Traces zu Tempo/Jaeger  | Metrics → Prometheus + Traces → Tempo |
| Community & Support | Größer, etablierter          | Kleinere, aber wachsende Community    |
| Perfekt für         | Schnelle Tracing-Integration | Vollständige Observability-Plattform  |



-> notes waf

MODSEC_AUDIT_ENGINE=RelevantOnly
MODSEC_AUDIT_LOG=/dev/stdout
MODSEC_AUDIT_LOG_FORMAT=JSON
MODSEC_AUDIT_LOG_PARTS=ABIJDEFHZ
MODSEC_AUDIT_LOG_RELEVANT_STATUS='^(?:5|4(?!04))'
MODSEC_AUDIT_LOG_TYPE=Serial

##
$ pip install --user tmuxp