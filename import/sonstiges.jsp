<%@ page import="java.io.File" isThreadSafe="false" %>
<%@ page import="java.io.FileNotFoundException" isThreadSafe="false" %>
<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Scanner" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>


<HTML>
  <HEAD>
    <TITLE>Nomen et Gens - Import</TITLE>
    <script src="javascript/funktionen.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY>

<%
  out.println(new String("A'").replaceAll("'", "\""));

       Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM handschrift_ueberlieferung");
        while ( rs.next() ) {
          Statement st2 = cn.createStatement();
          String sql = "INSERT into ueberlieferung_edition (UeberlieferungID,EditionID,Sigle) values ('"+rs.getString("ID")+"','"+rs.getString("EditionID")+"','"+rs.getString("Sigle").replaceAll("'", "\"")+"')";
          out.println(sql);
          st2.execute(sql);
        }
      } catch (SQLException e) {
        out.println("---" + e);
      } finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
%>
  </BODY>
</HTML>
