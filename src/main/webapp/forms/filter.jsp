<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>

﻿<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
    int id = -1;
    String title = request.getParameter("title");
    int filter = 0;
    String filterParameter = null;
    String formular = request.getParameter("formular");

    try {
        id = Integer.parseInt(request.getParameter("ID"));
    } catch (Exception e) {
    }
    try {
        filter = ((Integer) session.getAttribute(formular + "filter")).intValue();
        filterParameter = (String) session.getAttribute(formular + "filterParameter");
    } catch (Exception e) {
    }

    if (!title.contains("gast_")) {
        List<DatenbankFilter> filters = DatenbankDB.getListFilter();
        out.println("<select name=\"filter\">");
        for (DatenbankFilter datenbankFilter : filters) {
            if (datenbankFilter.getFormular().equals("title")) {
                out.println("<option value=\"" + datenbankFilter.getNummer() + "\"" + (datenbankFilter.getNummer() == filter ? " selected" : "") + ">" + DBtoHTML(datenbankFilter.getBezeichnung()) + "</option>");
            }
        }
        out.println("</select>");
        out.println("<input type=\"text\" name=\"filterParameter\" value=\"" + (filterParameter == null ? "" : filterParameter) + "\" size=\"10\" maxlength=\"50\">");
        out.println("<input type=\"submit\" value=\"filtern\">");
    }

%>
