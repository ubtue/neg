<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%
    if (feldtyp.equals("generator") && !array) {
        String sql = "";
        sql = "SELECT " + zielAttribut
                + " FROM " + zielTabelle
                + " WHERE " + zielAttribut
                + " LIKE '" + numberResize(((Integer) session.getAttribute("GruppeID")).intValue(), 2) + numberResize(((Integer) session.getAttribute("BenutzerID")).intValue(), 2) + "%'"
                + " ORDER BY " + zielAttribut + " DESC";

        String newNumber = AbstractBase.getStringNative(sql);
        if (newNumber != null) {
            newNumber = newNumber.substring(4);
            newNumber = numberResize(((Integer) session.getAttribute("GruppeID")).intValue(), 2) + numberResize(((Integer) session.getAttribute("BenutzerID")).intValue(), 2) + numberResize(Integer.parseInt(newNumber) + 1, 5);
            out.println("<input type=\"button\" value=\"generieren" + newNumber + "\" onClick=\"javascript:\"/>");
        }
    }
%>
