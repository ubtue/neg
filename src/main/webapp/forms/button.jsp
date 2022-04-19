<%@ include file="../configuration.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = 1;
  try {
    id = Integer.parseInt(request.getParameter("ID"));
  } catch (NumberFormatException e) {}

  String label = "";
  String sql = "";
  if (request.getParameter("Command").equals("next")) {
    label = ">";
    sql = "SELECT ID FROM "+request.getParameter("Formular")+" WHERE ID > "+id+" ORDER BY ID ASC;";
  }
  else if (request.getParameter("Command").equals("back")) {
    label = "<";
    sql = "SELECT ID FROM "+request.getParameter("Formular")+" WHERE ID < "+id+" ORDER BY ID DESC;";
  }
  else if (request.getParameter("Command").equals("last")) {
    label = ">|";
    sql = "SELECT min(ID) ID FROM "+request.getParameter("Formular")+";";
  }
  else if (request.getParameter("Command").equals("first")) {
    label = "|<";
    sql = "SELECT max(ID) ID FROM "+request.getParameter("Formular")+";";
  }

  else if (request.getParameter("Command").equals("new")) {
    label = "neu";
    sql = "SELECT max(ID) ID FROM "+request.getParameter("Formular")+";";
  }

  int newid = 0;
  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;
  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery(sql);
    if (rs.next()) {
      newid = rs.getInt("ID");
    }
  } catch (SQLException e) {
    out.println(e);
  } finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
  out.println("<form method=\"POST\">");
  out.println("<input type=\"hidden\" name=\"Formular\" value=\""+request.getParameter("Formular")+"\">");
  out.println("<input type=\"hidden\" name=\"ID\" value=\""+newid+"\">");
  out.println("<input type=\"submit\" value=\""+label+"\">");
  out.println("</form>");
%>
