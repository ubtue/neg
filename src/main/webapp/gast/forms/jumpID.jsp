<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = -1;
  String title = request.getParameter("title");
  String guest = "";
  if (title.contains("gast_")) {
    title = title.substring(5);
    guest = "gast_";
  }
  int filter = 0;
  String filterParameter = request.getParameter("filterParameter");

  try {
    id = Integer.parseInt(request.getParameter("ID"));
    filter = Integer.parseInt(request.getParameter("filter"));
  } catch (NumberFormatException e) {}

  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT Nummer, Bezeichnung FROM datenbank_filter WHERE Formular='"+guest+title+"' ORDER BY Nummer ASC;");
%>
   <span>Springe zu NeG-ID:</span>
   <input type="text" name="jumpValueID" size="5">
   <input type="hidden" name="jumpTable" value="<%= title %>">
   <input type="hidden" name="akt" value="<%= id %>">
   <input type="submit" name="jumpID" value="los">
<%
  }
  catch (SQLException e) {out.println(e);}
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>
