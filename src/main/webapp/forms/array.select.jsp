<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%
    if (feldtyp.equals("select") && array) {


        List<Map> rowlist = AbstractBase.getMappedList("SELECT ID, " + zielAttribut
                + " FROM " + zielTabelle
                + " WHERE " + formular + "ID='" + id + "'"
                + " ORDER BY ID ASC");
        out.println("<table>");
        int i = 0;
        for (Map row : rowlist) {
            int selected = -1;
            String selection = row.get(zielAttribut).toString();
            if (selection != null)
                selected = Integer.parseInt(selection);
            out.println("<input type=\"hidden\" name =\"" + datenfeld + "[" + i + "]" + "_entryid\" value=\"" + rs.getInt("ID") + "\">");

            out.println("<tr>");
            out.println("<td>");

            if (!isReadOnly) {
                out.println("<select name='" + datenfeld + "[" + i + "]'>");
            }

            List<Map> rowlist2 = AbstractBase.getMappedList("SELECT * FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
            for (Map row2 : rowlist2) {
                if (!isReadOnly) {
                    out.println("<option value='" + row2.get("ID").toString() + "' " + (Integer.parseInt(row2.get("ID").toString()) == selected ? "selected" : "") + ">" + DBtoHTML(row2.get("Bezeichnung").toString()) + "</option>");
                } else if ((int)row2.get("ID") == selected) {
                    out.println(DBtoHTML(row2.get("Bezeichnung").toString()));
                }
            }

            if (!isReadOnly) {
                out.println("</select>");
            }
            out.println("</td>");

            String href = "javascript:deleteEntry('" + zielTabelle + "', '" + row.get("ID").toString() + "', '" + returnpage + "', '" + id + "');";
            out.println("<td>");
            if (!isReadOnly) {
                out.println("<a href=\"" + href + "\">");
                out.println(txt_delete);
                out.println("</a>");
            }
            out.println("</td>");

            out.println("</tr>");
            i++;
        }
        out.println("</table>");
    }
%>
