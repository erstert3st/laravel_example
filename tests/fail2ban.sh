#!/usr/bin/env bash

curl http://localhost:8080/nonexistent.php
curl http://localhost:8080/test.exe
curl http://localhost:8080/test.php
curl http://localhost:8080/test.cgi
curl http://localhost:8080/fake.cgi
curl http://localhost:8080/fake.pl
curl http://localhost:8080/doesnotexist.pl
curl http://localhost:8080/nonexistent.php
curl http://localhost:8080/test.exe
curl http://localhost:8080/test.php
curl http://localhost:8080/test.cgi
curl http://localhost:8080/fake.cgi
curl http://localhost:8080/fake.pl
curl http://localhost:8080/doesnotexist.pl
curl http://localhost:8080/nonexistent.php
curl http://localhost:8080/test.exe
curl http://localhost:8080/test.php
curl http://localhost:8080/test.cgi
curl http://localhost:8080/fake.cgi
curl http://localhost:8080/fake.pl
curl http://localhost:8080/doesnotexist.pl


# docker exec fail2ban fail2ban-client status
# docker exec fail2ban  fail2ban-client status
# docker exec fail2ban fail2ban-client status  apache-noscript

# sudo fail2ban-client set apache-noscript banip 194.166.34.36