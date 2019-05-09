<%@ include file="../configuration.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = -1;
  String title = request.getParameter("title");

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  } catch (NumberFormatException e) {}

  if ((title.toLowerCase()).equals("einzelbeleg")) {
    //out.println("<form method=\"POST\">");
    out.println("<input type=\"hidden\" name=\"id\" value=\""+id+"\">");
    out.println("<input type=\"submit\" name=\"duplicate\" value=\"duplizieren\">");
    //out.println("</form>");
  }

%>
