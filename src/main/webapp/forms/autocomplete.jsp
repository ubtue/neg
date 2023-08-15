<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%
    if (feldtyp.equals("autocomplete")) {

        out.println("<input type=\"text\" style=\"width: 250px\" id=\"" + datenfeld + "\" name=\"" + datenfeld + "\" " + (size > 0 ? "size=\"" + size + "\" " : ""));
        if (formular.endsWith("freie_suche")) {
            out.print(" placeholder=\"" + platzhalter + "\" ");
        }
        out.println("/>");

        out.println("<script>");
        out.println("$(\"#" + datenfeld + "\").autocomplete({serviceUrl: \""+ Utils.getBaseUrl(request) + "/ajax\", params: {action: \"autocomplete\", form:\"" + auswahlherkunft + "\", field:\"" + formularAttribut + "\"}});");
        out.println("</script>");
        if (!tooltip.equals("")) {
            out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\"" + tooltip + "\"> ? </a>");
        }

    }
%>
