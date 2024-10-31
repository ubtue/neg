<%@ include file="configuration.jsp" %>
<%
    String matomoURL = (String)initialContext.lookup("java:comp/env/matomoURL");
    String matomoSiteId = (String)initialContext.lookup("java:comp/env/matomoSiteId");
    String frontendType = request.getParameter("frontendType");
    if (!"".equals(matomoURL) && !"".equals(matomoSiteId)) {
        %>
            <script>
                var _paq = window._paq || [];
                /* tracker methods like "setCustomDimension" should be called before "trackPageView" */
                _paq.push(['setCustomVariable','1','FrontendType','<%=frontendType%>', 'page']);
                _paq.push(['disableCookies']);
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
