<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.controller.AdminController" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.DeleteHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (AuthHelper.isBenutzerLogin(request)) {
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
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.suche.html" />
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
    if(DeleteHelper.deleteEntity(request,response,out)){
        out.println("<p>Eintrag erfolgreich gel&ouml;scht!</p>");
    }else{
        out.println("<p>Fehler beim l&ouml;schen!</p>");
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
