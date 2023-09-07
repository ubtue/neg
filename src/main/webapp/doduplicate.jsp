<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  int id = -1;
  if (request.getParameter("duplicate") != null && request.getParameter("duplicate").equals("duplizieren")) {
    id = Integer.parseInt(request.getParameter("id"));

    // Datensatz "einzelbeleg" duplizieren
    String sql = "INSERT INTO einzelbeleg";
    sql += " (EditionID, HandschriftID, QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, UeberlieferungDatierung,";
    sql += " GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert,";
    sql += " QuelleBisTag, QuelleBisMonat, QuelleBisJahr, QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert";
    sql += " ) SELECT EditionID, HandschriftID, QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, UeberlieferungDatierung,";
    sql += " GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert,";
    sql += " QuelleBisTag, QuelleBisMonat, QuelleBisJahr, QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert FROM einzelbeleg WHERE ID="+id+";";

    EinzelbelegDB.insertBySql(sql);

    // This is a risky strategy because it is not thread-safe.
    // However, there is no better solution when using direct sql queries right now.
    Integer idNeu = EinzelbelegDB.getIntNative("SELECT ID FROM einzelbeleg ORDER BY ID DESC LIMIT 0, 1;") ;

    if(idNeu != null){
      sql = "INSERT INTO einzelbeleg_textkritik";
      sql += " (EinzelbelegID, EditionID, HandschriftID, Variante, Bemerkung) SELECT '"+idNeu+"', EditionID, HandschriftID, Variante, Bemerkung FROM einzelbeleg_textkritik WHERE EinzelbelegID="+id+";";
      EinzelbelegDB.insertBySql(sql);
      id=idNeu;
    }

//      out.println("<script type=\"text/javascript\">");
//      out.println("location.replace(window.location.protocol+'//'+window.location.hostname+':'+window.location.port+window.location.pathname+'?ID='+"+id+");");
//      out.println("</script>");

  } // ENDE if (springen)
%>
