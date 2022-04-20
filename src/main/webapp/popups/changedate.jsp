<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {
%>

<jsp:include page="../dosave.jsp">
  <jsp:param name="form" value="handschrift_ueberlieferung" />
  <jsp:param name="ID" value="<%= request.getParameter("ID") %>" />
</jsp:include>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Neuer Eintrag</TITLE>
    <link rel="stylesheet" href="../layout/layout.css" type="text/css">
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY class="popup">
<%
  if (request.getParameter("speichern")==null) {
      out.println("<input type=\"hidden\" name=\"destination\" value=\""+request.getParameter("destination")+"\">");

 %>   <h2>Datum &auml;ndern</h2>
    <form method="POST">
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="Formular" value="handschrift_ueberlieferung"/>
                  <jsp:param name="Datenfeld" value="DatumVon"/>
                </jsp:include>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="Formular" value="handschrift_ueberlieferung"/>
                  <jsp:param name="Datenfeld" value="DatumBis"/>
                </jsp:include>
    <br/><br/>
    <%
     Class.forName( sqlDriver );
    Connection cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      Statement st = cn.createStatement();
    ResultSet rs = st.executeQuery("SELECT handschrift.GehoertGruppe"
                           +" FROM handschrift_ueberlieferung, handschrift WHERE handschrift_ueberlieferung.HandschriftID=handschrift.ID AND handschrift_ueberlieferung.ID = "+request.getParameter("ID")
                           +" ");
    if (rs.next()){// && (rs.getString("GehoertGruppe")==null || rs.getInt("GehoertGruppe")==((Integer) session.getAttribute("GruppeID")).intValue()) ) {

    %>


    <input type="submit" name="speichern" value="speichern">
<%
    }

%>
    </form>
 <%  }
 else{
 out.println("<script type=\"text/javascript\">       ");
  out.println("var selection = opener.document.getElementById('"+request.getParameter("destination")+"');");
  try{  out.println("selection.firstChild.nodeValue='"+request.getParameter("VonJahr") + "(" + request.getParameter("VonJahrhundert")+ ".Jhd)-"+request.getParameter("BisJahr") + "(" + request.getParameter("BisJahrhundert")+ ".Jhd)';");
  }catch(Exception ex){ out.println("selection.firstChild.nodeValue='---';");}
  out.println("window.close();");
 out.println("</script>                                                                       ");

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
