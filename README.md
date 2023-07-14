# NeG - Nomen et Gens

You can also have a look at the installation example in the docker subdirectory.

Prerequisites:
- System
  - Tomcat 9 / Ubuntu (for automated build process). WAR-file should work with Tomcat >= 7.
  - find /etc/tomcat<n> (might also be /usr/share/tomcat)
  - conf/web.xml
    - Find this servlet <servlet-class>org.apache.jasper.servlet.JspServlet</servlet-class>
    - Add parameter `<init-param><param-name>strictQuoteEscaping</param-name><param-value>false</param-value></init-param>`
  - Catalina/localhost/neg.xml (needs to be created with correct user credentials)
```
<Context>
    <!-- Mandatory -->
    <Environment name="sqlURL" value="jdbc:mysql://localhost:3306/neg?characterEncoding=utf8" type="java.lang.String"/>
    <Environment name="sqlUser" value="neg" type="java.lang.String"/>
    <Environment name="sqlPassword" value="neg" type="java.lang.String"/>

    <!-- Optional -->
    <Environment name="matomoURL" value="" type="java.lang.String"/>
    <Environment name="matomoSiteId" value="" type="java.lang.String"/>

    <!-- Mail -->
    <Environment name="smtpHost" value="smtpserv.uni-tuebingen.de" type="java.lang.String"/>
    <Environment name="smtpPort" value="587" type="java.lang.String"/>
    <Environment name="smtpUser" value="exampleUser" type="java.lang.String"/>
    <Environment name="smtpPassword" value="examplePassword" type="java.lang.String"/>
</Context>
```
- Java >= 1.8.0_77
- MySQL >= 5.7
  - collation-server = utf8_unicode_ci
  - character-set-server = utf8mb4
  - group_concat_max_len = 100000000
  - log_bin_trust_function_creators = 1
  - sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
  - (please note that NO_AUTO_CREATE_USER has been deprecated & can be omitted in newer SQL Versions)
  - If you use MariaDB, also use the following settings to avoid performance problems, especially in search queries (this works for MyISAM but should be tested again when migrating to InnoDB):
    - optimizer_switch="derived_merge=off,derived_with_keys=off"
    - see also: https://stackoverflow.com/questions/35889706/mariadb-running-a-left-join-query-100-times-slower-than-mysql

For servers (ZDV):
- MySQL
    - Make sure you change the db user passwords to something safe.
    - if you want to install neg-dmp on a separate machine and access the mysql db in this instance,
      you also have to change the host for the user and prevent it to be bound to localhost (e.g. disable bind-address and mysqlx-bind-address in mysqld.cnf).
    - [client]
        default-character-set = utf8mb4
      [mysqld]
        character-set-server = utf8mb4
        collation-server = utf8mb4_unicode_ci
      [mysql]
        default-character-set = utf8mb4
- Tomcat
    - if tomcat installation fails, contact ZDV admin (workaround for default group 100).
    - change tomcat ports to 80+443
    - instead of Catalina/localhost/neg.xml:
        - move settings to server.xml Host section
            - avoid access via /neg in url
            - also we can have more tools like e.g. alignment on the same server. we should put it to server.xml so we can have an alternative version for server maintenance which will also disable all other software. This would not be possible if we split the configuration into multiple files in Catalina/localhost (which might be easier for development systems).
        - Also add these attributes to <Context path="" docBase="neg"></Context>
            - Note that reloadable="true" can also be added for development machines, but it is not recommended in production
    - don't forget the SSL certificate
    - make sure you use the correct matomoSiteId
- Firewall
    - adjust firewall scripts, see /zdv-system/scripts/ipt
- Backup
    - for backups, make sure bacula is installed correctly and there is also a mysqldump cronjob

Build:
- Use build-function in netbeans (.war file see target/ dir)
- Deploy 1st time using http://localhost:8080/manager/html
- Update copying neg.war to /var/lib/tomcat/webapps/ and removing the old unpacked neg/ subdirectory
- Make sure the file /var/lib/tomcat9/conf/Catalina/localhost/neg.xml exists

Production:
- https://wiki.owasp.org/index.php/Securing_tomcat

