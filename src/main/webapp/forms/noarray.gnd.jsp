<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("gnd") && !array) {

        String gndId = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");

        if (gndId != null && !gndId.trim().equals("")) {

        String link = "<a href=\"https://portal.dnb.de/opac/simpleSearch?query=idn%3D" + gndId + "&cqlMode=true" + "\" style=\"display: inline-block; line-height: 40px; vertical-align: middle; margin-top: 10px;\"> " + gnd + "</a>";

        out.println(link);
        }
    }
%>