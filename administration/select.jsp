<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  String sql = "SELECT ID \"key\", Bezeichnung \"value\" FROM "+request.getParameter("Tabelle")+" ORDER BY value ASC";

  if (request.getParameter("Tabelle").equals("datenbank_sprachen")) {
    sql = "SELECT Kuerzel \"key\", Sprache \"value\" FROM "+request.getParameter("Tabelle")+" ORDER BY value ASC";
  }

  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery(sql);

    out.println("<select name=\""+request.getParameter("Feldname")+"\">");
    while( rs.next() ) {
      out.println("<option value=\""+rs.getString("key")+"\">"+DBtoHTML(rs.getString("value"))+"</option>");
    }
    out.println("</select>");
  }
  catch (Exception e) {
    out.println(e);
  }
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>