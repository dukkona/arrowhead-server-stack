#!/bin/bash

#registry sql
echo "db_user=${DEFAULT_DB_ARROWHEAD_USR}" >> app.properties
echo "db_password=${DEFAULT_DB_ARROWHEAD_PSW}" >> app.properties
echo "db_address=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD}" >> app.properties

echo "keystore=config/certificates/serviceregistry.testcloud1.jks" >> app.properties
echo "keystorepass=12345" >> app.properties
echo "keypass=12345" >> app.properties
echo "truststore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "truststorepass=12345" >> app.properties

echo "address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

echo "ping_scheduled=false" >> app.properties

echo "ping_timeout=5000" >> app.properties

echo "ping_interval=60" >> app.properties


echo "ttl_scheduled=false" >> app.properties

echo "ttl_interval=10" >> app.properties

cp app.properties serviceregistry_sql/config
rm app.properties


#logger
# Define the root logger with appender file
echo "log4j.rootLogger=DEBUG, DB" >> log4j.properties

# Database related config
# Define the DB appender
echo "log4j.appender.DB=org.apache.log4j.jdbc.JDBCAppender" >> log4j.properties
# Set Database Driver
echo "log4j.appender.DB.driver=com.mysql.jdbc.Driver" >> log4j.properties
# Set Database URL
echo "log4j.appender.DB.URL=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD_LOG}" >> log4j.properties
# Set database user name and password
echo "log4j.appender.DB.user=${DEFAULT_DB_ARROWHEAD_USR}" >> log4j.properties
echo "log4j.appender.DB.password=${DEFAULT_DB_ARROWHEAD_PSW}" >> log4j.properties
# Set the SQL statement to be executed.
echo "log4j.appender.DB.sql=INSERT INTO logs VALUES(DEFAULT,'%d{yyyy-MM-dd HH:mm:ss}','%C','%p','%m')" >> log4j.properties
# Define the layout for file appender
echo "log4j.appender.DB.layout=org.apache.log4j.PatternLayout" >> log4j.properties
# Disable Hibernate verbose logging
echo "log4j.logger.org.hibernate=fatal" >> log4j.properties

# File related config
# Define the file appender
echo "log4j.appender.FILE=org.apache.log4j.FileAppender" >> log4j.properties
# Set the name of the file
echo "log4j.appender.FILE.File=log4j_log.txt" >> log4j.properties
# Set the immediate flush to true (default)
echo "log4j.appender.FILE.ImmediateFlush=true" >> log4j.properties
# Set the threshold to debug mode
echo "log4j.appender.FILE.Threshold=debug" >> log4j.properties
# Set the append to false, overwrite
echo "log4j.appender.FILE.Append=false" >> log4j.properties
# Define the layout for file appender
echo "log4j.appender.FILE.layout=org.apache.log4j.PatternLayout" >> log4j.properties
echo "log4j.appender.FILE.layout.conversionPattern=%d{yyyy-MM-dd HH:mm:ss}, %C, %p, %m%n" >> log4j.properties

cp log4j.properties serviceregistry_sql/config
cp log4j.properties authorization/config
cp log4j.properties gateway/config
cp log4j.properties eventhandler/config
cp log4j.properties gatekeeper/config
cp log4j.properties orchestrator/config
rm log4j.properties

#authorization
echo "db_user=${DEFAULT_DB_ARROWHEAD_USR}" >> app.properties
echo "db_password=${DEFAULT_DB_ARROWHEAD_PSW}" >> app.properties
echo "db_address=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD}" >> app.properties


echo "keystore=config/certificates/authorization.testcloud1.jks" >> app.properties
echo "keystorepass=12345" >> app.properties
echo "keypass=12345" >> app.properties
echo "truststore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "truststorepass=12345" >> app.properties


echo "address=${AUTHORIZATION_ADRESS}" >> app.properties
echo "insecure_port=${AUTHORIZATION_INSECURE_PORT}" >> app.properties
echo "secure_port=${AUTHORIZATION_SECURE_PORT}" >> app.properties

echo "sr_address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "sr_insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "sr_secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

echo "enable_auth_for_cloud=false" >> app.properties

cp app.properties authorization/config
rm app.properties

#gateway

echo "keystore=config/certificates/gateway.testcloud1.jks" >> app.properties
echo "keystorepass=12345" >> app.properties
echo "keypass=12345" >> app.properties
echo "truststore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "truststorepass=12345" >> app.properties
echo "trustpass=12345" >> app.properties
echo "master_arrowhead_cert=config/certificates/master_arrowhead_cert.crt" >> app.properties


# Webserver parameters
echo "address=${GATEWAY_ADRESS}" >> app.properties
echo "insecure_port=${GATEWAY_INSECURE_PORT}" >> app.properties
echo "secure_port=${GATEWAY_SECURE_PORT}" >> app.properties

# Service Registry
echo "sr_address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "sr_insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "sr_secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

# Socket openings port range
echo "min_port=8000" >> app.properties
echo "max_port=8100" >> app.properties

cp app.properties gateway/config
rm app.properties


#event-handler
# Database parameters
echo "db_user=${DEFAULT_DB_ARROWHEAD_USR}" >> app.properties
echo "db_password=${DEFAULT_DB_ARROWHEAD_PSW}" >> app.properties
echo "db_address=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD}" >> app.properties

# Certificate related paths and passwords
echo "keystore=config/certificates/eventhandler.testcloud1.jks" >> app.properties
echo "keystorepass=12345" >> app.properties
echo "keypass=12345" >> app.properties
echo "truststore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "truststorepass=12345" >> app.properties


# Webserver parameters
echo "address=${EVENTHANDLER_ADRESS}" >> app.properties
echo "insecure_port=${EVENTHANDLER_INSECURE_PORT}" >> app.properties
echo "secure_port=${EVENTHANDLER_SECURE_PORT}" >> app.properties

# Service Registry
echo "sr_address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "sr_insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "sr_secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

# Publishing tolerance: clients can publish events with timestamps X number of minutes before the current time (but not with older timestamps)
# 0 means the tolerance is infinite (events can be published with any timestamp from the past)
echo "event_publishing_tolerance=60" >> app.properties

# Removing old filters from the database based on the endDate field
echo "remove_old_filters=false" >> app.properties
# DB check interval in minutes
echo "check_interval=60" >> app.properties

cp app.properties eventhandler/config
rm app.properties


#gatekeeper
# Database parameters
echo "db_user=${DEFAULT_DB_ARROWHEAD_USR}" >> app.properties
echo "db_password=${DEFAULT_DB_ARROWHEAD_PSW}" >> app.properties
echo "db_address=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD}" >> app.properties

# Certificate related paths and passwords
echo "gatekeeper_keystore=config/certificates/gatekeeper.testcloud1.jks" >> app.properties
echo "gatekeeper_keystore_pass=12345" >> app.properties
echo "gatekeeper_keypass=12345" >> app.properties
echo "cloud_keystore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "cloud_keystore_pass=12345" >> app.properties
echo "cloud_keypass=12345" >> app.properties
echo "master_arrowhead_cert=config/certificates/master_arrowhead_cert.crt" >> app.properties

# Webserver parameters
echo "address=${GATEKEEPER_ADRESS}" >> app.properties
echo "internal_insecure_port=${GATEKEEPER_INTERNAL_INSECURE_PORT}" >> app.properties
echo "internal_secure_port=${GATEKEEPER_INTERNAL_SECURE_PORT}" >> app.properties
echo "external_insecure_port=${GATEKEEPER_EXTERNAL_INSECURE_PORT}" >> app.properties
echo "external_secure_port=${GATEKEEPER_EXTERNAL_SECURE_PORT}" >> app.properties

# Service Registry
echo "sr_address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "sr_insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "sr_secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

# Orchestrator
echo "orch_address=${ORCHESTRATOR_ADRESS}" >> app.properties
echo "orch_insecure_port=${ORCHESTRATOR_INSECURE_PORT}" >> app.properties
echo "orch_secure_port=${ORCHESTRATOR_SECURE_PORT}" >> app.properties

# Other
echo "timeout=30000" >> app.properties
echo "use_gateway=false" >> app.properties

cp app.properties gatekeeper/config
rm app.properties

#orchestrator
# Database parameters
echo "db_user=${DEFAULT_DB_ARROWHEAD_USR}" >> app.properties
echo "db_password=${DEFAULT_DB_ARROWHEAD_PSW}" >> app.properties
echo "db_address=jdbc:mysql://${MY_SQL_SERVICE_ADRESS}:${MY_SQL_SERVER_TARGET_PORT}/${DB_ARROWHEAD}" >> app.properties


# Certificate related paths and passwords
echo "keystore=config/certificates/orchestrator.testcloud1.jks" >> app.properties
echo "keystorepass=12345" >> app.properties
echo "keypass=12345" >> app.properties
echo "truststore=config/certificates/testcloud1_cert.jks" >> app.properties
echo "truststorepass=12345" >> app.properties

# Webserver parameters
echo "address=${ORCHESTRATOR_ADRESS}" >> app.properties
echo "insecure_port=${ORCHESTRATOR_INSECURE_PORT}" >> app.properties
echo "secure_port=${ORCHESTRATOR_SECURE_PORT}" >> app.properties

# Service Registry
echo "sr_address=${SERVICE_REGISTRY_ADRESS}" >> app.properties
echo "sr_insecure_port=${SERVICE_REGISTRY_INSECURE_PORT}" >> app.properties
echo "sr_secure_port=${SERVICE_REGISTRY_SECURE_PORT}" >> app.properties

cp app.properties orchestrator/config
rm app.properties
