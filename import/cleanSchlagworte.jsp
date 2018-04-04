
<%@ page import="java.math.BigInteger" isThreadSafe="false"%>
<%@ page import="java.security.MessageDigest" isThreadSafe="false"%>
<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>

<%@ include file="../configuration.jsp"%>
<HTML>
<HEAD>
<TITLE>Nomen et Gens - Administration</TITLE>
<link rel="stylesheet" href="layout/layout.css" type="text/css">
<script src="../javascript/funktionen.js" type="text/javascript"></script>
<noscript></noscript>
</HEAD>
<BODY>
<%
  try {
	  
      Class.forName( sqlDriver );
      Connection cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      Statement st = cn.createStatement();
      Statement st2 = cn.createStatement();
      Statement st3 = cn.createStatement();
      
      String tabelle = "selektion_sw_phongraph";
      
      boolean changed = true;
      while (changed){
    	  
    	  
    	  ResultSet rs3 = st3.executeQuery("Select * from ( SELECT min(ID) as min, max(ID) as max ,Bezeichnung as bez from " +tabelle+ " group by Bezeichnung) as res  where not min=max limit 1,1;");
    	  if(rs3.next()){
    	     changed=true;
    	  
      String neu = rs3.getString("min");
      String alt = rs3.getString("max");
      
      out.println(neu + ":::" + alt  + "<br>");
      
      if(neu.equals(alt)){
      out.println("<p>Auswahl kann nicht mit sich selbst zusammengeführt werden.</p>");
      out.println("<a href=\"administration.jsp\">zur&uuml;ck zur Administration</a>");
      
      }
      else
      {

      ResultSet rs = st.executeQuery("SELECT tabelle, spalte FROM datenbank_selektion WHERE selektion ='"+tabelle+"';");
      while (rs.next()) {
        st2.addBatch("UPDATE "+rs.getString("tabelle")+" SET "+rs.getString("spalte")+"="+neu
                     + " WHERE "+rs.getString("spalte")+"="+alt+";");
      }
      st2.addBatch("DELETE FROM "+tabelle
                      + " WHERE ID="+alt);
      st2.executeBatch();
      }
      }
    	  else changed=false;}
      
    }
    catch (SQLException e) {out.println(e);}  
    finally {
    }
    %>


</BODY>
</HTML>