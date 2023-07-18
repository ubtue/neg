<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>

﻿<%
    if (feldtyp.equals("addselect") && !array) {
        out.println("<select name=\"" + datenfeld + "\" id=\"" + datenfeld + "\">");

        int selected = AbstractBase.getIntNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
        List<Object[]> rows2 = AbstractBase.getListNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
        for (Object[] columns2 : rows2) {
            int value2_id = Integer.parseInt(columns2[0].toString());
            String value2_Bezeichnung = columns2[1].toString();
            out.println("<option value=\"" + value2_id + "\" " + ((value2_id == selected) ? "selected" : "") + ">" + DBtoHTML(value2_Bezeichnung) + "</option>");
        }
        out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft.substring(10) + "', '" + datenfeld + "', '');\">" + txt_newentry + "</a></td>");

        out.println("</select>");

    }
%>
