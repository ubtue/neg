<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  int id = -1;
  if (request.getParameter("duplicate") != null && request.getParameter("duplicate").equals("duplizieren")) {

    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      id = Integer.parseInt(request.getParameter("id"));

      Class.forName(sqlDriver);
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();

      // Datensatz "einzelbeleg" duplizieren
      String sql = "INSERT INTO einzelbeleg";
      sql += " (EditionID, HandschriftID, QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, UeberlieferungDatierung,";
      sql += " GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert,";
      sql += " QuelleBisTag, QuelleBisMonat, QuelleBisJahr, QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert";
      sql += " ) SELECT EditionID, HandschriftID, QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, UeberlieferungDatierung,";
      sql += " GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert,";
      sql += " QuelleBisTag, QuelleBisMonat, QuelleBisJahr, QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert FROM einzelbeleg WHERE ID="+id+";";

      st.execute(sql);

      // neue ID auslesen
      int idNeu = -1;
      rs = st.executeQuery("SELECT ID FROM einzelbeleg ORDER BY ID DESC LIMIT 0, 1;");
      if(rs.next()) {
        idNeu = rs.getInt("ID");
      }
      
      if(idNeu!=-1){
               sql = "INSERT INTO einzelbeleg_textkritik";
      sql += " (EinzelbelegID, EditionID, HandschriftID, Variante, Bemerkung) SELECT '"+idNeu+"', EditionID, HandschriftID, Variante, Bemerkung FROM einzelbeleg_textkritik WHERE EinzelbelegID="+id+";";

      st.execute(sql);
         
      }
      id=idNeu;
      
      
//      out.println("<script type=\"text/javascript\">");
//      out.println("location.replace('http://'+window.location.hostname+':'+window.location.port+window.location.pathname+'?ID='+"+id+");");
//      out.println("</script>");
    }
    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  } // ENDE if (springen)
%>