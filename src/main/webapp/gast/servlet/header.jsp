<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href="layout/fonts/open-sans.css" rel="stylesheet" type="text/css">
    <link href="layout/fonts/alegreya-sans-sc.css" rel="stylesheet" type="text/css">
    <link href="../layout/jquery-ui-1.10.3.css" rel="stylesheet" type="text/css">
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/jquery-ui-1.10.3.js" type="text/javascript"></script>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>

    ${additionalCss}

    ${additionalJs}

 </HEAD>
 <BODY>
    <jsp:include page="../layout/header.inc.jsp">
      <jsp:param name="current" value="${navigationTitle}"/>
    </jsp:include>

    <div id="content">
