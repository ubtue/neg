<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - L&ouml;schen</TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.jsp" />
    <jsp:include page="layout/titel.suche.jsp" />
    <div id="form">
      <h2>L&ouml;schen</h2>
<%
  if (request.getParameter("table") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("ID") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("returnpage") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("returnid") == null) {
    out.println("Falscher Aufruf!");
  }
  else {
    String sql = "DELETE FROM "+request.getParameter("table")+" WHERE ID="+request.getParameter("ID")+";";
    Connection cn = null;
    Statement  st = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      st.execute(sql);
      out.println("<p>Eintrag erfolgreich gel&ouml;scht!</p>");
    }
    catch (Exception e) {
      out.println(e);
    } 
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    
 out.println("<script type=\"text/javascript\">window.setTimeout(location.replace('"+request.getParameter("returnpage")+"?ID="+request.getParameter("returnid")+"'),1000)</script>");
    
  }
%>
    </div>
  </BODY>
</HTML>
<%
  }
  else {
    out.println("<p>Zugriff nicht erlaubt!!!</p>");
    out.println("<a href=\"index.jsp\">Zur&uuml;ck zur Startseite</a>");
  }
%>
