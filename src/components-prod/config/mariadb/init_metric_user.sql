--CREATE USER IF NOT EXISTS 'metrics'@'%' IDENTIFIED BY 'metricspass' WITH MAX_USER_CONNECTIONS 3;
--GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'metrics'@'%';
--https://github.com/prometheus/mysqld_exporter/issues/640
CREATE USER IF NOT EXISTS 'exporter'@'%' IDENTIFIED BY 'XXXXXXXX' WITH MAX_USER_CONNECTIONS 3;
GRANT  PROCESS, REPLICATION CLIENT, REPLICATION SLAVE, SLAVE MONITOR, SELECT ON *.* TO 'exporter'@'%';

FLUSH PRIVILEGES;

--init.d would be better 
--init.d would be better 