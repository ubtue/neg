<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@ include file="../configuration.jsp" %>

<%
  int id = -1;
  String title = request.getParameter("title");
  String duplicate = Language.getTextfield(session, "navigation", "Duplizieren");

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  } catch (NumberFormatException e) {}

  if ((title.toLowerCase()).equals("einzelbeleg")) {
    //out.println("<form method=\"POST\">");
    %>

    <input type="hidden" name="id" value="<%= id %>">
    <input type="submit" name="duplicate" value=<%= duplicate %>>

    <%
    //out.println("</form>");
  }
%>
