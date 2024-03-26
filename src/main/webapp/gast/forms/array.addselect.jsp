<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("addselect") && array) {

        List<Object[]> rowlist = AbstractBase.getListNative("SELECT ID, " + zielAttribut + " FROM " + zielTabelle + " WHERE " + formular + "ID=\"" + id + "\"");

         if (!rowlist.isEmpty()) {
            String selected = "-1";

            out.println("<table class=\"ut-table \">");
            for (Object[] columns : rowlist) {
                out.println("<tr class=\"ut-table__row\">");
                out.println("<td class=\"ut-table__item ut-table__body__item\">");

                String value_id = columns[0].toString();
                String value_zielAttribut = columns[1].toString();
                selected = value_zielAttribut;


                List<Object[]> rowlist2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
                for (Object[] columns2 : rowlist2) {
                    String value2_id = columns2[0].toString();
                    String value2_Bezeichnung = columns2[1].toString();

                    if (value2_id.equals(selected)) {
                        out.println(DBtoHTML(value2_Bezeichnung));
                    }
                }

                out.println("</td>");
                out.println("</tr>");

            }
            out.println("</table>");
        }
    }
%>