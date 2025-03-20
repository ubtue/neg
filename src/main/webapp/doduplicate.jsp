<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@ page import="de.uni_tuebingen.ub.nppm.db.EinzelbelegDB" isThreadSafe="false" %>
<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  int id = -1;
  if (request.getParameter("duplicate") != null && request.getParameter("duplicate").equals( Language.getTextfield(session, "navigation", "Duplizieren"))) {
    id = Integer.parseInt(request.getParameter("id"));

    String sql = "INSERT INTO einzelbeleg (";
sql += "Belegnummer, Kontext_vor, Kontext, Kontext_nach, GeschlechtID, LebendVerstorbenID, EditionID, HandschriftID, ";
sql += "QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, ";
sql += "UeberlieferungDatierung, Belegform, Griechisch, Diakritisch, KasusID, GrammatikGeschlechtID, ASWQuellenzitat, ";
sql += "Bemerkung, BearbeitungsstatusID, KommentarEthnie, KommentarAreal, KommentarVerwandtschaft, Eindeutig, ";
sql += "VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, GenauigkeitVonTag, ";
sql += "GenauigkeitVonMonat, GenauigkeitVonJahr, GenauigkeitVonJahrhundert, DatierungUngewiss, KommentarDatierung, ";
sql += "LetzteAenderung, LetzteAenderungVon, Erstellt, ErstelltVon, GehoertGruppe, GenauigkeitBisTag, GenauigkeitBisMonat, ";
sql += "GenauigkeitBisJahr, GenauigkeitBisJahrhundert, GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, ";
sql += "GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, ";
sql += "GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert, QuelleBisTag, QuelleBisMonat, QuelleBisJahr, ";
sql += "QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert, KommentarPerson, ";
sql += "MGHLemmaKorrigiert, KonventID, BeziehungGemeinschaftID, KritikID, KontextID, TitelText, pal_abgrenzung, ";
sql += "inh_abgrenzung, nr_in_strukt, seite, raster, schreiber, provenance_source, provenance_id) ";
sql += "SELECT ";
sql += "Belegnummer, Kontext_vor, Kontext, Kontext_nach, GeschlechtID, LebendVerstorbenID, EditionID, HandschriftID, ";
sql += "QuelleID, EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, ";
sql += "UeberlieferungDatierung, Belegform, Griechisch, Diakritisch, KasusID, GrammatikGeschlechtID, ASWQuellenzitat, ";
sql += "Bemerkung, BearbeitungsstatusID, KommentarEthnie, KommentarAreal, KommentarVerwandtschaft, Eindeutig, ";
sql += "VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert, GenauigkeitVonTag, ";
sql += "GenauigkeitVonMonat, GenauigkeitVonJahr, GenauigkeitVonJahrhundert, DatierungUngewiss, KommentarDatierung, ";
sql += "NOW(), LetzteAenderungVon, NOW(), ErstelltVon, GehoertGruppe, GenauigkeitBisTag, GenauigkeitBisMonat, ";
sql += "GenauigkeitBisJahr, GenauigkeitBisJahrhundert, GenauigkeitQuelleBisTag, GenauigkeitQuelleBisMonat, ";
sql += "GenauigkeitQuelleBisJahr, GenauigkeitQuelleBisJahrhundert, GenauigkeitQuelleVonTag, GenauigkeitQuelleVonMonat, ";
sql += "GenauigkeitQuelleVonJahr, GenauigkeitQuelleVonJahrhundert, QuelleBisTag, QuelleBisMonat, QuelleBisJahr, ";
sql += "QuelleBisJahrhundert, QuelleVonTag, QuelleVonMonat, QuelleVonJahr, QuelleVonJahrhundert, KommentarPerson, ";
sql += "MGHLemmaKorrigiert, KonventID, BeziehungGemeinschaftID, KritikID, KontextID, TitelText, pal_abgrenzung, ";
sql += "inh_abgrenzung, nr_in_strukt, seite, raster, schreiber, provenance_source, provenance_id ";
sql += "FROM einzelbeleg WHERE ID="+id+";";


    EinzelbelegDB.insertBySql(sql);

    // This is a risky strategy because it is not thread-safe.
    // However, there is no better solution when using direct sql queries right now.
    Integer idNeu = EinzelbelegDB.getIntNative("SELECT ID FROM einzelbeleg ORDER BY ID DESC LIMIT 0, 1;") ;

    if(idNeu != null){
      sql = "INSERT INTO einzelbeleg_textkritik";
      sql += " (EinzelbelegID, EditionID, HandschriftID, Variante, Bemerkung, provenance_source, provenance_id) SELECT '"+idNeu+"', EditionID, HandschriftID, Variante, Bemerkung, provenance_source, provenance_id FROM einzelbeleg_textkritik WHERE EinzelbelegID="+id+";";
      EinzelbelegDB.insertBySql(sql);
      id=idNeu;
    }

//      out.println("<script type=\"text/javascript\">");
//      out.println("location.replace(window.location.protocol+'//'+window.location.hostname+':'+window.location.port+window.location.pathname+'?ID='+"+id+");");
//      out.println("</script>");

  } // ENDE if (springen)
%>
