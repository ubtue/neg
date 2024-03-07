<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("note") && !array) {
        String sql = "";
        String note = "";
        if (datenfeld.startsWith("Bemerkung")) {
            sql = "SELECT " + zielAttribut
                    + " FROM " + zielTabelle
                    + " WHERE " + formularAttribut + "=\"" + id + "\"";
            if (datenfeld.endsWith("Alle")) {
                sql += " AND GruppeID IS NULL AND BenutzerID IS NULL";
            } else if (datenfeld.endsWith("Gruppe")) {
                sql += " AND GruppeID = " + session.getAttribute("GruppeID") + " AND BenutzerID IS NULL";
            } else if (datenfeld.endsWith("Privat")) {
                sql += " AND GruppeID IS NULL AND BenutzerID = " + session.getAttribute("BenutzerID") + "";
            }
            note = AbstractBase.getStringNative(sql);
        }
        if (!isReadOnly) {
            out.print("<textarea name=\"" + datenfeld + "\" "
                    + (cols > 0 ? "cols=\"" + cols + "\" " : "")
                    + (rows > 0 ? "rows=\"" + rows + "\" " : "")
                    + ">");
        }
        if (note != null) {
            out.print(DBtoHTML(note));
        }
        if (!isReadOnly) {
            out.println("</textarea>");
        }
    }
%>
