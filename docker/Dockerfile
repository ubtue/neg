FROM ubuntu:focal
LABEL maintainer="NPPM Team <nppm-team@ub.uni-tuebingen.de>"

# Set non-interactive mode for UBUNTU to avoid interruptions
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install dependencies
RUN apt-get --yes update
RUN apt-get --yes install mysql-server openjdk-11-jre tomcat9

# MySQL configuration
RUN echo "collation-server = utf8_unicode_ci" >> /etc/mysql/mysql.conf.d/mysqld.cnf
RUN echo "character-set-server = utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf
RUN echo "group_concat_max_len = 100000000" >> /etc/mysql/mysql.conf.d/mysqld.cnf
RUN echo "sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# MySQL DB + user
COPY resources/schema.sql /schema.sql
RUN mysqld --daemonize && echo "CREATE DATABASE neg;" | mysql
RUN mysqld --daemonize && cat /schema.sql | mysql neg
RUN mysqld --daemonize && echo "CREATE USER 'neg'@'localhost' IDENTIFIED BY 'neg';" | mysql
RUN mysqld --daemonize && echo "GRANT ALL PRIVILEGES ON neg.* TO 'neg'@'localhost';" | mysql
RUN mysqld --daemonize && echo "FLUSH PRIVILEGES;" | mysql

# tomcat configuration & app
ENV CATALINA_HOME=/usr/share/tomcat9
ENV CATALINA_BASE=/var/lib/tomcat9
ENV CATALINA_TMPDIR=/tmp
RUN sed -i 's/<servlet-class>org.apache.jasper.servlet.JspServlet<\/servlet-class>/<servlet-class>org.apache.jasper.servlet.JspServlet<\/servlet-class><init-param><param-name>strictQuoteEscaping<\/param-name><param-value>false<\/param-value><\/init-param>/g' /etc/tomcat9/web.xml
COPY resources/neg.xml /etc/tomcat9/Catalina/localhost/neg.xml
COPY resources/neg.war /var/lib/tomcat9/webapps/neg.war
EXPOSE 8080

# start services when container is run
COPY resources/startup.sh /startup.sh
CMD [ "/startup.sh" ]
