<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("textfield") && array) {

        List<Object[]> rowlist = AbstractBase.getListNative("SELECT ID, " + zielAttribut + " FROM " + zielTabelle + " WHERE " + formular + "ID=\"" + id + "\"");
        out.println("<table class=\"ut-table ut-table--striped ut-table--striped--color-primary-3\">");


        for (Object[] row : rowlist) {
            String row_id = row[0].toString();
            String row_zielAttribut = row[1].toString();

            out.println("<tr class=\"ut-table__row\">");
            out.println("<td class=\"ut-table__item ut-table__body__item\">");

            String output = DBtoHTML(row_zielAttribut);
            if (schemaOrgProperty != null && !schemaOrgProperty.isEmpty()) {
                output = "<span property=\"" + schemaOrgProperty + "\">" + output + "</span>";
            }
            out.print(output);

            out.println("</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    }
%>