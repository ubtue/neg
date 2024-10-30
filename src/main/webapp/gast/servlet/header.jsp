<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>
<!DOCTYPE html>
<HTML>
  <HEAD>
    <%
    String fullTitle = "Nomen et Gens";
    String title = (String)request.getAttribute("title");
    if (title != null && !title.isEmpty()) {
        fullTitle += " | " + title;
    }
    %>
    <TITLE><%=fullTitle%></TITLE>
    <link rel="icon" href="<%=Utils.getBaseUrl(request)%>/gast/layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="<%=Utils.getBaseUrl(request)%>/gast/layout/layout.css" type="text/css">
    <link href="<%=Utils.getBaseUrl(request)%>/gast/layout/fonts/open-sans.css" rel="stylesheet" type="text/css">
    <link href="<%=Utils.getBaseUrl(request)%>/gast/layout/fonts/alegreya-sans-sc.css" rel="stylesheet" type="text/css">

    <script src="<%=Utils.getBaseUrl(request)%>/webjars/jquery/3.7.1/jquery.min.js" type="text/javascript"></script>
    <script src="<%=Utils.getBaseUrl(request)%>/webjars/jQuery-Autocomplete/1.4.11/jquery.autocomplete.min.js" type="text/javascript"></script>
    <script src="<%=Utils.getBaseUrl(request)%>/javascript/funktionen.js" type="text/javascript"></script>
    <script src="<%=Utils.getBaseUrl(request)%>/javascript/javascript.js" type="text/javascript"></script>

    ${additionalCss}

    ${additionalJs}

 </HEAD>
 <BODY>
    <jsp:include page="../layout/header.inc.jsp">
      <jsp:param name="current" value="${navigationTitle}"/>
    </jsp:include>

    <div id="content">
