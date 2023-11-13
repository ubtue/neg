<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>

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
  } else if (request.getParameter("action").equals("save")) {

    int newID = -1;

    SelektionBezeichnung existing = SelektionDB.getByBezeichnung("selektion_" +request.getParameter("selektion"), request.getParameter("neuerEintrag"));

    if(existing != null) {
      newID = existing.getId();
    } else {
      // Neuen Wert eintragen
      SelektionDB.insertBezeichnung("selektion_" + request.getParameter("selektion"), request.getParameter("neuerEintrag"));

      // Neue ID aus DB abfragen
      existing = SelektionDB.getByBezeichnung("selektion_" + request.getParameter("selektion"), request.getParameter("neuerEintrag"));
      if (existing != null) {
        newID = existing.getId();
      }
      out.println("<p>"+request.getParameter("neuerEintrag")+" erfolgreich in die selektion_"+request.getParameter("selektion")+" eingetragen.</p>");
    }
    out.println("<input type=\"button\" value=\"&uuml;bernehmen &amp; Fenster schlie&szlig;en\" onClick=\"javascript:addSelection("+newID+", '"+DBtoJS(request.getParameter("neuerEintrag"))+"', '"+request.getParameter("destination")+"');window.close();\">");
  } else {
    out.println("<p>Zugriff nicht erlaubt!!!</p>");
    out.println("<a href=\"../index.jsp\">Zur&uuml;ck zur Startseite</a>");
  }
}
%>
  </BODY>
</HTML>