<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  String formular = request.getParameter("Formular");
  String datenfeld = request.getParameter("Datenfeld");

  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM "+formular+" ORDER BY Bezeichnung ASC;");

    out.println("<select name=\""+datenfeld+"\">");
    out.println("<option value=\"-99\" selected>---</option>");
    while ( rs.next() ) {
      out.println("<option value=\""+rs.getInt("ID")+"\">"+DBtoHTML(rs.getString("Bezeichnung"))+"</option>");
    }
    out.println("</select>");
  }
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>
  