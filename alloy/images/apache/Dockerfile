FROM serversideup/php:8.4-fpm-apache
#https://github.com/serversideup/docker-php/blob/main/src/variations/fpm-apache/Dockerfile
#TODO make all confs loadable in one folder as volume or configmap
# serversideup/php:8.4-fpm-alpine
# ModSecurity installieren
ENV MODSEC_AUDIT_ENGINE="RelevantOnly" \
MODSEC_AUDIT_LOG_FORMAT=JSON \
MODSEC_AUDIT_LOG_TYPE=Serial \
MODSEC_AUDIT_LOG=/dev/stdout \
MODSEC_AUDIT_LOG_PARTS='ABIJDEFHZ' \
MODSEC_AUDIT_STORAGE=/var/log/modsecurity/audit/ \
MODSEC_DATA_DIR=/tmp/modsecurity/data \
MODSEC_DEBUG_LOG=/dev/null \
MODSEC_DEBUG_LOGLEVEL=0 \
MODSEC_DEFAULT_PHASE1_ACTION="phase:1,pass,log,tag:'\${MODSEC_TAG}'" \
MODSEC_DEFAULT_PHASE2_ACTION="phase:2,pass,log,tag:'\${MODSEC_TAG}'" \
MODSEC_DISABLE_BACKEND_COMPRESSION="Off" \
MODSEC_PCRE_MATCH_LIMIT_RECURSION=500000 \
MODSEC_PCRE_MATCH_LIMIT=500000 \
MODSEC_REQ_BODY_ACCESS=on \
MODSEC_REQ_BODY_LIMIT=13107200 \
MODSEC_REQ_BODY_LIMIT_ACTION="Reject" \
MODSEC_REQ_BODY_JSON_DEPTH_LIMIT=512 \
MODSEC_REQ_BODY_NOFILES_LIMIT=131072 \
MODSEC_RESP_BODY_ACCESS=on \
MODSEC_RESP_BODY_LIMIT=1048576 \
MODSEC_RESP_BODY_LIMIT_ACTION="ProcessPartial" \
MODSEC_RESP_BODY_MIMETYPE="text/plain text/html text/xml" \
MODSEC_RULE_ENGINE=on \
MODSEC_STATUS_ENGINE="Off" \
MODSEC_TAG=modsecurity \
MODSEC_TMP_DIR=/tmp/modsecurity/tmp \
MODSEC_TMP_SAVE_UPLOADED_FILES="on" \
MODSEC_UPLOAD_DIR=/tmp/modsecurity/upload \

USER root
RUN apt-get update && \
    apt-get install -y libapache2-mod-security2 --no-install-recommends --no-install-suggests && \
    apt-get clean

# Standardkonfig übernehmen und aktivieren
# RUN cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf && \
    # sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf

# ModSecurity aktivieren in Apache
RUN a2enmod security2

# Optional: OWASP Core Rule Set hinzufügen
COPY crs-setup.conf /etc/modsecurity/crs/crs-setup.conf
COPY modsecurity.conf /etc/modsecurity/modsecurity.conf
COPY rules/ /etc/modsecurity/rules/

# Include-Konfiguration in Apache einbinden
RUN echo "IncludeOptional /etc/modsecurity/modsecurity.conf" >> /etc/apache2/apache2.conf 
RUN set -eux; \
    mkdir -p /tmp/modsecurity/data; \
    mkdir -p /tmp/modsecurity/upload; \
    mkdir -p /tmp/modsecurity/tmp; \
    chown -R www-data:www-data /tmp/modsecurity/data /run;
    # mkdir -p /var/log/apache2; \



### og
# RUN chown -R www-data:www-data /run

USER www-data
EXPOSE 8080 8443
ENTRYPOINT ["docker-php-serversideup-entrypoint"]

# Set stop signal to SIGQUIT for a graceful shutdown instead of S6's preferred SIGTERM (https://github.com/just-containers/s6-overlay/issues/586)
STOPSIGNAL SIGQUIT
WORKDIR /var/www/html
CMD ["/init"]
HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD [ "sh", "-c", "curl --insecure --silent --location --show-error --fail http://localhost:8080$HEALTHCHECK_PATH || exit 1" ]