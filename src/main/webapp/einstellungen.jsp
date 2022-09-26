<%@page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB"%>
﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%

int benutzerID=((Integer)session.getAttribute("BenutzerID")).intValue();
Benutzer benutzer = BenutzerDB.getById(benutzerID);
boolean isAdmin = benutzer.isAdmin();

if(isAdmin && request.getParameter("ID")!=null){
   benutzerID=Integer.parseInt(request.getParameter("ID"));
   benutzer = BenutzerDB.getById(benutzerID);
}

%>

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
            <td width="450"><input name="Benutzername" size="25" maxlength="255" value="<%= benutzer.getLogin() %>"></td>
          </tr>
          <tr>
            <td width="200"><label for="Nachname">Nachname:</label></td>
            <td width="450"><input name="Nachname" size="25" maxlength="255" value="<%= benutzer.getNachname() %>"></td>
          </tr>
          <tr>
            <td width="200"><label for="Vorname">Vorname:</label></td>
            <td width="450"><input name="Vorname" size="25" maxlength="255" value="<%= benutzer.getVorname() %>"></td>
          </tr>
          <tr>
             <td>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="einstellungen"/>
                <jsp:param name="Textfeld" value="Email"/>
              </jsp:include>
            </td>

            <td><input type="text" name="email" value="<%= benutzer.getEMail() %>"/></td>
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
            <td width="450"><input type="checkbox" name="Administrator" <%= benutzer.isAdmin() ?"checked":""%>></td>
          </tr>
         <tr>
            <td width="200"><label for="Administrator">Aktiv:</label></td>
            <td width="450"><input type="checkbox" name="Aktiv" <%= benutzer.isAktiv() ?"checked":""%>></td>
          </tr>
          <%}%>
          <tr>
            <td colspan="2" align="right">
                <input type="reset" value="<%= DatenbankDB.getLabel((String)session.getAttribute("Sprache"), "navigation", "Abbrechen")%>">
              &nbsp;
              <input type="submit" value="<%= DatenbankDB.getLabel((String)session.getAttribute("Sprache"), "navigation", "Speichern")%>">
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
              <input type="reset" value="<%= DatenbankDB.getLabel((String)session.getAttribute("Sprache"), "navigation", "Abbrechen")%>">
              &nbsp;
              <input type="submit" value="<%= DatenbankDB.getLabel((String)session.getAttribute("Sprache"), "navigation", "Speichern")%>">
            </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
