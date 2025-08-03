# This POC is made for learning purposes only!

trigger waf
-> curl "http://localhost:81/?q=<script>alert('xss')</script>"

docker compose down --remove-orphans --volumes

This POC includes GeoLite2 Data created by MaxMind available from https://www.maxmind.com