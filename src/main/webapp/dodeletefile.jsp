<%@ page import="java.io.File" isThreadSafe="false" %>
<%@ page import="java.io.FileNotFoundException" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
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
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.suche.html" />
    <div id="form">
      <h2>L&ouml;schen</h2>
<%
  if (request.getParameter("table") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("attribute") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("ID") == null) {
    out.println("Falscher Aufruf!");
  }
  else if (request.getParameter("returnpage") == null) {
    out.println("Falscher Aufruf!");
  }
  else {
    String folder = "";
    if (request.getParameter("table").equals("person")){
      folder = commentFolder_personenkommentar;
    }
    else if (request.getParameter("table").equals("namenkommentar")) {
      folder = commentFolder_namenkommentar;
    }
   /* else if (request.getParameter("table").equals("quelle") && request.getParameter("attribute").equals("QuellenKommentarDatei")) {
      folder = commentFolder_quellenkommentar;
    }
    else if (request.getParameter("table").equals("quelle") && request.getParameter("attribute").equals("UeberlieferungsKommentarDatei")) {
      folder = commentFolder_namenkommentar;
    }*/

    String sql = "SELECT "+request.getParameter("attribute")+" FROM "+request.getParameter("table")+" WHERE ID="+request.getParameter("ID")+";";
    Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery(sql);
      String filename = null;
      if (rs.next()) {
        filename = rs.getString(request.getParameter("attribute"));
      }
      sql = "UPDATE "+request.getParameter("table")+" SET "+request.getParameter("attribute")+"=NULL WHERE ID="+request.getParameter("ID")+";";
      st.execute(sql);
      if ((new File(this.getServletContext().getRealPath("/")+path +"\\"+folder+"\\"+filename)).delete()) {
        out.println("<p>Eintrag "+filename+" erfolgreich gel&ouml;scht!</p>");
      }
    }
    catch (Exception e) {
      out.println(e);
    } 
    finally {
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    out.println("<p><a href=\""+request.getParameter("returnpage")+"?ID="+request.getParameter("ID")+"\">zur&uuml;ck</a></p>");
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
