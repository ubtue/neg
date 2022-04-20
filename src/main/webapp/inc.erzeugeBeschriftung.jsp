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
  String textfeld = request.getParameter("Textfeld");
  String sprache = "de";
  if (session != null && session.getAttribute("Sprache") != null)
    sprache = (String)session.getAttribute("Sprache");

  String sql = "";
  if (datenfeld == null && textfeld != null) {
    sql = "SELECT "+sprache+" Beschriftung FROM datenbank_texte WHERE Formular=\""+formular+"\" AND Textfeld=\""+textfeld+"\";";
  }
  else if (datenfeld != null && textfeld == null) {
    sql = "SELECT "+sprache+"_Beschriftung Beschriftung FROM datenbank_mapping WHERE Formular=\""+formular+"\" AND datenfeld=\""+datenfeld+"\";";
  }

  // Beschriftung auslesen
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;
  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery(sql);
    if ( rs.next() ) {
      if (datenfeld != null && textfeld == null)
        out.print("<label for=\""+datenfeld+"\">");
      out.print(DBtoHTML(rs.getString("Beschriftung")));
      if (datenfeld != null && textfeld == null)
        out.print("</label>");
    }
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
