<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

﻿<%@ include file="../configuration.jsp" %>

<%
    int id = -1;
    String title = request.getParameter("title");
    String guest = "";
    if (title.contains("gast_")) {
        title = title.substring(5);
        guest = "gast_";
    }
    int filter = 0;
    String filterParameter = request.getParameter("filterParameter") == null ? "" : request.getParameter("filterParameter");
    try {
        id = Integer.parseInt(request.getParameter("ID"));
        filter = Integer.parseInt(request.getParameter("filter"));
    } catch (NumberFormatException e) {
    }

    String sql_max = DatenbankDB.getFilterSql(guest + title, filter);
    sql_max = sql_max.replace("*", "count(*) c");
    sql_max = sql_max.replace("###", filterParameter);

    String sql_akt = sql_max + (sql_max.contains("WHERE") ? " AND " : " WHERE ") + title + ".ID < " + id;

    Integer akt = AbstractBase.getIntNative(sql_akt) + 1;
    Integer max = AbstractBase.getIntNative(sql_max);

    out.println("[" + akt + " / " + max + "]");
%>
