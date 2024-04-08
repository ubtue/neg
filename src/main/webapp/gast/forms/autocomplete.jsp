<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%
    if (feldtyp.equals("autocomplete")) {

        out.print("<div  style=\"display: flex; align-items: center; \">");
        out.println("<input class=\"ut-form__input ut-form__field\"  type=\"text\" style=\"width: 350px\" id=\"" + datenfeld + "\" name=\"" + datenfeld + "\" " + (size > 0 ? "size=\"" + size + "\" " : ""));
        if (formular.endsWith("freie_suche")) {
            out.print(" placeholder=\"" + platzhalter + "\" ");
        }
        out.println("/>");

         if (!tooltip.equals("")) {
            out.println("<a class=\"ut-link\" href=\"javascript:return false;\" style=\"text-decoration:none;color:gray; margin-left: 5px;\" title=\"" + tooltip + "\"> ? </a>");
        }
        out.println("</div>");

        // Instead of the "autocomplete" function we use the "devbridgeAutocomplete" function from jQuery-Autocomplete to avoid known issues / naming conflicts with jQuery UI.
        out.println("<script>");
        out.println("$(document).ready(function() {");
        out.println("$(\"#" + datenfeld + "\").devbridgeAutocomplete({serviceUrl: \""+ Utils.getBaseUrl(request) + "/ajax\", params: {action: \"autocomplete\", form:\"" + auswahlherkunft + "\", field:\"" + formularAttribut + "\"}});");
        out.println("});");
        out.println("</script>");
    }
%>
