<%@ page import="de.uni_tuebingen.ub.nppm.util.SaltHash"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%    if (AuthHelper.isAdminLogin(request)) {

        if (request.getParameter("action") == null
                || request.getParameter("Benutzername") == null
                || request.getParameter("Nachname") == null
                || request.getParameter("Vorname") == null
                || request.getParameter("EMail") == null
                || request.getParameter("Kennwort") == null) {
            out.println("<p>Falscher Aufruf!</p>");
            out.println("<a href=\"index.jsp\">Zur&uuml;ck zur Startseite</a>");
        } else {
%>

<HTML>
    <HEAD>
        <TITLE>Nomen et Gens - Administration</TITLE>
        <link rel="stylesheet" href="layout/layout.css" type="text/css">
        <script src="../javascript/funktionen.js" type="text/javascript"></script>
        <noscript></noscript>
    </HEAD>

    <BODY>
        <jsp:include page="layout/navigation.inc.jsp" />
        <jsp:include page="layout/image.inc.html" />
        <jsp:include page="layout/titel.administration.jsp" />
        <div id="form">

            <%
                boolean fehler = false;

                if (request.getParameter("Benutzername").equals("")) {
                    out.println("<p><b>Fehler:</b> Benutzername ist leer</p>");
                    fehler = true;
                } else if (BenutzerDB.hasLogin(request.getParameter("Benutzername"))) {
                    out.println("<p><b>Fehler:</b> Benutzername ist bereits vorhanden</p>");
                    fehler = true;
                } else if (request.getParameter("Nachname").equals("")) {
                    out.println("<p><b>Fehler:</b> Nachname ist leer</p>");
                    fehler = true;
                } else if (request.getParameter("Vorname").equals("")) {
                    out.println("<p><b>Fehler:</b> Vorname ist leer</p>");
                    fehler = true;
                } else if (request.getParameter("EMail").equals("")) {
                    out.println("<p><b>Fehler:</b> E-Mail ist leer</p>");
                    fehler = true;
                } else if (request.getParameter("Kennwort").equals("")) {
                    out.println("<p><b>Fehler:</b> Kennwort ist leer</p>");
                    fehler = true;
                }

                if (fehler) {
                    out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
                } else {
                    String password = request.getParameter("Kennwort");

                    byte[] salt = SaltHash.GenerateRandomSalt(AuthHelper.getPasswordSaltLength());
                    password = SaltHash.GenerateHash(password, AuthHelper.getPasswordHashingAlgorithm(), salt);
                    String saltValue = SaltHash.BytesToBase64String(salt);

                    BenutzerGruppe gruppe = BenutzerDB.getGruppeById(Integer.parseInt(request.getParameter("Projektgruppe")));

                    Benutzer benutzer = new Benutzer();
                    benutzer.setLogin(request.getParameter("Benutzername"));
                    benutzer.setNachname(request.getParameter("Nachname"));
                    benutzer.setVorname(request.getParameter("Vorname"));
                    benutzer.setEMail(request.getParameter("EMail"));
                    benutzer.setPassword(password);
                    benutzer.setSalt(saltValue);
                    benutzer.setSprache(request.getParameter("Sprache"));
                    benutzer.setAdmin(request.getParameter("Administrator") != null && request.getParameter("Administrator").equals("on"));
                    benutzer.setGruppe(gruppe);

                    BenutzerDB.saveOrUpdate(benutzer);

                    out.println("<p>Benutzer \"" + request.getParameter("Benutzername") + "\"erfolgreich angelegt.</p>");
                    out.println("<a href=\"administration.jsp\">zur&uuml;ck</a>");
                }
            %>

        </div>
    </BODY>
</HTML>

<%
    }
} else {
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

