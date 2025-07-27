docker compose --profile=alloy up --build -d


trigger waf
-> curl "http://localhost:81/?q=<script>alert('xss')</script>"

docker compose down --remove-orphans --volumes