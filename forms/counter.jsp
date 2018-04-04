<%@ include file="../configuration.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int akt = 0;
  int max = 0;

  int id = -1;
  String title = request.getParameter("title");
  String guest = "";
  if (title.contains("gast_")) {
    title = title.substring(5);
    guest = "gast_";
  }
  int filter = 0;
  String filterParameter = request.getParameter("filterParameter")==null?"":request.getParameter("filterParameter");
  try {
    id = Integer.parseInt(request.getParameter("ID"));
    filter = Integer.parseInt(request.getParameter("filter"));
  } catch (NumberFormatException e) {}


  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    String sql = "SELECT * FROM "+title;

    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();

    rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+guest+title+"' AND Nummer='"+filter+"';");
    if (rs.next()) {
      sql = rs.getString("SQLString");
    }

    sql = sql.replace("*", "count(*) c");
    sql = sql.replace("###", filterParameter);

    rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+title+".ID < "+id);
    if (rs.next())
      akt = rs.getInt("c") + 1;

    rs = st.executeQuery(sql);
    if (rs.next())
      max = rs.getInt("c");

  } catch (SQLException e) {
    out.println(e);
  } finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
  out.println("["+akt+" / "+max+"]");
%>