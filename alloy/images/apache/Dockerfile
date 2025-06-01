FROM serversideup/php:8.4-fpm-apache

# ModSecurity installieren
RUN apt-get update && \
    apt-get install -y libapache2-mod-security2 && \
    apt-get clean

# Standardkonfig übernehmen und aktivieren
RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf && \
    sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf

# ModSecurity aktivieren in Apache
RUN a2enmod security2

# Optional: OWASP Core Rule Set hinzufügen
COPY crs-setup.conf /etc/modsecurity/
COPY rules/ /etc/modsecurity/rules/

# Include-Konfiguration in Apache einbinden
RUN echo "IncludeOptional /etc/modsecurity/modsecurity.conf" >> /etc/apache2/apache2.conf && \
    echo "IncludeOptional /etc/modsecurity/crs-setup.conf" >> /etc/apache2/apache2.conf && \
    echo "IncludeOptional /etc/modsecurity/rules/*.conf" >> /etc/apache2/apache2.conf
