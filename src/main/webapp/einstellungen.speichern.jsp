<%@page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Benutzer"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.SaltHash"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.AuthHelper"%>


<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%

  boolean actionDone = false;
  if (session.getAttribute("BenutzerID")!=null
      && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
     ) {

    if(request.getParameter("action") == null
      ) {
      out.println("<p>Falscher Aufruf!</p>");
      out.println("<a href=\"index.jsp\">Zur&uuml;ck zur Startseite</a>");
    }
    else {



    int benutzerID=((Integer)session.getAttribute("BenutzerID")).intValue();
    Benutzer benutzer = BenutzerDB.getById(benutzerID);
    boolean isAdmin = benutzer.isAdmin();
    if(isAdmin && request.getParameter("ID")!=null){
       benutzerID=Integer.parseInt(request.getParameter("ID"));
       benutzer = BenutzerDB.getById(benutzerID);
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
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.einstellungen.jsp" />
    <div id="form">

<%
  if (request.getParameter("action").equals("Einstellungen")) {
    if (request.getParameter("email").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerEmailLeer"/>
      </jsp:include>
<%
    }
    else {
      benutzer.setEMail(request.getParameter("email"));
      benutzer.setSprache(request.getParameter("Sprache"));
      benutzer.setLogin(request.getParameter("Benutzername"));
      benutzer.setVorname(request.getParameter("Vorname"));
      benutzer.setNachname(request.getParameter("Nachname"));
      benutzer.setAdmin(request.getParameter("Administrator").equals("on"));
      benutzer.setAktiv(request.getParameter("Aktiv")!=null && request.getParameter("Aktiv").equals("on"));
      BenutzerDB.saveOrUpdate(benutzer);
      actionDone = true;
    }
  }

  else if (request.getParameter("action").equals("Passwort")) {
    if (!isAdmin && (request.getParameter("PasswortAlt")==null || request.getParameter("PasswortAlt").equals(""))) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortAltLeer"/>
      </jsp:include>
<%
    }
    else if (request.getParameter("PasswortNeu")==null || request.getParameter("PasswortNeu").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuLeer"/>
      </jsp:include>
<%
    }
    else if (request.getParameter("PasswortNeuWdh")==null || request.getParameter("PasswortNeuWdh").equals("")) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuWdhLeer"/>
      </jsp:include>
<%
    }
    else if (!request.getParameter("PasswortNeu").equals(request.getParameter("PasswortNeuWdh"))) {
%>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuUngleich"/>
      </jsp:include>
<%
    }
    else {
        String newPassword = request.getParameter("PasswortNeu");
        String algorithm = AuthHelper.getPasswordHashingAlgorithm();

        boolean isOldPasswordCorrect = false;
        if (!isAdmin) {
            String oldSaltString = benutzer.getSalt();
            byte[] oldSaltBytes = SaltHash.Base64StringToBytes(oldSaltString);
            String oldPassword = request.getParameter("PasswortAlt");
            String oldPasswordHash = SaltHash.GenerateHash(oldPassword, algorithm, oldSaltBytes);
            String oldDbPasswordHash = benutzer.getPassword();
            if (!oldPasswordHash.equals(oldDbPasswordHash)) {
%>
              <jsp:include page="inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="einstellungen"/>
                <jsp:param name="Textfeld" value="FehlerPasswortAltFalsch"/>
              </jsp:include>
<%
            } else {
                isOldPasswordCorrect = true;
            }
        }

        if(isAdmin || isOldPasswordCorrect) {
            byte[] newSaltBytes = SaltHash.GenerateRandomSalt(AuthHelper.getPasswordSaltLength());
            String newSaltString = SaltHash.BytesToBase64String(newSaltBytes);
            String newPasswordHash = SaltHash.GenerateHash(newPassword, algorithm, newSaltBytes);
            benutzer.setPassword(newPasswordHash);
            benutzer.setSalt(newSaltString);
            BenutzerDB.saveOrUpdate(benutzer);
            actionDone = true;
        }
    }
  }

}
%>
<% if (actionDone) {%>
  <jsp:include page="inc.erzeugeBeschriftung.jsp">
    <jsp:param name="Formular" value="einstellungen"/>
    <jsp:param name="Textfeld" value="ErfolgDaten"/>
  </jsp:include>
  <a href="javascript:history.back()">
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="einstellungen"/>
      <jsp:param name="Textfeld" value="Zurueck"/>
    </jsp:include>
  </a>
<% }
}%>

    </div>
  </BODY>
</HTML>
