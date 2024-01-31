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
            }

            List<Object[]> rowlist2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
            for (Object[] columns2 : rowlist2) {
                String value2_id = columns2[0].toString();
                String value2_Bezeichnung = columns2[1].toString();

                if (!isReadOnly) {
                    out.println("<option value=\"" + value2_id + "\" " + (value2_id.equals(selected) ? "selected" : "") + ">" + DBtoHTML(value2_Bezeichnung) + "</option>");
                } else if (value2_id.equals(selected)) {
                    out.println(DBtoHTML(value2_Bezeichnung));
                }
            }

            if (!isReadOnly) {
                out.println("</select>");
            }
            out.println("</td>");

            if (!isReadOnly) {

                if (!selected.equals("-1")) {
                    String href = "";
                    if (returnId.equals("-1")) {
                        href = "javascript:deleteEntry('" + zielTabelle + "', '" + value_id + "', '" + returnpage + "', '" + id + "');";
                    } else {
                        href = "javascript:deleteEntry('" + zielTabelle + "', '" + value_id + "', '" + returnpage + "', '" + returnId + "');";
                    }

                    out.println("<td>");
                    out.println("<a href=\"" + href + "\">");
                    out.println(txt_delete);
                    out.println("</a>");
                    out.println("</td>");
                } else {
                    out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft + "', '" + datenfeld + "[" + i + "]', '');\">" + txt_newentry + "</a></td>");
                }
            }

            out.println("</tr>");
            i++;
        }

        //Create new drop down list when Backend/Admin, not Guest
        if (!isReadOnly) {

            out.println("<tr>");
            out.println("<td>");
            out.println("<select name=\"" + datenfeld + "[" + i + "]\" id=\"" + datenfeld + "[" + i + "]\">");

            List<Object[]> rowlist3 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY "
        + "CASE "
        + "    WHEN id = -1 THEN 0 "
        + "    WHEN id = 1 THEN 1 "
        + "    ELSE 2 "
        + "END, "
        + "Bezeichnung ASC;");

            for (Object[] columns2 : rowlist3) {
                String value2_id = columns2[0].toString();
                String value2_Bezeichnung = columns2[1].toString();
                out.print("<option value=\"" + value2_id + "\">" + DBtoHTML(value2_Bezeichnung) + "</option>");
            }
            out.println("</select>");
            out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft + "', '" + datenfeld + "[" + i + "]', '');\">" + txt_newentry + "</a></td>");
        }

        out.println("</td>");
        out.println("</tr>");
        out.println("</table>");
    }
%>