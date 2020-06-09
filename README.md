# NeG - Nomen et Gens

Prerequisites:
- Tomcat >= 7
  - find /etc/tomcat<n> (might also be /usr/share/tomcat)
  - conf/web.xml
    - Find this servlet <servlet-class>org.apache.jasper.servlet.JspServlet</servlet-class>
    - Add parameter `<init-param><param-name>strictQuoteEscaping</param-name><param-value>false</param-value></init-param>`
  - Catalina/localhost/neg.xml (needs to be created)
```
<Context>
    <!-- Mandatory -->
    <Environment name="sqlURL" value="jdbc:mysql://localhost:3306/neg?characterEncoding=utf8" type="java.lang.String"/>
    <Environment name="sqlUser" value="neg" type="java.lang.String"/>
    <Environment name="sqlPassword" value="neg" type="java.lang.String"/>

    <!-- Optional -->
    <Environment name="matomoURL" value="" type="java.lang.String"/>
    <Environment name="matomoSiteId" value="" type="java.lang.String"/>
</Context>
```
- Java >= 1.8.0_77
- MySQL >= 5.7
  - collation-server=utf8_unicode_ci
  - character-set-server=utf8
  - group_concat_max_len = 100000000
  - sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

Build:
- jar -cvf neg.war .
- Deploy 1st time using http://localhost:8080/manager/html
- Update copying neg.war to /var/lib/tomcat/webapps/ and reload via manager (see above)

