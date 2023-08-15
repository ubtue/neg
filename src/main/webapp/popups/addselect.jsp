<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {
%>
<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Neuer Eintrag</TITLE>
    <link rel="stylesheet" href="../layout/layout.css" type="text/css">
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY class="popup">
<%
  if (request.getParameter("action") == null && request.getParameter("selektion") != null) {
    out.println("<h2>Neuer Eintrag</h2>");
    out.println("<p>Neuen Eintrag f&uuml;r die Selektion \""+request.getParameter("selektion")+"\" anlegen</p>");
    out.println("<form method=\"POST\">");
    out.println("<input type=\"hidden\" name=\"action\" value=\"save\">");
    out.println("<input type=\"hidden\" name=\"selektion\" value=\""+request.getParameter("selektion")+"\">");
    out.println("<input type=\"text\" name=\"neuerEintrag\" size=\"50\">");
    out.println("<br/><br/>");
    out.println("<input type=\"submit\" value=\"eintragen\">");
    out.println("</form>");
  }
  else if (request.getParameter("action").equals("save")) {
    int newID = -1;
    Connection cn = null;
    Statement  st = null;
    ResultSet rs = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );

      Statement st2 = cn.createStatement();
      ResultSet rs2 = st2.executeQuery("Select max(ID) as max from selektion_"+request.getParameter("selektion"));
      rs2.next();
      int id = rs2.getInt("max") + 1;
//      out.println(id);
      Statement st3 = cn.createStatement();
      ResultSet rs3 = st3.executeQuery("Select * from selektion_"+request.getParameter("selektion") + " where Bezeichnung='"+DBtoDB(request.getParameter("neuerEintrag"))+"'");

    if(!rs3.next()){String sql = "INSERT INTO selektion_"+request.getParameter("selektion")+" (ID, Bezeichnung) VALUES ('"+id+"','"+DBtoDB(request.getParameter("neuerEintrag"))+"');";
      // Neuen Wert eintragen
      st = cn.createStatement();
      st.execute(sql);}

      // Neue ID aus DB abfragen
      st = cn.createStatement();
      rs = st.executeQuery("SELECT ID FROM selektion_"+request.getParameter("selektion")+ " WHERE Bezeichnung = '"+DBtoDB(request.getParameter("neuerEintrag"))+"';");
      if (rs.next()) {
        newID = rs.getInt("ID");
      }
      out.println("<p>"+request.getParameter("neuerEintrag")+" erfolgreich in die Selektion "+request.getParameter("selektion")+" eingetragen.</p>");
    }
    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    out.println("<input type=\"button\" value=\"&uuml;bernehmen &amp; Fenster schlie&szlig;en\" onClick=\"javascript:addSelection("+newID+", '"+DBtoJS(request.getParameter("neuerEintrag"))+"', '"+request.getParameter("destination")+"');window.close();\">");
  }
%>
  </BODY>
</HTML>
<%
  }
  else {
    out.println("<p>Zugriff nicht erlaubt!!!</p>");
    out.println("<a href=\"../index.jsp\">Zur&uuml;ck zur Startseite</a>");
  }
%>
