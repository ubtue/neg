<%@ include file="../configuration.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int akt = 0;
  int max = 0;

  String id = "";
  String title = request.getParameter("title");
  if (title.contains("gast_")) {
    title = title.substring(5);
  }
    id = request.getParameter("ID");

  out.println("ID: ");
          if(title.toLowerCase().equals("einzelbeleg")) out.print("B");
          else if(title.toLowerCase().equals("person")) out.print("P");
          else if(title.toLowerCase().equals("namenkommentar")) out.print("N");
          else if(title.toLowerCase().equals("quelle")) out.print("Q");
          else if(title.toLowerCase().equals("edition")) out.print("E");
          else if(title.toLowerCase().equals("handschrift")) out.print("T");
          else if(title.toLowerCase().equals("mghlemma")) out.print("M");
  
  out.println(id);
%>