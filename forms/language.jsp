<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<div>
<%
  int id = -1;
  String title = request.getParameter("title");
  String language = null;

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  }
  catch (Exception e) {}
  try {
    language = (String) session.getAttribute("Sprache");
  }
  catch (Exception e) {}

  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT Kuerzel, Sprache FROM datenbank_sprachen ORDER BY ID");
    while (rs.next()) {
    
    out.println("<input type=\"submit\" name=\"language\" alt=\""+DBtoHTML(rs.getString("Sprache"))+"\" title=\""+DBtoHTML(rs.getString("Sprache"))+"\"  value=\""+rs.getString("Kuerzel")+"\" style=\"border:"+(rs.getString("Kuerzel").equals(language)?"#000":"#fff")+" 1px solid; background-image: url(layout/flags/"+rs.getString("Kuerzel")+".gif); height: 14px; width: 22px;\" >");
    
    }
  }
  catch (SQLException e) {out.println(e);}
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>
</div>