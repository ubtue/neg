<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

﻿<%@ include file="../configuration.jsp" %>

<%
    int akt = 0;
    int max = 0;

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

    String sql = DatenbankDB.getFilterSql(guest + title, filter);
    sql = sql.replace("*", "count(*) c");
    sql = sql.replace("###", filterParameter);

    Object[] columns = AbstractBase.getRowNative(sql + (sql.contains("WHERE") ? " AND " : " WHERE ") + title + ".ID < " + id);
    if (columns != null && columns.length > 0) {
        akt = Integer.getInteger(columns[0].toString());
    }

    Object[] columns2 = AbstractBase.getRowNative(sql);
    if (columns2 != null && columns2.length > 0) {
        max = Integer.getInteger(columns2[0].toString());
    }

    out.println("[" + akt + " / " + max + "]");
%>
