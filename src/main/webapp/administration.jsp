<%@page import="de.uni_tuebingen.ub.nppm.model.BenutzerGruppe"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Benutzer"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.SelektionDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankSelektion" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<% Language.setLanguage(request); %>

<div>
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            String createMessage = (String) request.getAttribute("createMessage");
            boolean errorCreate = (Boolean.TRUE.equals(request.getAttribute("errorCreate")));
            String activeTab = request.getParameter("tab"); // Parameter 'tab' in der URL
            if (activeTab == null) {
                activeTab = "tab1"; // Standardmäßig Tab1 anzeigen
            }

            if ("anlegen".equals(createMessage)) {
                if (errorCreate) {
                    out.println(errorMessage);
                    out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
                } else {
                    out.println("<p>Benutzer \"" + request.getParameter("Benutzername") + "\" erfolgreich angelegt.</p>");
                    out.println("<a href=\"administration\">zur&uuml;ck</a>");
                }
            } else {
        %>

        <div id="header">
            <ul id="primary">
                <li><a href="administration?tab=tab1" <%= "tab1".equals(activeTab) ? "class='active'" : "" %>>Benutzer verw.</a></li>
                <li><a href="administration?tab=tab2" <%= "tab2".equals(activeTab) ? "class='active'" : "" %>>neuer Benutzer</a></li>
                <li><a href="administration?tab=tab3" <%= "tab3".equals(activeTab) ? "class='active'" : "" %>>Auswahlfelder</a></li>
            </ul>
        </div>

        <div id="main">
            <%
                if ("tab1".equals(activeTab)) {
            %>
                <jsp:include page="administration/list.benutzer.jsp" />
            <%
                } else if ("tab2".equals(activeTab)) {
            %>
                <FORM method="POST" action="administration">
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
                    <p><input type="reset" value="abbrechen">&nbsp;&nbsp;<input type="submit" name="actionCreate" value="anlegen"></p>
                </FORM>
            <%
                } else if ("tab3".equals(activeTab)) {
            %>
                <table>
                    <%                        List<String> lst = DatenbankDB.getSelektion();
                        for (String tbl : lst) {
                            if (tbl.startsWith("selektion_") && !tbl.endsWith("autor")) {
                                out.print("<tr>");
                                out.print("<td>" + tbl + "</td>");
                                out.print("<td><a href=\"admin-auswahlfelder?Formular=bearbeiten&Tabelle=" + tbl + "\">bearbeiten</a></td>");
                                out.print("<td><a href=\"admin-auswahlfelder?Formular=zusammenfuehren&Tabelle=" + tbl + "\">zusammenf&uuml;hren</a></td>");
                                if ("selektion_funktion".equals(tbl)) {
                                    out.print("<td><a href=\"admin-auswahlfelder?Formular=aufteilen&Tabelle=" + tbl + "\">Aufteilen</a></td>");
                                } else {
                                    out.print("<td></td>");
                                }
                                if (SelektionDB.isHierarchy(tbl)) {
                                    out.print("<td><a href=\"admin-auswahlfelder?Formular=baumstruktur&Tabelle=" + tbl + "\">Baumstruktur</a></td>");
                                } else {
                                    out.print("<td></td>");
                                }
                                out.println("<td>");
                                out.println("<a href=\"admin-auswahlfelder?Formular=showProvenance&Tabelle=" + tbl + "\">provenance info</a>");
                                out.println("</td>");
                                out.print("</tr>");
                            }
                        }
                    %>
                </table>
            <%
                }
            %>
        </div>
        <%
            }
        %>

    </div>
</div>
