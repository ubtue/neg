<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%
    if (feldtyp.equals("autocomplete")) {

        out.print("<input type=\"text\" style=\"width: 250px;");
        if ("filterTitle".equals(datenfeld)) {
            out.print(" height: 40px;");
        }
        out.print("\" id=\"" + datenfeld + "\" name=\"" + datenfeld + "\" ");
        if (size > 0) {
            out.print("size=\"" + size + "\" ");
        }
        if (valueAutomcomplete != null && !valueAutomcomplete.trim().isEmpty()) {
            out.print("value=\"" + Utils.escapeHTML(valueAutomcomplete) + "\" ");
        }
        if (formular.endsWith("freie_suche") || formular.equals("statistik")) {
            out.print("placeholder=\"" + platzhalter + "\" ");
        }
        out.println("/>");

        // Instead of the "autocomplete" function we use the "devbridgeAutocomplete" function from jQuery-Autocomplete to avoid known issues / naming conflicts with jQuery UI.
        out.println("<script>");
        out.println("$(\"#" + datenfeld + "\").devbridgeAutocomplete({serviceUrl: \""+ Utils.getBaseUrl(request) + "/ajax\", params: {action: \"autocomplete\", form:\"" + auswahlherkunft + "\", field:\"" + formularAttribut + "\"}});");
        out.println("</script>");
        if (!tooltip.equals("")) {
            out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\"" + tooltip + "\"> ? </a>");
        }

    }
%>
