﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<jsp:include page="dolanguage.jsp" />

<%
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
      && ((Boolean) session.getAttribute("Administrator")).booleanValue()
     ) {
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Administration</TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
     <link rel="stylesheet" href="mktree.css" type="text/css">
    <script type="text/javascript" src="mktree.js"></script>
    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.administration.jsp" />

    <div id="form">
      <div id="tab1">
        <div id="header">
          <ul id="primary">
            <li><span>Benutzer verw.</span></li>
            <li><a href="javascript:onoff('tab2','tab1');">neuer Benutzer</a></li>
            <li><a href="javascript:onoff('tab3','tab1');">Auswahlfelder</a></li>
          </ul>
        </div>
        <div id="main">
          <jsp:include page="administration/list.benutzer.jsp" />
        </div>
      </div>

      <div id="tab2">
        <div id="header">
          <ul id="primary">
            <li><a href="javascript:onoff('tab1','tab2');">Benutzer verw.</a></li>
            <li><span>neuer Benutzer</span></li>
            <li><a href="javascript:onoff('tab3','tab2');">Auswahlfelder</a></li>
          </ul>
        </div>
        <div id="main">
          <FORM method="POST" action="admin.benutzer.neu.jsp">
            <input type="hidden" name="action" value="benutzer.neu">
            <table>
              <tr>
                <td width="200"><label for="Benutzername">Benutzername:</label></td>
                <td width="450"><input name="Benutzername" size="25" maxlength="255"></td>
              </tr>
              <tr>
                <td width="200"><label for="Nachname">Nachname:</label></td>
                <td width="450"><input name="Nachname" size="25" maxlength="255"></td>
              </tr>
              <tr>
                <td width="200"><label for="Vorname">Vorname:</label></td>
                <td width="450"><input name="Vorname" size="25" maxlength="255"></td>
              </tr>
              <tr>
                <td width="200"><label for="EMail">E-Mail:</label></td>
                <td width="450"><input name="EMail" size="25" maxlength="255"></td>
              </tr>
              <tr>
                <td width="200"><label for="Kennwort">Kennwort:</label></td>
                <td width="450"><input name="Kennwort" size="25" maxlength="255"></td>
              </tr>
              <tr>
                <td width="200"><label for="Projektgruppe">Projektgruppe</label></td>
                <td width="450">
                  <jsp:include page="administration/select.jsp">
                    <jsp:param name="Tabelle" value="benutzer_gruppe" />
                    <jsp:param name="Feldname" value="Projektgruppe" />
                  </jsp:include>
                </td>
              </tr>
              <tr>
                <td width="200"><label for="Sprache">Sprache</label></td>
                <td width="450">
                  <jsp:include page="administration/select.jsp">
                    <jsp:param name="Tabelle" value="datenbank_sprachen" />
                    <jsp:param name="Feldname" value="Sprache" />
                  </jsp:include>
                </td>
              </tr>
              <tr>
                <td width="200"><label for="Administrator">Administrator:</label></td>
                <td width="450"><input type="checkbox" name="Administrator"></td>
              </tr>
            </table>
            <p><input type="reset" value="abbrechen">&nbsp;&nbsp;<input type="submit" value="anlegen"></p>
          </FORM>
        </div>
      </div>


      <div id="tab3">
        <div id="header">
          <ul id="primary">
            <li><a href="javascript:onoff('tab1','tab3');">Benutzer verw.</a></li>
            <li><a href="javascript:onoff('tab2','tab3');">neuer Benutzer</a></li>
            <li><span>Auswahlfelder</span></li>
          </ul>
        </div>
        <div id="main">
          <table>
<%
            Connection cn = null;
            Statement  st = null;
            ResultSet  rs = null;

            try {
              Class.forName( sqlDriver );
              cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
              st = cn.createStatement();
              rs = st.executeQuery("SELECT DISTINCT selektion FROM datenbank_selektion ORDER BY selektion ASC;");

              while(rs.next()) {
                String tbl = rs.getString("selektion");
                if(tbl.startsWith("selektion_") && !tbl.endsWith("autor")) {
                  out.print("<tr>");
                  out.print("<td>"+tbl+"</td>");
                  out.print("<td><a href=\"admin.auswahlfelder.jsp?Formular=bearbeiten&Tabelle="+tbl+"\">bearbeiten</a></td>");
                  out.print("<td><a href=\"admin.auswahlfelder.jsp?Formular=zusammenfuehren&Tabelle="+tbl+"\">zusammenf&uuml;hren</a></td>");
                  out.print("</tr>");
                  out.println("");
                } //if
               
              } //while
            }
            catch (SQLException e) {out.println(e);}  
            finally {
              try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
              try { if( null != st ) st.close(); } catch( Exception ex ) {}
              try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
            }
%>
          </table>
        </div>
      </div>
    </div>
  </BODY>
</HTML>

<%
  }
  else {
  %>
    <p>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
