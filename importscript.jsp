<%@ page import="java.io.File" isThreadSafe="false" %>
<%@ page import="java.io.FileNotFoundException" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Scanner" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Import</TITLE>
    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <h1>Import-Script</h1>
    <h2>Automatische Tabellen</h2>
    <table border=2 cellpadding=5 cellspacing=0>
      <tr>
        <th>Tabelle</th>
        <th>#Datens&auml;tze</th>
        <th>Zieltabelle erstellen</th>
        <th>Zieltabelle leeren</th>
        <th>Daten importieren</th>
      </tr>
<%
  Scanner sc = null;
  try {
    sc = new Scanner(new File(tblFile));
    while (sc.hasNextLine()) {
      String tbl = sc.nextLine();
      out.println("<tr>");
      out.println("<td>"+tbl+"</td>");
      out.println("<td>");
      Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT count(*) c FROM "+tbl);
        if ( rs.next() ) {
          out.println(rs.getInt("c"));
        }
      } catch (SQLException e) {
        out.println("---");
      } finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
      out.println("</td>");
      out.println("<td><a href=\"doimport.jsp?operation=create&tabelle="+tbl+"\">erstellen</a>");
      out.println("<td><a href=\"doimport.jsp?operation=empty&tabelle="+tbl+"\">leeren</a>");
      out.println("<td><a href=\"doimport.jsp?operation=import&tabelle="+tbl+"\">importieren</a>");
      out.println("</tr>");
    }


  } catch (FileNotFoundException e) {
    out.println("Datei nicht gefunden!<br>"+e);
  }
%>
    </table>
    <hr>
    <h2>Bemerkungen</h2>
    <table border=2 cellpadding=5 cellspacing=0>
      <tr>
        <th>Quelltabelle</th>
        <th>#Datens&auml;tze</th>
        <th>Zieltabelle leeren</th>
        <th>Daten importieren</th>
      </tr>
<%
      String[] formulare = {"einzelbeleg", "person", "quelle", "edition", "handschrift", "namenkommentar", "literatur" };
      for (int i=0; i< formulare.length; i++) {
        out.println("<tr>");
        out.println("<td>"+formulare[i]+"</td>");
        out.println("<td>");
        Connection cn = null;
        Statement st = null;
        ResultSet rs = null;
        try {
          Class.forName( sqlDriver );
          cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
          st = cn.createStatement();
          rs = st.executeQuery("SELECT count(*) c FROM bemerkung WHERE "+formulare[i]+"ID IS NOT NULL");
          if ( rs.next() ) {
            out.println(rs.getInt("c"));
          }
        } catch (SQLException e) {
          out.println("---");
        } finally {
          try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
          try { if( null != st ) st.close(); } catch( Exception ex ) {}
          try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
        }
        out.println("</td>");
        out.println("<td></td>");
        out.println("<td><a href=\"doimport.jsp?operation=importcomment&tabelle="+formulare[i]+"\">importieren</a></td>");
        out.println("</tr>");
      }
%>
    </table>
    <hr>
    <h2>Bereinigungen</h2>
    <table border=2 cellpadding=5 cellspacing=0>
      <tr>
        <th>Aktion</th>
        <th>ausf&uuml;hren</th>
      </tr>
      <tr>
        <td>'null' zu NULL konvertieren</td>
        <td><a href="doimport.jsp?operation=nulltonull">ausf&uuml;hren</a></td>
      </tr>
      <tr>
        <td>'' zu NULL konvertieren</td>
        <td><a href="doimport.jsp?operation=emptytonull">ausf&uuml;hren</a></td>
      </tr>
      <tr>
        <td>Benutzerverkn&uuml;pfungen bereinigen</td>
        <td><a href="doimport.jsp?operation=userlinks">ausf&uuml;hren</a></td>
      </tr>
      <tr>
        <td>Gruppenbeschr&auml;nkungen aktualisieren</td>
        <td><a href="doimport.jsp?operation=boundtogroups">ausf&uuml;hren</a></td>
      </tr>
      <tr>
        <td>verwendete Edition bei Einzelbelegen aus Quellen für die nur diese Edition existiert festlegen</td>
        <td><a href="doimport.jsp?operation=editions">ausf&uuml;hren</a></td>
      </tr>
      <tr>
        <td>Jahrhunderte aus Jahreszahlen generieren</td>
        <td><a href="doimport.jsp?operation=generatejahrhundert">ausf&uuml;hren</a></td>
      </tr>
    </table>
    <hr>
    <h2>Defaultwerte</h2>
    <p><a href="doimport.jsp?operation=adddefaults">ausf&uuml;hren</a></p>
  </BODY>
</HTML>

