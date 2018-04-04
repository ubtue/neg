<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = -1;
  String title = request.getParameter("title");
  int filter = 0;
  String filterParameter = null;
    String formular = request.getParameter("formular"); 
  

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  }
  catch (Exception e) {}
  try {
    filter = ((Integer) session.getAttribute(formular + "filter")).intValue();
    filterParameter = (String) session.getAttribute(formular + "filterParameter");
  }
  catch (Exception e) {}

  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    if (!title.contains("gast_")) {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT Nummer, Bezeichnung FROM datenbank_filter WHERE Formular='"+title+"' ORDER BY Nummer ASC;");
      out.println("<select name=\"filter\">");
      while (rs.next()) {
        out.println("<option value=\""+rs.getInt("Nummer")+"\""+(rs.getInt("Nummer")==filter?" selected":"")+">"+DBtoHTML(rs.getString("Bezeichnung"))+"</option>");
      }
      out.println("</select>");
      out.println("<input type=\"text\" name=\"filterParameter\" value=\""+(filterParameter==null?"":filterParameter)+"\" size=\"10\" maxlength=\"50\">");
      out.println("<input type=\"submit\" value=\"filtern\">");
    }
  }
  catch (SQLException e) {out.println(e);}
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>