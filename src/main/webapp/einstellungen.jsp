<%@page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB"%>

<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%    String errorMessage = (String) request.getAttribute("errorMessage");
    boolean actionDone = (Boolean.TRUE.equals(request.getAttribute("actionDone")));
    boolean actionNotDone = (Boolean.TRUE.equals(request.getAttribute("actionNotDone")));

    String activeTab = request.getParameter("tab"); // Parameter 'tab' in der URL
    if (activeTab == null) {
        activeTab = "tab1"; // Standardmäßig Tab1 anzeigen
    }

    int benutzerID = ((Integer) session.getAttribute("BenutzerID")).intValue();
    Benutzer benutzer = BenutzerDB.getById(benutzerID);
    boolean isAdmin = benutzer.isAdmin();

    if (isAdmin && request.getParameter("ID") != null) {
        benutzerID = Integer.parseInt(request.getParameter("ID"));
        benutzer = BenutzerDB.getById(benutzerID);
    }
%>

<jsp:include page="layout/titel.einstellungen.jsp" />

<div id="form">

    <%        if (actionDone) {
    %>

    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="ErfolgDaten"/>
    </jsp:include>
    <br><br>
    <a href="javascript:history.back()">
        <jsp:include page="inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einstellungen"/>
            <jsp:param name="Textfeld" value="Zurueck"/>
        </jsp:include>
    </a>

    <%
    } else if (actionNotDone) {

        if ("passwordOldEmpty".equals(errorMessage)) {
    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortAltLeer"/>
    </jsp:include>
    <%
    } else if ("passwordNewEmpty".equals(errorMessage)) {

    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuLeer"/>
    </jsp:include>
    <%} else if ("passwordNewReplayEmpty".equals(errorMessage)) {

    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuWdhLeer"/>
    </jsp:include>
    <%    } else if ("passwordNewNotEqual".equals(errorMessage)) {
    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortNeuUngleich"/>
    </jsp:include>
    <%
    } else if ("passwordOldWrong".equals(errorMessage)) {
    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerPasswortAltFalsch"/>
    </jsp:include>
    <%
    } else if ("emailAddressTaken".equals(errorMessage)) {
    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="EmailBesetzt"/>
    </jsp:include>
    <%
    } else if ("usernameTaken".equals(errorMessage)) {
    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="LoginNameBesetzt"/>
    </jsp:include>
    <%
    } else if ("noEmail".equals(errorMessage)) {

    %>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einstellungen"/>
        <jsp:param name="Textfeld" value="FehlerEmailLeer"/>
    </jsp:include>
    <%    }
        out.println("<br><br>");
        out.println("<a href=\"javascript:history.back()\">" + Language.getTextfield(session, "einstellungen", "Zurueck") + "</a>");
    } else {
    %>

    <div id="header">
        <ul id="primary">
            <li><a href="einstellungen?tab=tab1" <%= "tab1".equals(activeTab) ? "class='active'" : ""%>>

                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                        <jsp:param name="Formular" value="einstellungen"/>
                        <jsp:param name="Textfeld" value="TabEinstellungen"/>
                    </jsp:include>

                </a>
            </li>
            <li>
                <a href="einstellungen?tab=tab2" <%= "tab2".equals(activeTab) ? "class='active'" : ""%>>
                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                        <jsp:param name="Formular" value="einstellungen"/>
                        <jsp:param name="Textfeld" value="TabPasswort"/>
                    </jsp:include>
                </a>
            </li>
        </ul>
    </div>
    <div id="main">

        <%
            if ("tab1".equals(activeTab)) {
        %>

        <form method="POST" action="einstellungen">
            <% if (isAdmin)%>
            <input type="hidden" name="ID" value="<%= benutzerID %>">
            <input type="hidden" name="action" value="Einstellungen">
            <table>
                <tr>
                    <td width="200"><label for="Benutzername"><%= Language.getTextfield(session, "login", "Benutzername") %>:</label></td>
                    <td width="450"><input name="Benutzername" size="25" maxlength="255" required="true" value="<%= benutzer.getLogin()%>"></td>
                </tr>
                <tr>
                    <td width="200"><label for="Nachname"><%= Language.getTextfield(session, "einstellungen", "Nachname") %>:</label></td>
                    <td width="450"><input name="Nachname" size="25" maxlength="255" required="true" value="<%= benutzer.getNachname()%>"></td>
                </tr>
                <tr>
                    <td width="200"><label for="Vorname"><%= Language.getTextfield(session, "einstellungen", "Vorname") %>:</label></td>
                    <td width="450"><input name="Vorname" size="25" maxlength="255" required="true" value="<%= benutzer.getVorname()%>"></td>
                </tr>
                <tr>
                    <td>
                        <jsp:include page="inc.erzeugeBeschriftung.jsp">
                            <jsp:param name="Formular" value="einstellungen"/>
                            <jsp:param name="Textfeld" value="Email"/>
                        </jsp:include>
                    </td>

                    <td><input type="email" name="email" required="true" value="<%= benutzer.getEMail()%>"/></td>
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
                            <jsp:param name="checkValue" value="<%= benutzer.getSprache()%>" />
                        </jsp:include>
                    </td>
                </tr>
                <%if (isAdmin) {%>
                <tr>
                    <td width="200"><label for="Administrator"><%= Language.getTextfield(session, "administration", "Titel") %>:</label></td>
                    <td width="450"><input type="checkbox" name="Administrator" <%= benutzer.isAdmin() ? "checked" : ""%>></td>
                </tr>
                <tr>
                    <td width="200"><label for="Administrator"><%= Language.getTextfield(session, "einstellungen", "Aktiv") %>:</label></td>
                    <td width="450"><input type="checkbox" name="Aktiv" <%= benutzer.isAktiv() ? "checked" : ""%>></td>
                </tr>
                <%}%>
                <tr>
                    <td colspan="2" align="right">
                        <input type="reset" value="<%= DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Abbrechen")%>">
                        &nbsp;
                        <input type="submit" name="save" value="<%= DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Speichern")%>">
                    </td>
                </tr>
            </table>
        </form>


        <%
        } else if ("tab2".equals(activeTab)) {
        %>
        <form method="POST" action="einstellungen">
            <% if (isAdmin)%>
            <input type="hidden" name="ID" value="<%= benutzerID %>">
            <input type="hidden" name="action" value="Passwort">
            <table>
                <tr>
                    <% if (isAdmin == false) {%>
                    <td>
                        <jsp:include page="inc.erzeugeBeschriftung.jsp">
                            <jsp:param name="Formular" value="einstellungen"/>
                            <jsp:param name="Textfeld" value="PasswortAlt"/>
                        </jsp:include>
                    </td>
                    <%}%>

                    <% if (isAdmin == false) {%>
                    <td><input type="password" name="PasswortAlt" /></td>
                        <%} else {%>
                    <td><input type="hidden" name="PasswortAlt" /></td>
                        <%}%>
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
                        <input type="reset" value="<%= DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Abbrechen")%>">
                        &nbsp;
                        <input type="submit" name="password" value="<%= DatenbankDB.getLabel((String) session.getAttribute("Sprache"), "navigation", "Speichern")%>">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <%
            }
        }
    %>
</div>
