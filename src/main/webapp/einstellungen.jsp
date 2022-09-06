<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%
  Language.setLanguage(request);
  if (AuthHelper.isBenutzerLogin(request)) {

  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;
  String email = "";

  try {
  
    int benutzerID=((Integer)session.getAttribute("BenutzerID")).intValue();
  
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM benutzer WHERE ID="+benutzerID+";");
    rs.next();
    
    boolean isAdmin = false;
    isAdmin = rs.getString("IstAdmin").equals("1");
    
    if(isAdmin && request.getParameter("ID")!=null){
       benutzerID=Integer.parseInt(request.getParameter("ID"));
       rs = st.executeQuery("SELECT * FROM benutzer WHERE ID="+benutzerID+";");
       rs.next();
    
    }

  
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - 
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.einstellungen.jsp" />

    <div id="form">
      <div id="tab1">
        <div id="header">
          <ul id="primary">
            <li>
              <span>
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einstellungen"/>
                  <jsp:param name="Textfeld" value="TabEinstellungen"/>
                </jsp:include>
              </span>
            </li>
            <li>
              <a href="javascript:onoff('tab2','tab1');">
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einstellungen"/>
                  <jsp:param name="Textfeld" value="TabPasswort"/>
                </jsp:include>
              </a>
            </li>
          </ul>
        </div>
        <div id="main">
          <form method="POST" action="einstellungen.speichern.jsp">
          <% if(isAdmin)%>
            <input type="hidden" name="ID" value="<%= benutzerID %>">
            <input type="hidden" name="action" value="Einstellungen">
            <table>
              <tr>
                <td width="200"><label for="Benutzername">Benutzername:</label></td>
                <td width="450"><input name="Benutzername" size="25" maxlength="255" value="<%= rs.getString("Login") %>"></td>
              </tr>
              <tr>
                <td width="200"><label for="Nachname">Nachname:</label></td>
                <td width="450"><input name="Nachname" size="25" maxlength="255" value="<%= rs.getString("Nachname") %>"></td>
              </tr>
              <tr>
                <td width="200"><label for="Vorname">Vorname:</label></td>
                <td width="450"><input name="Vorname" size="25" maxlength="255" value="<%= rs.getString("Vorname") %>"></td>
              </tr>
              <tr>
                 <td>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einstellungen"/>
                    <jsp:param name="Textfeld" value="Email"/>
                  </jsp:include>
                </td>

                <td><input type="text" name="email" value="<%= rs.getString("EMail") %>"/></td>
              </tr>
              <tr>
                <td>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einstellungen"/>
                    <jsp:param name="Textfeld" value="Sprache"/>
                  </jsp:include>
                </td>
                <td>
                  <jsp:include page="administration/select.jsp">
                    <jsp:param name="Tabelle" value="datenbank_sprachen" />
                    <jsp:param name="Feldname" value="Sprache" />
                  </jsp:include>
                </td>
              </tr>
              <%if(isAdmin){%>
             <tr>
                <td width="200"><label for="Administrator">Administrator:</label></td>
                <td width="450"><input type="checkbox" name="Administrator" <%= rs.getString("IstAdmin").equals("1")?"checked":""%>></td>
              </tr>
             <tr>
                <td width="200"><label for="Administrator">Aktiv:</label></td>
                <td width="450"><input type="checkbox" name="Aktiv" <%= rs.getString("IstAktiv").equals("1")?"checked":""%>></td>
              </tr>
              <%}%>
              <tr>
                <td colspan="2" align="right">
                  <input type="reset" value="<%= getLabel("navigation", null, "Abbrechen", cn.createStatement(), (String)session.getAttribute("Sprache")) %>">
                  &nbsp;
                  <input type="submit" value="<%= getLabel("navigation", null, "Speichern", cn.createStatement(), (String)session.getAttribute("Sprache")) %>">
                </td>
              </tr>
            </table>
          </form>
        </div>
      </div>

      <div id="tab2">
        <div id="header">
          <ul id="primary">
            <li>
              <a href="javascript:onoff('tab1','tab2');">
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einstellungen"/>
                  <jsp:param name="Textfeld" value="TabEinstellungen"/>
                </jsp:include>
              </a>
            </li>
            <li>
              <span>
                <jsp:include page="inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einstellungen"/>
                  <jsp:param name="Textfeld" value="TabPasswort"/>
                </jsp:include>
              </span>
            </li>
          </ul>
        </div>
        <div id="main">
          <form method="POST" action="einstellungen.speichern.jsp">
           <% if(isAdmin)%>
            <input type="hidden" name="ID" value="<%= benutzerID %>">
            <input type="hidden" name="action" value="Passwort">
            <table>
              <tr>
                <td>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einstellungen"/>
                    <jsp:param name="Textfeld" value="PasswortAlt"/>
                  </jsp:include>
                </td>
                <td><input type="password" name="PasswortAlt" /></td>
              </tr>
              <tr>
                <td>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einstellungen"/>
                    <jsp:param name="Textfeld" value="PasswortNeu"/>
                  </jsp:include>
                </td>
                <td><input type="password" name="PasswortNeu" /></td>
              </tr>
              <tr>
                <td>
                  <jsp:include page="inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einstellungen"/>
                    <jsp:param name="Textfeld" value="PasswortNeuWdh"/>
                  </jsp:include>
                </td>
                <td><input type="password" name="PasswortNeuWdh" /></td>
              </tr>
              <tr>
                <td colspan="2" align="right">
                  <input type="reset" value="<%= getLabel("navigation", null, "Abbrechen", cn.createStatement(), (String)session.getAttribute("Sprache")) %>">
                  &nbsp;
                  <input type="submit" value="<%= getLabel("navigation", null, "Speichern", cn.createStatement(), (String)session.getAttribute("Sprache")) %>">
                </td>
              </tr>
            </table>
          </form>
        </div>
      </div>
    </div>
  </BODY>
</HTML>

<%  }
  catch (Exception e) {out.println(e);}
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
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
