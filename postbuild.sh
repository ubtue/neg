#!/bin/bash

# Auto-Migrate from Java EE to Jakarta EE
TMP_DIR=/tmp
JAR_URL_MIGRATION_TOOL="https://dlcdn.apache.org/tomcat/jakartaee-migration/v1.0.10/binaries/jakartaee-migration-1.0.10-shaded.jar"
JAR_FILE_MIGRATION_TOOL="$TMP_DIR/jakartaee-migration-1.0.10-shaded.jar"
WAR_FILE_TOMCAT="/var/lib/tomcat10/webapps/nppm.war"
WAR_FILE_TMP_JAVAEE="$TMP_DIR/nppm.javaee.war"
WAR_FILE_TMP_JAKARTAEE="$TMP_DIR/nppm.jakartaee.war"

if [ ! -f "$JAR_FILE_MIGRATION_TOOL" ]; then
    wget "$JAR_URL_MIGRATION_TOOL" -O "$JAR_FILE_MIGRATION_TOOL"
fi
cp "$WAR_FILE_TOMCAT" /tmp/nppm.javaee.war
java -jar "$JAR_FILE_MIGRATION_TOOL" "$WAR_FILE_TMP_JAVAEE" "$WAR_FILE_TMP_JAKARTAEE"
cp "$WAR_FILE_TMP_JAKARTAEE" "$WAR_FILE_TOMCAT"

# Restart Tomcat
systemctl restart tomcat10
