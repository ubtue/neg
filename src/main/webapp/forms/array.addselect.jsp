<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("addselect") && array) {

        List<Object[]> rowlist = AbstractBase.getListNative("SELECT ID, " + zielAttribut + " FROM " + zielTabelle + " WHERE " + formular + "ID=\"" + id + "\"");

        String selected = "-1";
        int i = 0;
        out.println("<table>");
        for (Object[] columns : rowlist) {
            out.println("<tr>");
            out.println("<td>");

            String value_id = columns[0].toString();
            String value_zielAttribut = columns[1].toString();
            selected = value_zielAttribut;

            if (!isReadOnly) {
                out.println("<input type=\"hidden\" name =\"" + datenfeld + "[" + i + "]" + "_entryid\" value=\"" + value_id + "\">");
                out.println("<select name=\"" + datenfeld + "[" + i + "]\" id=\"" + datenfeld + "[" + i + "]\">");
                out.println("<option value=\"-1\">nicht bearbeitet</option>");
            }

            List<Object[]> rowlist2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
            for (Object[] columns2 : rowlist2) {
                String value2_id = columns2[0].toString();
                String value2_Bezeichnung = columns2[1].toString();

                if (!isReadOnly) {
                    out.println("<option value=\"" + value2_id + "\" " + (value2_id.equals(selected) ? "selected" : "") + ">"+ DBtoHTML(value2_Bezeichnung) + "</option>");
                } else if (value2_id.equals(selected)) {
                    out.println(DBtoHTML(value2_Bezeichnung));
                }
            }

            if (!isReadOnly) {
                out.println("</select>");
            }
            out.println("</td>");
            String href = "javascript:deleteEntry('" + zielTabelle + "', '" + value_id + "', '" + returnpage + "', '" + id + "');";
            out.println("<td>");
            if (!isReadOnly) {
                out.println("<a href=\"" + href + "\">");
                out.println(txt_delete);
                out.println("</a>");
            }
            out.println("</td>");

            if (!isReadOnly) {
                out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft.substring(10) + "', '" + datenfeld + "[" + i + "]', '');\">" + txt_newentry + "</a></td>");
            }
            out.println("</tr>");
            i++;
        }
        out.println("</table>");
    }
%>
