<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
    if (feldtyp.equals("checkbox") && !array) {
        out.print("<input name=\"" + datenfeld + "\" ");
        out.print("type=\"checkbox\"");
        if (zielAttribut != null && zielTabelle != null) {
            Integer checked = AbstractBase.getIntNative("SELECT " + zielAttribut + " FROM " + zielTabelle + " WHERE ID=\"" + id + "\"");
            if (checked != null && checked == 1) {
                out.print(" checked ");
            }
            if (isReadOnly) {
                out.print(" disabled ");
            }
        }
        out.println("/>");
    }
%>
