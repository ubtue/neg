<%@ include file="../../configuration.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = -1;
  String title = request.getParameter("title");
     String formular = request.getParameter("formular");

  String guest = "";
  if (title.contains("gast_")) {
    title = title.substring(5);
    guest = "gast_";
  }
  int filter = 0;
  String filterParameter = null;
  try {
    id = Integer.parseInt(request.getParameter("ID"));
    filter = ((Integer)session.getAttribute(formular+"filter")).intValue();
    filterParameter = (String)(session.getAttribute(formular+"filterParameter"));
  } catch (Exception e) {}

  int newid = id;
  String label = "";
  String backgroundClass = "";

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
    if (request.getParameter("Command").equals("next")) {
      label = ">";
      sql = sql.replace("*", title+".ID");
      sql += (sql.contains("WHERE")?" AND":" WHERE")+" "+title+".ID > "+id+" ORDER BY ID ASC;";
      backgroundClass = "next";
    }
    else if (request.getParameter("Command").equals("back")) {
      label = "<";
      sql = sql.replace("*", title+".ID");
      sql += (sql.contains("WHERE")?" AND":" WHERE")+" "+title+".ID < "+id+" ORDER BY ID DESC;";
      backgroundClass = "prev";
    }
    else if (request.getParameter("Command").equals("last")) {
      label = ">|";
      sql = sql.replace("*", "max("+title+".ID) ID");
      backgroundClass = "next_end";
    }
    else if (request.getParameter("Command").equals("first")) {
      label = "|<";
      sql = sql.replace("*", "min("+title+".ID) ID");
      backgroundClass = "prev_end";
    }
    else if (request.getParameter("Command").equals("new")) {
      label = "neu";
      sql = sql.replace("*", "max("+title+".ID) ID");
    }

    if (filterParameter != null)
      sql = sql.replace("###", filterParameter);
    rs = st.executeQuery(sql);
    if (rs.next()) {
      newid = rs.getInt("ID");
    }
  } catch (Exception e) {
    out.println(e);
  } finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }

  out.println("<a class='pager "+backgroundClass+"' href='?ID="+(request.getParameter("Command").equals("new")?"-1":newid)+"'></a>");
%>
