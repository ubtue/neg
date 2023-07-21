<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
    if (feldtyp.equals("addselectandtext") && array) {
        List<Map> rowlist = AbstractBase.getMappedList("SELECT " + zielTabelle + ".ID, " + auswahlherkunft + ".Bezeichnung, " + auswahlherkunft + ".ID value FROM " + zielTabelle + ", " + auswahlherkunft + " WHERE " + zielTabelle + "." + formular + "ID=" + id + " AND " + zielTabelle + "." + zielAttribut + "=" + auswahlherkunft + ".ID ORDER BY " + auswahlherkunft + ".Bezeichnung");
        out.println("<table>");
        int i = 0;
        for (Map row : rowlist) {
            out.println("<tr>");
            out.println("<input type=\"hidden\" name =\"" + datenfeld + "[" + i + "]" + "_entryid\" value=\"" + row.get("ID").toString() + "\">");


                out.println("<input type=\"hidden\" name=\"" + datenfeld + "[" + i + "]\" value=\"" + row.get("value").toString() + "\" />");
                out.println("<td>" + row.get(auswahlherkunft + ".Bezeichnung").toString() + "</td>");
                String href = "javascript:deleteEntry('" + zielTabelle + "', '" + row.get(zielTabelle + ".ID").toString() + "', '" + returnpage + "', '" + id + "');";
                out.println("<td>");
                out.println("<a href=\"" + href + "\">");
                out.println(txt_delete);
                out.println("</a>");
                out.println("</td>");

            out.println("</tr>");
            i++;
        }

        out.println("<tr>");
        out.println("<td>");
        out.println("<select name=\"" + datenfeld + "[" + i + "]\">");
        List<Map> rowlist2 = AbstractBase.getMappedList("SELECT * FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
        for (Map row2 : rowlist2) {
            out.println("<option value=\"" + row2.get("ID").toString() + "\" " + (row2.get("ID").toString().equals("-1") ? "selected" : "") + ">" + DBtoHTML(row2.get("Bezeichnung").toString()) + "</option>");
        }
        out.println("</select>");
        out.println("</td>");
        out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft.substring(10) + "', '" + datenfeld + "[" + i + "]', '');\">" + txt_newentry + "</a></td>");
        out.println("</tr>");

        out.println("</table>");

    }
%>
