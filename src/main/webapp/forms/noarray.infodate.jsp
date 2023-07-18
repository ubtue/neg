<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>

﻿<%
    if (feldtyp.equals("infodate") && !array) {
        Object[] columns = AbstractBase.getRowNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
        if (columns != null && columns.length > 0) {
            out.print(DBtoHTML(columns[0].toString()));
        }
    }
%>
