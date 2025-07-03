<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@page import="de.uni_tuebingen.ub.nppm.db.PersonDB"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Filter" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Constants" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="java.math.BigInteger" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.exception.*" isThreadSafe="false" %>

<%@ include file="configuration.jsp"%>

<%
    Language.setLanguage(request);
%>
<jsp:include page="layout/titel.administration.jsp" />
<div id="form">
<div id="container" class="container mt-2">
    <div id="initials" class="">DATENBANK LÄDT...</div>
    <div id="list" class="fill-height"></div>
</div>
</div>

