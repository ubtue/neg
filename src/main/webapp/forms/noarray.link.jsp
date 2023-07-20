<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
﻿<%
    if (feldtyp.startsWith("link") && !array) {
        String[] fields = feldtyp.substring(feldtyp.lastIndexOf('(') + 1, feldtyp.lastIndexOf(')')).split(",");

        Map row = AbstractBase.getMappedRow("SELECT * FROM " + zielTabelle + " WHERE " + formularAttribut + "=\"" + id + "\"");
        if (row != null) {
            Map row2 = AbstractBase.getMappedRow("SELECT " + fields[2] + " FROM " + fields[0] + " WHERE ID=" + row.get(fields[1]).toString());
            if (row2 != null) {
                out.println("<a href=\"" + fields[0] + "?ID=" + row.get(fields[1]).toString() + "\">" + (row2.get(fields[2]) != null ? DBtoHTML(row2.get(fields[2]).toString()) : "Zum Datensatz") + "</a>");
            }
        }
    }
%>
