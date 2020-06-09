<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;
%>
</div>
</div>
    <div id="footer">
        <div id="footer-menu">
            <p> <a href="startseite.jsp"> NeG </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/quellenliste"> Quellenliste </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/tagungen"> Tagungen </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/mitglieder"> Mitglieder </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/projekte"> Projekte </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/publikationen"> Publikationen </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/ziele"> Ziele </a>|
            <a href="impressum.jsp"> Impressum </a>
            </p>
        </div>
        <div id="footer-contact">
            <p> <span>Nomen et Gens</span>
                <span>Seminar f&uuml;r mittelalterliche Geschichte</span>
                <span>Eberhard Karls Universit&auml;t T&uuml;bingen</span>
                </p>
            <p>
                <span>Wilhelmstr. 36</span>
                <span>72074 T&uuml;bingen</span>
                <span><strong> <a href="mailto:neg@uni-tuebingen.de"> neg@uni-tuebingen.de</a></strong></span>
            </p>
        </div>
	    <div class="clear"> </div>
    </div>

<%
    String matomoURL = (String)initialContext.lookup("java:comp/env/matomoURL");
    String matomoSiteId = (String)initialContext.lookup("java:comp/env/matomoSiteId");
    if (!"".equals(matomoURL) && !"".equals(matomoSiteId)) {
        %>
            <script>
                var _paq = window._paq || [];
                /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
                _paq.push(['trackPageView']);
                _paq.push(['enableLinkTracking']);
                (function () {
                    var u = "<%=matomoURL%>";
                    _paq.push(['setTrackerUrl', u + 'piwik.php']);
                    _paq.push(['setSiteId', '<%=matomoSiteId%>']);
                    var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
                    g.type = 'text/javascript';
                    g.async = true;
                    g.defer = true;
                    g.src = u + 'piwik.js';
                    s.parentNode.insertBefore(g, s);
                })();
            </script>
        <%
    }
%>