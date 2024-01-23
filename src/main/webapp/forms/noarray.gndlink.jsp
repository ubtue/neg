<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("gnd") && !array) {

        String gndId = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");

        if (gndId != null && !gndId.trim().equals("")) {

        String link = "<a href=\"https://d-nb.info/gnd/" + DBtoHTML(gndId) + "\" target=\"_blank\" style=\"display: inline-block; line-height: 40px; vertical-align: middle; margin-top: 10px;\"> " + gndIcon + "</a>";

        out.println(link);
        }
    }
%>