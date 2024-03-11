<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("gndlink") && !array) {
        String gndId = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
        if (gndId != null && !gndId.trim().equals("")) {
            String schemaOrgAttribute = "";
            if (schemaOrgProperty != null && !schemaOrgProperty.isEmpty()) {
                schemaOrgAttribute = " property=\"" + schemaOrgProperty + "\"";
            }
            String link = "<a class=\"ut-link ut-link--external ut-link--context-icon\" href=\"https://d-nb.info/gnd/" + DBtoHTML(gndId) + "\" target=\"_blank\"" + schemaOrgAttribute + "> " + gndIcon + "</a>";
            out.println(link);
        }
    }
%>