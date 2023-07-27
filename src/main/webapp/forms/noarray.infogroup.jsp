<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("infogroup") && !array) {
        String value_zielAttribut = AbstractBase.getStringNative("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if (value_zielAttribut != null && !value_zielAttribut.trim().equals("")) {
            out.print(DBtoHTML(value_zielAttribut));
        }
    }
%>
