<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.SelektionDB" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>

<div>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">

        <%            int rowCounter = 0;
            String editMessage = (String) request.getAttribute("editMessage");
            String moveMessage = (String) request.getAttribute("moveMessage");
            String CheckSelektionFunktion = (String) request.getAttribute("funktionSelektionBezeichnung");

            if (request.getParameter("action") != null && request.getParameter("action").equals("neu") && "blankLabel".equals(editMessage)) {
                out.println("<p><b>Fehler:</b> selektion_funktion darf nicht leer sein.</p>");
                out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
            } else if (request.getParameter("action") != null && request.getParameter("action").equals("neu") && "alreadyExists".equals(editMessage)) {
                out.println("<p>Auswahl \"" + request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung") + "\"exisitiert bereits und wurde daher nicht angelegt.</p>");
                out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
            } else if (request.getParameter("action") != null && request.getParameter("action").equals("neu") && "success".equals(editMessage)) {
                out.println("<p>Auswahl \"" + request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung") + "\"erfolgreich angelegt.</p>");
                out.println("<a href=\"admin-auswahlfelder?Formular=bearbeiten&Tabelle=" + request.getParameter("Tabelle") + "\">Weitere Elemente bearbeiten</a><br><br>");
                out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
            } else if (request.getParameter("action") != null && request.getParameter("action").equals("umbenennen") && "blankLabel".equals(editMessage)) {
                out.println("<p><b>Fehler:</b> neue Beschriftung darf nicht leer sein.</p>");
                out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
            } else if (request.getParameter("action") != null && request.getParameter("action").equals("umbenennen") && "alreadyExists".equals(editMessage)) {
                out.println("<p>Auswahl \"" + request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung") + "\"exisitiert bereits, benutzen Sie bitte die Funktion 'zusammenf&uuml;hren' um beide Auswahl zusammenzuführen.</p>");
                out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
            } else if (request.getParameter("action") != null && request.getParameter("action").equals("umbenennen") && "success".equals(editMessage)) {
                out.println("<p>Auswahl erfolgreich nach"
                        + " \"" + request.getParameter(request.getParameter("Tabelle") + "_Bezeichnung") + "\" umbenannt.</p>");
                out.println("<a href=\"admin-auswahlfelder?Formular=bearbeiten&Tabelle=" + request.getParameter("Tabelle") + "\">Weitere Elemente bearbeiten</a><br><br>");
                out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
            } else if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("bearbeiten")) {
                String tbl = request.getParameter("Tabelle");
        %>
        <FORM method="POST" action="admin-auswahlfelder">
            <input type="hidden" name="Tabelle" value="<%= tbl%>">
            <table>
                <tr>
                    <th width="200"><%= tbl%></th>
                    <td width="450">
                        <jsp:include page="administration/select.jsp">
                            <jsp:param name="Tabelle" value="<%= tbl%>" />
                            <jsp:param name="Feldname" value="<%= tbl%>" />
                        </jsp:include>
                    </td>
                </tr>
                <tr>
                    <td width="200">Beschriftung</td>
                    <td width="450"><input name="<%= tbl%>_Bezeichnung" size="50" maxlength="255"></td>
                </tr>
            </table>
            <p>
                <input type="reset" value="abbrechen">
                <input type="submit" name="action" value="neu">
                <input type="submit" name="action" value="umbenennen">
            </p>
        </FORM>
        <%
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("verschieben") && "sameSelection".equals(moveMessage)) {
            out.println("<p>Auswahl kann nicht mit sich selbst zusammengeführt werden.</p><br><br>");
            out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("verschieben") && "success".equals(moveMessage)) {
            out.println("<p>Auswahl erfolgreich zusammengef&uuml;hrt.</p>");
            out.println("<a href=\"admin-auswahlfelder?Formular=zusammenfuehren&Tabelle=" + request.getParameter("Tabelle") + "\">Weitere Elemente zusammenf&uuml;hren</a><br><br>");
            out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
        } else if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("zusammenfuehren")) {
            String tbl = request.getParameter("Tabelle");
        %>
        <FORM method="POST" action="admin-auswahlfelder">
            <input type="hidden" name="Tabelle" value="<%= tbl%>">
            <table>
                <tr>
                    <th width="200"><%= tbl%></th>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td width="200">alte Auswahl</td>
                    <td width="450">
                        <jsp:include page="administration/select.jsp">
                            <jsp:param name="Tabelle" value="<%= tbl%>" />
                            <jsp:param name="Feldname" value="Feld_alt" />
                        </jsp:include>
                    </td>
                </tr>
                <tr>
                    <td width="200">neue Auswahl</td>
                    <td width="450">
                        <jsp:include page="administration/select.jsp">
                            <jsp:param name="Tabelle" value="<%= tbl%>" />
                            <jsp:param name="Feldname" value="Feld_neu" />
                        </jsp:include>
                    </td>
                </tr>
            </table>
            <p>
                <input type="reset" value="abbrechen">
                <input type="submit" name="action" value="verschieben">
            </p>
        </FORM>
        <%
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("aufteilen") && "noSelektionFunktion".equals(CheckSelektionFunktion)) {
            out.println("<p><b>Fehler:</b> selektion_funktion darf nicht leer sein.</p>");
            out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("aufteilen") && "noDivideSelektionFunktion".equals(CheckSelektionFunktion)) {
            out.println("<p><b>Fehler:</b> Keine Werte für Aufteilen.</p>");
            out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("aufteilen") && "success".equals(CheckSelektionFunktion)) {
            out.println("<p>Auswahl erfolgreich aufgeteilt.</p>");
            out.print("<p><a href=\"admin-auswahlfelder?Formular=aufteilen&Tabelle=" + request.getParameter("Tabelle") + "\">Weitere Elemente Aufteilen</a></p>");
            out.println("<a href=\"administration\">zur&uuml;ck zur Administration</a>");
        } else if (request.getParameter("action") != null && request.getParameter("action").equals("aufteilen") && "sameSelektionFunktion".equals(CheckSelektionFunktion)) {
            out.println("<p><b>Fehler:</b> Auswahl kann nicht mit sich selbst aufgeteilt werden.</p>");
            out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
        } else if (request.getParameter("action") == null && request.getParameter("Tabelle") != null && request.getParameter("Formular").equals("aufteilen")) {

        %>

        <div>
            <form id="myForm" method="POST" action="admin-auswahlfelder">
                <input type="hidden" name="Tabelle" value="<%= request.getParameter("Tabelle")%>">
                <table id="myTable">
                    <tr>
                        <th width="200"><%= request.getParameter("Tabelle")%></th>
                        <td width="450">
                            <jsp:include page="administration/select.jsp">
                                <jsp:param name="Tabelle" value="<%= request.getParameter("Tabelle")%>" />
                                <jsp:param name="Feldname" value="Feld_selektionFunktion" />
                            </jsp:include>
                        </td>
                    </tr>
                    <tr id="rowTemplate">
                        <td width="200">Aufteilen</td>
                        <td width="450">
                            <jsp:include page="administration/select.jsp">
                                <jsp:param name="Tabelle" value="<%= request.getParameter("Tabelle")%>" />
                                <jsp:param name="Feldname" value="Aufteilen[0]" />
                            </jsp:include>
                        </td>
                    </tr>
                </table>
                <p>
                    <input type="reset" value="abbrechen">
                    <input type="button" id="subButton" value="-">
                    <input type="button" id="addButton" value="+">
                    <input type="submit" name="action" value="aufteilen">
                </p>
            </form>
        </div>

        <script>
        let rowCounter = <%= rowCounter%>; // Initialer Zähler für die Zeilen

        document.getElementById("addButton").addEventListener("click", function () {
            var rowTemplate = document.getElementById("rowTemplate");
            var newRow = rowTemplate.cloneNode(true); // Klone die Zeile
            rowCounter++; // Erhöhe den Zähler für die nächste Zeile

            // Aktualisiere den Namen des select-Feldes
            var selectElement = newRow.querySelector("select");
            if (selectElement) {
                selectElement.name = "Aufteilen[" + rowCounter + "]";
            }

            // Entferne die ID von der neuen Zeile, um die Vorlage zu behalten
            newRow.removeAttribute("id");

            // Füge die neue Zeile zur Tabelle hinzu
            document.getElementById("myTable").appendChild(newRow);
            console.log("Neue Zeile hinzugefügt. Name des neuen Inputs: " + (selectElement ? selectElement.name : "unbekannt"));
        });

        document.getElementById("subButton").addEventListener("click", function () {
            var table = document.getElementById("myTable");
            var rows = table.getElementsByTagName("tr");

            // Stelle sicher, dass mindestens eine Zeile vorhanden ist, die nicht die Vorlage ist
            if (rows.length > 1) {
                var lastRow = rows[rows.length - 1];
                // Überprüfe, ob die Zeile das letzte Element ist, das entfernt werden soll
                if (lastRow && lastRow.id !== 'rowTemplate') {
                    table.removeChild(lastRow);
                    rowCounter--; // Reduziere den Zähler
                    console.log("Zeile entfernt. Aktuelle Zeilenanzahl: " + (rows.length - 1));
                } else {
                    console.log("Keine weiteren Zeilen zum Entfernen vorhanden.");
                }
            } else {
                console.log("Keine weiteren Zeilen zum Entfernen vorhanden.");
            }
        });
        </script>

        <%
            }
        %>

    </div>
</div>

