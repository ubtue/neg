#!/bin/bash
# start mysqld_safe as last process, because it doesnt run in background
# if nothing runs in foreground, docker container will stop!
mysqld --daemonize
/usr/share/tomcat9/bin/catalina.sh run
