<%@ page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankSprache" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.SaltHash" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (AuthHelper.isBenutzerLogin(request)) {
    %><jsp:forward page="einzelbeleg.jsp" /><%
  }
  else if (AuthHelper.isGastLogin(request)) {
    response.sendRedirect("gast/einfache_suche.jsp");
} else {

    if (request.getParameter("language") != null) {
        session = request.getSession(true);
        session.setAttribute("Sprache", request.getParameter("language"));
        session.setMaxInactiveInterval(sessionTimeout);
    }

    if (request.getParameter("action") != null && request.getParameter("action").equals("login")) {
        String login = request.getParameter("username");
        String password = request.getParameter("password");

        if (!BenutzerDB.hasLogin(login)) {
            %>
            <!DOCTYPE html>
            <html>
            <head>
                <title>Benutzer existiert nicht</title>
            </head>
            <body>
                <h1 style="text-align: center;">Benutzer existiert nicht</h1>
            </body>
            </html>
            <%
        } else {

            Benutzer benutzer = BenutzerDB.getByLogin(login);

            // 1) Check SALT
            String saltString = benutzer.getSalt();
            if (saltString == null || saltString.isEmpty()) {
                %>
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Passwort zu alt</title>
                </head>
                <body>
                <h1 style="text-align: center;">Die Sicherheit der Datenbank wurde verbessert. Das Password muss neu gesetzt werden</h1>
                <h1 style="text-align: center;"><a href="<%=Utils.getBaseUrl(request)%>/forgotPassword">Neuen Link generieren</a></h1>
                </body>
                </html>
                <%
            } else {
                // 2) Check password
                byte[] saltBytes = SaltHash.Base64StringToBytes(saltString);
                String passwordSalted = SaltHash.GenerateHash(password, AuthHelper.getPasswordHashingAlgorithm(), saltBytes);
                if (!passwordSalted.equals(benutzer.getPassword())) {
                    %>
                    <!DOCTYPE html>
                    <html>
                    <head>
                        <title>Passwort falsch</title>
                    </head>
                    <body>
                        <h1 style="text-align: center;">Ungültiges Passwort.</h1>
                    </body>
                    </html>
                    <%
                } else {
                     // Falls Session vorhanden, löschen
                    if (session != null) {
                        session.invalidate();
                    }

                    // Neue Session erzeugen
                    session = request.getSession(true);
                    session.setAttribute("BenutzerID", new Integer(benutzer.getID()));
                    session.setAttribute("GruppeID", new Integer(benutzer.getGruppe().getID()));
                    session.setAttribute("Benutzername", benutzer.getLogin());
                    session.setAttribute("Administrator", new Boolean(benutzer.isAdmin()));
                    session.setAttribute("Gast", new Boolean(benutzer.isGast()));
                    session.setAttribute("Sprache", benutzer.getSprache());
                    session.setMaxInactiveInterval(sessionTimeout);

                    // Weiterleitung
                    if ((Boolean) session.getAttribute("Gast")) {
                        response.sendRedirect("gast/einfache_suche.jsp");
                    } else {
                        response.sendRedirect("einzelbeleg.jsp");
                    }
                }
            }
        }
    } else {
%>
<HTML>
    <HEAD>
        <TITLE>
            Nomen et Gens -
        </TITLE>
        <link rel="stylesheet" href="layout/layout.css" type="text/css">
        <style>
            .flexbox-container{
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin: 200px 0px 0px 0px;
            }

            .flex-item-table{
                align-items: first;
            }
        </style>
    </HEAD>
    <BODY>
        <form method="POST">
            <input type="hidden" name="action" value="login">
            <div class="flexbox-container" >
                <div class="flex-item-title">
                    <h1 class="login">Nomen et Gens</h1>
                </div>
                <div class="flex-item-title flex-item-table">
                    <table border="0">

                        <tr><td colspan="2"><h2 class="login">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Anmeldung"/>
                                    </jsp:include>
                                </h2></td></tr>
                        <tr>
                            <th><label for="username">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Benutzername"/>
                                    </jsp:include>
                                </label></th>
                            <td><input name="username" maxlength="20" placeholder="Benutzername" /></td>
                        </tr>
                        <tr>
                            <th><label for="password">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Passwort"/>
                                    </jsp:include>
                                </label></th>
                            <td><input type="password" name="password" maxlength="20" placeholder="Passwort" /></td>
                        </tr>
                    </table>


                </div>
                <input type="submit" value="Daten absenden" style="margin:5px 0px 0px 50px"/>



                <p> &nbsp; </p><!-- comment -->
                <a href="forgotPassword">Passwort vergessen ?</a>
            </div>  <!-- ende flexbox-container -->
        </form>
    <center>
        <% List<DatenbankSprache> sprachen = DatenbankDB.getListSprache(); %>
        <form method="POST">
            <% for (DatenbankSprache sprache : sprachen) { %>
                <input type="image" name="language" alt="" title="" src="layout/flags/<%=sprache.getKuerzel()%>.gif" value="<%=sprache.getKuerzel()%>" style="border:#000 1px solid;">
            <% } %>
        </form>
    </center>
</BODY>
</HTML>

<%
    }
}
%>
