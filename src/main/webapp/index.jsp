<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<% if (AuthHelper.isBenutzerLogin(request)) {%>
    <jsp:forward page="einzelbeleg" /><%
} else if (AuthHelper.isGastLogin(request)) {
    response.sendRedirect("gast/startseite");
} else {
    if (request.getParameter("language") != null) {
        session = request.getSession(true);
        session.setAttribute("Sprache", request.getParameter("language"));
        session.setMaxInactiveInterval(sessionTimeout);
    }

    String login = "Gast";
    String password = "gast";

    // Passwort verschlüsseln
    MessageDigest m = MessageDigest.getInstance("MD5");
    m.update(password.getBytes(), 0, password.length());
    String passwordMD5 = (new BigInteger(1, m.digest()).toString(16));

    Benutzer user = BenutzerDB.getByLogin(login);
    if (user != null && user.getPassword().equals(passwordMD5)) {
        // Falls Session vorhanden, löschen
        if (session != null) {
            session.invalidate();
        }

        // Neue Session erzeugen
        session = request.getSession(true);

        // Neu: komplettes Benutzer-Objekt speichern
        session.setAttribute("Benutzer", user);

        // Alt (für Abwärtskompatibilität in sehr vielen Views): Einzelne Eigenschaften speichern
        session.setAttribute("BenutzerID", user.getID());
        session.setAttribute("GruppeID", user.getGruppe().getID());
        session.setAttribute("Benutzername", login);
        session.setAttribute("Administrator", user.isAdmin());
        session.setAttribute("Gast", user.isGast());
        session.setAttribute("Sprache", user.getSprache());
        session.setMaxInactiveInterval(sessionTimeout);

        // Weiterleitung
        if (user.isGast()) {
            response.sendRedirect("gast/startseite");
        } else {
            response.sendRedirect("einzelbeleg");
        }
    } else {
%>
<p>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="BenutzerKennwortFalsch"/>
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
    }
%>
