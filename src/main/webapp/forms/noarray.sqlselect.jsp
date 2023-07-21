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
            if (!isReadOnly) {
                out.println("<option value=\"" + row2.get("ID").toString() + "\" " + (Integer.parseInt(row2.get("ID").toString()) == selected ? "selected" : "") + ">" + DBtoHTML(row2.get("Bezeichnung").toString()) + "</option>");
            } else if (Integer.parseInt(row2.get("ID").toString()) == selected) {
                out.println(DBtoHTML(row2.get("Bezeichnung").toString()));
            }
        }

        if (!isReadOnly) {
            out.println("</select>");
        }

    }
%>
