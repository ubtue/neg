<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("textarea") && !array) {

        String value_zielAttribut = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");

        out.print("<div class=\"container\">");

        if (value_zielAttribut != null) {
            out.print(DBtoHTML(value_zielAttribut));
        }
        out.println("</div>");
    }
%>
