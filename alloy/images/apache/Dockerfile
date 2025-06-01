FROM serversideup/php:8.4-fpm-apache
# serversideup/php:8.4-fpm-alpine
# ModSecurity installieren
USER root
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
COPY modsecurity.conf /etc/modsecurity/
COPY rules/ /etc/modsecurity/rules/

# Include-Konfiguration in Apache einbinden
RUN echo "IncludeOptional /etc/modsecurity/modsecurity.conf" >> /etc/apache2/apache2.conf 
### og
RUN chown -R www-data:www-data /run

USER www-data
EXPOSE 8080 8443
ENTRYPOINT ["docker-php-serversideup-entrypoint"]

# Set stop signal to SIGQUIT for a graceful shutdown instead of S6's preferred SIGTERM (https://github.com/just-containers/s6-overlay/issues/586)
STOPSIGNAL SIGQUIT
WORKDIR /var/www/html
CMD ["/init"]
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD [ "sh", "-c", "curl --insecure --silent --location --show-error --fail http://localhost:8080$HEALTHCHECK_PATH || exit 1" ]