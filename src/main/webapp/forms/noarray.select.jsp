<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
    if (feldtyp.equals("select") && !array) {

        int selected = -1;
        if (Integer.parseInt(id) > 0) {
            String sql = "SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"";
            Integer selection = AbstractBase.getIntNative(sql);
            if (selection != null) {
                selected = selection;
            }
        }
        if (!isReadOnly) {
            out.println("<select name=\"" + datenfeld + "\"  style=\"width: 250px\"");
            out.println(">");
            if (typeFile != null) {
                out.println("<option value=\"\">Datei ausw&auml;hlen</option>");
            }
        }
        if (isEmpty) {
            out.println("<option value=\"-2\">ist leer</option>");
        }

        String sql = "SELECT * FROM " + auswahlherkunft;
        if (auswahlherkunftFilter != null && !auswahlherkunftFilter.equals("") && filter != null && !filter.equals("")) {
            sql += " WHERE " + auswahlherkunftFilter + "='" + filter + "'";
        }
        if (!isSorted) {
            sql += " ORDER BY Bezeichnung ASC";
        }

        List<Map> rowlist = AbstractBase.getMappedList(sql);
        for (Map row : rowlist) {
            String value = row.get("Bezeichnung").toString();
            if (datenfeld.startsWith("Namenkommentar")) {
                value = format(value, "PLemma");
            }

            if (!isReadOnly) {
                out.println("<option value=\"" + Integer.parseInt(row.get("ID").toString()) + "\" " + (Integer.parseInt(row.get("ID").toString()) == selected ? "selected" : "") + ">" + DBtoHTML(value) + "</option>");
            } else if (Integer.parseInt(row.get("ID").toString()) == selected) {
                out.println(DBtoHTML(value));
            }
        }

        if (!isReadOnly) {
            out.println("</select>");
        }
        if (!tooltip.equals("")) {
            out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\"" + tooltip + "\"> ? </a>");
        }

    }
%>
