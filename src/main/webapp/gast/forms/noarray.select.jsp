<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>

<%!
public String RenderHierarchyNode(SelektionHierarchy node, Set<Integer> nodeIdsToDisplay, int selected, int level) {
    // Unfortunately <optgroup> cannot be used since the group will not be selectable itself,
    // so instead we use prefix characters to signalize parent/child relationships.
    String s = "<option value=\"" + node.getId() + "\"";
    if (node.getId().equals(selected)) {
        s += " selected";
    }
    s += ">";

    for (int i=0;i<level;i++) {
        s += "&nbsp;&nbsp;";
    }
    if (level > 0) {
        s += "&gt;&nbsp;";
    }

    s += Utils.escapeHTML(node.getBezeichnung());
    s += "</option>";

    for (SelektionHierarchy child : node.getChildren()) {
        if (nodeIdsToDisplay.contains(child.getId()))
        s += RenderHierarchyNode(child, nodeIdsToDisplay, selected, level + 1);
    }

    return s;
}

public Set<Integer> GetHierarchyNodeIDsToDisplay(List<SelektionHierarchy> nodes) {
    // Make sure we have all delivered nodes as well as all their parents
    // (Especially in GAST we only get child nodes linked to quelle.zuVeroeffentlichen=1
    // and cannot display them properly without adding their parent ids.)
    Set<Integer> ids = new TreeSet<>();
    for (SelektionHierarchy node : nodes) {
        ids.add(node.getId());
        SelektionHierarchy parent = node.getParent();
        while (parent != null) {
            ids.add(parent.getId());
            parent = parent.getParent();
        }
    }
    return ids;
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

            out.println("<div class = \"wrapper\" style=\"display: flex; align-items: center;\">");
            out.println("<select class=\"ut-form__select ut-form__field\"  id=\"id_field\" name=\"" + datenfeld + "\"  style=\"width: 350px\"");
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
            // If DB result depends on GAST, we need to do a second query to get all nodes from backend
            List<SelektionHierarchy> hierarchyNodes = SelektionDB.getListHierarchy(auswahlherkunft);
            List<SelektionHierarchy> hierarchyNodesAll = hierarchyNodes;
            String auswahlherkunftBackend = SelektionDB.getNonGastTable(auswahlherkunft);
            if (auswahlherkunftBackend != null) {
                hierarchyNodesAll = SelektionDB.getListHierarchy(auswahlherkunftBackend);
            }
            Set<Integer> hierarchyNodeIdsToDisplay = GetHierarchyNodeIDsToDisplay(hierarchyNodes);
            for (SelektionHierarchy node : hierarchyNodesAll) {
                if (node.getParent() == null && hierarchyNodeIdsToDisplay.contains(node.getId())) {
                    out.println(RenderHierarchyNode(node, hierarchyNodeIdsToDisplay, selected, 0));
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
                } else {
                    value = DBtoHTML(value);
                }

                if (!isReadOnly) {
                    out.println("<option value=\"" + Integer.parseInt(row.get("ID").toString()) + "\" " + (Integer.parseInt(row.get("ID").toString()) == selected ? "selected" : "") + ">" + value + "</option>");
                } else if (Integer.parseInt(row.get("ID").toString()) == selected) {
                    out.println(value);
                }
            }
        }

        if (!isReadOnly) {
            out.println("</select>");
            if(tooltip.equals("")) {
                out.println("</div>");
            }
        }
        if (!tooltip.equals("")) {

            String folgendeAuswahl = request.getParameter("FolgendeAuswahl");

            if(folgendeAuswahl != null && folgendeAuswahl.equals("Yes")) {
                out.println("<a class=\"ut-link\" href=\"javascript:return false;\" style=\"text-decoration:none;color:gray; margin-left: 5px;\" title=\"" + tooltip + "\"> ? \\ </a>");
            }
            else{
                out.println("<a class=\"ut-link\" href=\"javascript:return false;\" style=\"text-decoration:none;color:gray; margin-left: 5px;\" title=\"" + tooltip + "\"> ? </a>");
            }
            out.println("</div>");
        }

    }
%>