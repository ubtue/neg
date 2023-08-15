<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
    String sql = "SELECT ID \"key\", Bezeichnung \"value\" FROM " + request.getParameter("Tabelle") + " ORDER BY value ASC";

    if (request.getParameter("Tabelle").equals("datenbank_sprachen")) {
        sql = "SELECT Kuerzel \"key\", Sprache \"value\" FROM " + request.getParameter("Tabelle") + " ORDER BY value ASC";
    }

    out.println("<select name=\"" + request.getParameter("Feldname") + "\">");
    List<Object[]> rows = AbstractBase.getListNative(sql);
    for (Object[] columns : rows) {
        String key = columns[0].toString();
        String value = columns[1].toString();

        //To pre select a option in the select element
        String selected = "";
        if (request.getParameter("checkValue") != null && request.getParameter("checkValue").equals(key)) {
            selected = "selected";
        }
        out.println("<option value=\"" + key + "\"" + selected + ">" + DBtoHTML(value) + "</option>");
    }
    out.println("</select>");

%>
