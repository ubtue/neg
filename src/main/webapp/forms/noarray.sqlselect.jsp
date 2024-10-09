<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
    if (feldtyp.equals("sqlselect") && !array) {
        String sql = "";
        if (datenfeld.equals("Edition")) {
            sql = "SELECT edition.ID ID, edition.Zitierweise Bezeichnung"
                    + " FROM edition, quelle_inedition, einzelbeleg"
                    + " WHERE einzelbeleg.ID = " + id + " AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND quelle_inedition.EditionID = edition.ID";
        }

        Map row = AbstractBase.getMappedRow("SELECT einzelbeleg.editionID"
                + " FROM edition, quelle_inedition, einzelbeleg"
                + " WHERE einzelbeleg.ID = " + id + " AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND einzelbeleg.EditionID = quelle_inedition.EditionID AND quelle_inedition.EditionID = edition.ID");

        int selected = -1;
        if (row != null) {
            selected = Integer.parseInt(row.get(zielAttribut).toString());
        } else {
            Map row3 = AbstractBase.getMappedRow("SELECT edition.ID ID"
                    + " FROM edition, quelle_inedition, einzelbeleg"
                    + " WHERE einzelbeleg.ID = " + id + " AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND quelle_inedition.EditionID = edition.ID AND quelle_inedition.Standard=1");

            if (row3 != null) {
                selected = Integer.parseInt(row3.get("ID").toString());
            }
        }

        if (!isReadOnly) {
            out.println("<select name=\"" + datenfeld + "\">");
        }

        List<Map> rowlist2 = AbstractBase.getMappedList(sql);
        //   out.println("<option value=\"-1\">nicht bearbeitet</option>");
        for (Map row2 : rowlist2) {
            String bezeichnung = row2.get("Bezeichnung") != null ? DBtoHTML(String.valueOf(row2.get("Bezeichnung"))) : "";
            String id_temp = String.valueOf(row2.get("ID")); // Sicherstellen, dass die ID immer als String vorliegt

            if (row2.get("ID") != null && row2.get("Bezeichnung") != null) {
                if (!isReadOnly) {
                    out.println(String.format("<option value=\"%s\" %s>%s</option>",
                            id_temp,
                            (Integer.parseInt(id_temp) == selected ? "selected" : ""),
                            bezeichnung));
                } else if (Integer.parseInt(id_temp) == selected) {
                    out.println(bezeichnung);
                }
            }
        }

        if (!isReadOnly) {
            out.println("</select>");
        }
    }
%>
