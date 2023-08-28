<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%!
public String RenderHierarchyNode(SelektionHierarchy node, int level) {
    String s = "<option>";

    for (int i=0;i<level;i++) {
        s += "&nbsp;";
    }
    if (level > 0) {
        s += "&gt;&nbsp;";
    }

    s += Utils.escapeHTML(node.getBezeichnung());
    s += "</option>";

    for (SelektionHierarchy child : node.getChildren()) {
        s += RenderHierarchyNode(child, level + 1);
    }

    return s;
}
%>


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

        boolean isHierarchy = SelektionDB.isHierarchy(auswahlherkunft);
        if (isHierarchy) {
            // Vorsicht GAST berücksichtigen falls notwendig
            String auswahlherkunftNoGast = auswahlherkunft.replaceAll("^gast", "");
            for (SelektionHierarchy node : SelektionDB.getListHierarchy(auswahlherkunftNoGast)) {
                if (node.getParent() == null) {
                    // Unfortunately <optgroup> cannot be used here since the group will not be selectable itself.
                    out.println(RenderHierarchyNode(node, 0));
                }
            }
        } else {
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
        }

        if (!isReadOnly) {
            out.println("</select>");
        }
        if (!tooltip.equals("")) {
            out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\"" + tooltip + "\"> ? </a>");
        }

    }
%>
