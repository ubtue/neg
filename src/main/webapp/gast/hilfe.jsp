<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  Language.setLanguage(request);
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

                              session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");
    int id = -1;
    int filter = 0;
    String formular = "einfache_suche";
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens -
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="freie_suche"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link rel="stylesheet" href="layout/help.css" type="text/css">
    <link href='layout/fonts/open-sans.css' rel='stylesheet' type='text/css'>
    <link href='layout/fonts/alegreya-sans-sc.css' rel='stylesheet' type='text/css'>
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>

 </HEAD>

  <BODY>

    <jsp:include page="layout/header.inc.jsp">
      <jsp:param name="current" value=""/>
    </jsp:include>


          <div id="content">

    <jsp:include page="hilfe.html" />

    </div>
      </BODY>
</HTML>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
