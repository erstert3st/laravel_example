#!/usr/bin/env bash

./apache.sh
./fail2ban.sh
./modsec.sh

docker exec fail2ban fail2ban-client status
docker exec fail2ban  fail2ban-client status
docker exec fail2ban fail2ban-client status  apache-noscript