<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("checkbox") && !array) {

%>
<div class="ut-form__checkbox  ">
    <label class="" for="checkbox1">

<%

       out.print("<input id=\"checkbox1\" name=\"" + datenfeld + "\" ");
       out.print("type=\"checkbox\"");
        if (zielAttribut != null && zielTabelle != null) {
            String checked = AbstractBase.getStringNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
            if (checked != null && (checked.equals("true") || checked.equals("1"))) {
                out.print(" checked ");
            }
            if (isReadOnly) {
                out.print(" disabled ");
            }
        }
        out.println("/>");
    }
%>
 </label>
</div>