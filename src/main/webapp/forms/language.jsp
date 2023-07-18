<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>

﻿<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>
<div>
    <%
        int id = -1;
        String title = request.getParameter("title");
        String language = null;

        try {
            id = Integer.parseInt(request.getParameter("ID"));
        } catch (Exception e) {
        }
        try {
            language = (String) session.getAttribute("Sprache");
        } catch (Exception e) {
        }

        List<DatenbankSprache> sprachen = DatenbankSprachenDB.getList();
        for (DatenbankSprache sprache : sprachen) {
            out.println("<input type=\"submit\" name=\"language\" alt=\"" + DBtoHTML(sprache.getSprache()) + "\" title=\"" + DBtoHTML(sprache.getSprache()) + "\"  value=\"" + sprache.getKuerzel() + "\" style=\"border:" + (sprache.getKuerzel().equals(language) ? "#000" : "#fff") + " 1px solid; background-image: url(layout/flags/" + sprache.getKuerzel() + ".gif); height: 14px; width: 22px;\" >");
        }
    %>
</div>
