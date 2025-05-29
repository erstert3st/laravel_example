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
