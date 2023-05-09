<%@page isErrorPage="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<!DOCTYPE html>
<HTML>
  <HEAD>

    <TITLE>Nomen et Gens | Fehler</TITLE>

    <%
    // This error page might be called in different contexts (e.g in gast or backend)
    // So we need to use the full URL to make sure they're loaded correctly.
    %>
    <link rel="icon" href="<%=Utils.getBaseUrl(request)%>/gast/layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="<%=Utils.getBaseUrl(request)%>/gast/layout/layout.css" type="text/css">
    <link href="<%=Utils.getBaseUrl(request)%>/gast/layout/fonts/open-sans.css" rel="stylesheet" type="text/css">
    <link href="<%=Utils.getBaseUrl(request)%>/gast/layout/fonts/alegreya-sans-sc.css" rel="stylesheet" type="text/css">
 </HEAD>
 <BODY>
    <jsp:include page="../layout/header.inc.jsp">
      <jsp:param name="current" value="${navigationTitle}"/>
    </jsp:include>

    <div id="content">
        <h1 style="color: red;">Ein Fehler ist aufgetreten:</h1>
        <h2 style="color: red;"><b>${requestScope['javax.servlet.error.message']}</h2>
        <% if (exception != null) { %>
          <h2 style="color: red;"><%= exception.getMessage()%></h2>
          <% // TODO: Show stacktrace only in debug mode %>
          <p style="color: red;"><% exception.printStackTrace(new java.io.PrintWriter(out)); %></p>
        <% } %>
    </div>

    <jsp:include page="../layout/footer.inc.jsp" />

</BODY>
</HTML>
