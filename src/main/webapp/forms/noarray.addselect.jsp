<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

﻿<%
    if (feldtyp.equals("addselect") && !array) {

        Object[] columns = AbstractBase.getRowNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
        int selected = -1;
        if (columns != null) {
            selected = Integer.getInteger(columns[0].toString());
        }
        out.println("<select name=\"" + datenfeld + "\" id=\"" + datenfeld + "\">");

        Object[] columns2 = AbstractBase.getRowNative("SELECT ID, Bezeichnung FROM " + auswahlherkunft + " ORDER BY Bezeichnung ASC");
        if (columns2 != null) {
            int value2_id = Integer.getInteger(columns2[0].toString());
            String value2_Bezeichnung = columns2[1].toString();
            out.println("<option value=\"" + value2_id + "\" " + (value2_id == selected ? "selected" : "") + ">" + DBtoHTML(value2_Bezeichnung) + "</option>");
        }
        out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '" + auswahlherkunft.substring(10) + "', '" + datenfeld + "', '');\">" + txt_newentry + "</a></td>");

        out.println("</select>");

    }
%>
