<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="de.uni_tuebingen.ub.nppm.db.SucheDB" isThreadSafe="false" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.nio.charset.Charset"%>

<%    
    String query = request.getParameter("q");
    String form = request.getParameter("form");
    String field = request.getParameter("field");
    List<String> matched = SucheDB.getCountryText(field, form, query);
    Iterator<String> iterator = matched.iterator();
    while (iterator.hasNext()) {
        String country = (String) iterator.next();
        out.println(country);
    }
%>
