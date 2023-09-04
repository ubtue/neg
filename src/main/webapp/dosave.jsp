<%@ page import="java.text.SimpleDateFormat" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.*" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (request.getParameter("speichern") != null && request.getParameter("speichern").equals("speichern")) {
          int id = -1;
          String form = request.getParameter("form");
          try {
              if (request.getParameter("ID").equals("-1")) {
                  id = SaveHelper.getMaxId(form) + 1;
              } else {
                  id = Integer.parseInt(request.getParameter("ID"));
              }
          } catch (Exception e) {
              out.println(e);
          }

          boolean exist = SaveHelper.existForm(form, id);
          if (!form.equals("urkunde") && !exist) {
              SaveHelper.insertMetaData(form, id, (int) session.getAttribute("BenutzerID"), (int) session.getAttribute("GruppeID"));
          } else if (!form.equals("urkunde")) {
              SaveHelper.updateMetaData(form, id, (int) session.getAttribute("BenutzerID"));
          }

          List<DatenbankMapping> lst = SaveHelper.getMapping(form);

          for (DatenbankMapping mapping : lst) {
              // Textfield, Textarea, select, addselect
              String feldtyp = mapping.getFeldtyp();
              Boolean isArray = mapping.getArray();
              String zielAttribut = mapping.getZielAttribut();
              String zieltabelle = mapping.getZielTabelle();
              String datenfeld = mapping.getDatenfeld();
              String formularAttribut = mapping.getFormularAttribut();
              String combFeldnamen = mapping.getCombinedFeldnamen();
              String combFeldtyp = mapping.getCombinedFeldtypen();
              if (feldtyp != null && (feldtyp.equals("textfield")
                      || feldtyp.equals("textarea")
                      || feldtyp.equals("select")
                      || feldtyp.equals("addselect")
                      || feldtyp.equals("addselectandtext")
                      || feldtyp.equals("sqlselect"))) {
                  // KEIN ARRAY
                  if (isArray != null && !isArray && zielAttribut != null && zieltabelle != null) {
                      String attrVal = SaveHelper.getSingleField(zielAttribut, zieltabelle, id);
                      // Datensatz ändern
                      if (((request.getParameter(datenfeld) != null && attrVal != null && !attrVal.equals(DBtoDB(request.getParameter(datenfeld))))
                              || (request.getParameter(datenfeld) != null && attrVal == null && !request.getParameter(datenfeld).equals("")))) {
                          SaveHelper.updateAttribute(zieltabelle, zielAttribut, request.getParameter(datenfeld), id);
                      } // ENDE Datensatz ändern

                  } // ENDE kein Array
                  // ARRAY
                  else if (isArray != null && isArray && zielAttribut != null && zieltabelle != null) {
                      for (int i = 0; request.getParameter(datenfeld + "[" + i + "]") != null; i++) {
                          // Prüfen, ob aktueller Eintrag bereits vorhanden
                          if (request.getParameter(datenfeld + "[" + i + "]_entryid") != null) {
                              // Prüfen, ob Datensatz geändert wurde
                              String attrVal = SaveHelper.getSingleField(zielAttribut, zieltabelle, Integer.valueOf(request.getParameter(datenfeld + "[" + i + "]_entryid")));
                              if (attrVal != null && !attrVal.equals(DBtoDB(request.getParameter(datenfeld + "[" + i + "]")))) {
                                  SaveHelper.updateAttribute(zieltabelle, zielAttribut, request.getParameter(datenfeld + "[" + i + "]"), request.getParameter(datenfeld + "[" + i + "]_entryid"));
                              }
                          } else {
                              // Wenn etwas eingetragen ist, in die Datenbank einfügen
                              if (formularAttribut != null && request.getParameter(datenfeld + "[" + i + "]") != null && !request.getParameter(datenfeld + "[" + i + "]").equals("") && !request.getParameter(datenfeld + "[" + i + "]").equals("-1")) {
                                  String sql = "INSERT INTO " + zieltabelle
                                          + " (" + formularAttribut + ", " + zielAttribut + ")"
                                          + " VALUES (" + id + ", \"" + DBtoDB(request.getParameter(datenfeld + "[" + i + "]")) + "\" );";
                                  SaveHelper.insertOrUpdateSql(sql);
                              }
                          }
                      }
                  } // ENDE Array
              } //ENDE Textfield, Textarea, select, addselect
              // checkbox
              else if (feldtyp != null && feldtyp.equals("checkbox") && zielAttribut != null && zieltabelle != null) {
                  // KEIN ARRAY
                  if (!isArray) {
                      String attrVal = SaveHelper.getSingleField(zielAttribut, zieltabelle, id);
                      int checkbox = 0;
                      if (request.getParameter(datenfeld) != null && request.getParameter(datenfeld).equals("on")) {
                          checkbox = 1;
                      }
                      if (attrVal != null && Integer.valueOf(attrVal) != checkbox) {
                          SaveHelper.updateAttribute(zieltabelle, zielAttribut, String.valueOf(checkbox), id);
                      } // ENDE Datensatz ändern
                  } // ENDE kein Array
              } //ENDE checkbox
              // Datum
              else if (feldtyp != null && feldtyp.equals("date") && zielAttribut != null && zieltabelle != null) {
                  // Datensatz geändert?
                  String[] zielattributArray = {""};
                  String[] combinedFeldnamenArray = {""};

                  if (zielAttribut.contains(";")) {
                      zielattributArray = zielAttribut.split(";");
                      for (int j = 0; j < zielattributArray.length; j++) {
                          zielattributArray[j] = zielattributArray[j].trim();
                      }
                  }
                  String zielattribute = zielattributArray[0];
                  for (int i = 1; i < zielattributArray.length; i++) {
                      zielattribute += ", " + zielattributArray[i];
                  }

                  if (combFeldnamen != null && combFeldnamen.contains(";")) {
                      combinedFeldnamenArray = combFeldnamen.split(";");
                      for (int j = 0; j < combinedFeldnamenArray.length; j++) {
                          combinedFeldnamenArray[j] = combinedFeldnamenArray[j].trim();
                      }
                  }

                  String zielAttributStr = "";
                  for (int i = 0; i < zielattributArray.length; i++) {
                      if (i > 0) {
                          zielAttributStr += ", ";
                      }
                      zielAttributStr += zielattributArray[i] + ", Genauigkeit" + zielattributArray[i];
                  }
                  List<Map> attributes = SaveHelper.getMappedList("SELECT " + zielAttributStr + " FROM " + zieltabelle + " WHERE ID='" + id + "';");
                  if (attributes.size() > 0) {
                      Map attr = attributes.iterator().next();
                      boolean changed = false;
                      for (int i = 0; i < zielattributArray.length; i++) {
                          if (attr.get(zielattributArray[i]) != null) {
                              if (!attr.get(zielattributArray[i]).equals(request.getParameter(combinedFeldnamenArray[i]))) {

                                  changed = true;
                              } else;
                          } else {
                              changed = true;
                          }
                          if (attr.get("Genauigkeit" + zielattributArray[i]) != null) {
                              if (!attr.get("Genauigkeit" + zielattributArray[i]).equals(request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]))) {

                                  changed = true;
                              } else;
                          } else {
                              changed = true;
                          }
                      }

                      if (changed) {
                          String sql = "UPDATE " + zieltabelle + " SET ";
                          boolean sqlValid = false;
                          for (int i = 0; i < zielattributArray.length; i++) {
                              if (request.getParameter(combinedFeldnamenArray[i]) != null && request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]) != null) {
                                  if (i > 0) {
                                      sql += ", ";
                                  }
                                  sql += zielattributArray[i] + "=\"" + ((!request.getParameter(combinedFeldnamenArray[i]).equals("")) ? request.getParameter(combinedFeldnamenArray[i]) : "0") + "\", ";
                                  sql += "Genauigkeit" + zielattributArray[i] + "=\"" + ((!request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]).equals("")) ? request.getParameter("Genauigkeit" + combinedFeldnamenArray[i]) : "0") + "\"";
                                  sqlValid = true;
                              }
                              if (i == (zielattributArray.length - 1)) {
                                  sql += " WHERE ID='" + id + "';";
                              }
                          }
                          if (sqlValid) {
                              SaveHelper.insertOrUpdateSql(sql);
                          }
                      }
                  }
              } // ENDE Datum
              // Bemerkungsfeld
              else if (feldtyp != null && feldtyp.equals("note") && zielAttribut != null && zieltabelle != null) {
                  String cond = "";
                  if (datenfeld.equals("BemerkungAlle")) {
                      cond = " AND GruppeID IS NULL AND BenutzerID IS NULL;";
                  } else if (datenfeld.equals("BemerkungGruppe")) {
                      cond = " AND GruppeID = " + session.getAttribute("GruppeID") + " AND BenutzerID IS NULL;";
                  } else if (datenfeld.equals("BemerkungPrivat")) {
                      cond = " AND GruppeID IS NULL AND BenutzerID = " + session.getAttribute("BenutzerID") + ";";
                  }

                  // Datensatz ändern
                   List<Map> attributes = SaveHelper.getMappedList("SELECT " + zielAttribut + " FROM " + zieltabelle + " WHERE " + formularAttribut + "='" + id + "'" + cond);
                  if (formularAttribut != null && zieltabelle != null && (attributes.size() > 0 && request.getParameter(datenfeld) != null)) {

                      if (attributes.size() > 0 && request.getParameter(datenfeld) != null) {
                          Map attr = attributes.iterator().next();
                          if (request.getParameter(datenfeld).equals("")) {
                              SaveHelper.insertOrUpdateSql("DELETE FROM " + zieltabelle + " WHERE " + formularAttribut + "='" + id + "'" + cond);
                          } // ENDE löschen
                          else if (!request.getParameter(datenfeld).equals("") && !DBtoDB(request.getParameter(datenfeld)).equals(attr.get(zielAttribut))) {
                              SaveHelper.insertOrUpdateSql("UPDATE " + zieltabelle
                                      + " SET " + zielAttribut + "='" + DBtoDB(request.getParameter(datenfeld)) + "'"
                                      + " WHERE " + formularAttribut + "='" + id + "'" + cond);
                          } // ENDE ändern
                      } // ENDE Datensatz ändern

                  } // Datensatz neu
                  else if (request.getParameter(datenfeld) != null && !request.getParameter(datenfeld).equals("")) {
                      String field = "";
                      String value = "";
                      if (datenfeld.equals("BemerkungGruppe")) {
                          field = ", GruppeID";
                          value = ", " + session.getAttribute("GruppeID");
                      } else if (datenfeld.equals("BemerkungPrivat")) {
                          field = ", BenutzerID";
                          value = ", " + session.getAttribute("BenutzerID");
                      }
                      if (formularAttribut != null && zieltabelle != null) {
                          SaveHelper.insertOrUpdateSql("INSERT INTO " + zieltabelle
                                  + " (" + zielAttribut + ", " + formularAttribut + field + ")"
                                  + " VALUES ('" + DBtoDB(request.getParameter(datenfeld)) + "', " + id + value + ");");
                      }
                  } // ENDE Datensatz neu
              } // ENDE Bemerkungsfeld
              // Namenkommentar Editor
              else if (feldtyp != null && feldtyp.equals("nkeditor") && zielAttribut != null && zieltabelle != null) {
                  if (request.getParameter(datenfeld) != null && request.getParameter(datenfeld).equals("on")) {
                      Date d = new Date();
                      SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
                      String sql = "INSERT INTO " + zieltabelle + " (" + (zieltabelle.equals("namenkommentar") ? "NamenkommentarID" : "MGHLemmaID") + ", BenutzerID, Zeitstempel) VALUES ";
                      sql += "(" + id + ", " + session.getAttribute("BenutzerID") + ", " + sf.format(d) + ")";
                      SaveHelper.insertOrUpdateSql(sql);
                  }
              } // ENDE NamenkommentarEditor
              // combined
              else if (feldtyp != null && feldtyp.equals("combined") && zieltabelle != null && zielAttribut != null && combFeldnamen != null && combFeldtyp != null) {
                  String[] zielattributArray = Arrays.stream(zielAttribut.split(";")).map(String::trim).toArray(String[]::new);

                  String[] combinedFeldnamenArray = Arrays.stream(combFeldnamen.split(";")).map(String::trim).toArray(String[]::new);

                  String[] combinedFeldtypenArray = Arrays.stream(combFeldtyp.split(";")).map(String::trim).toArray(String[]::new);
                  if (combinedFeldtypenArray.length == combinedFeldtypenArray.length) {
                      for (int i = 0; request.getParameter(combinedFeldnamenArray[0] + "[" + i + "]") != null; i++) {

                          // Datensatz ändern
                          if (request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") != null) {
                              boolean aenderung = false;

                              List<Map> attributes = SaveHelper.getMappedList("SELECT * FROM " + zieltabelle + " WHERE ID='" + request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") + "';");
                              if (attributes.size() > 0) {
                                  Map attr = attributes.iterator().next();
                                  for (int j = 0; j < combinedFeldnamenArray.length; j++) {
                                      if (combinedFeldtypenArray[j].equals("subtable")) {
                                          for (int j2 = 0; request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]" + "[" + j2 + "]") != null; j2++) {
                                              if (request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") != null) {
                                                  List<Map> ueberlieferungEdition = SaveHelper.getMappedList("SELECT * FROM ueberlieferung_edition WHERE editionID=" + request.getParameter(combinedFeldnamenArray[j] + "_ed[" + i + "]" + "[" + j2 + "]") + " AND ueberlieferungID=" + request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid"));
                                                  if (ueberlieferungEdition.size() > 0) {
                                                      SaveHelper.insertOrUpdateSql("UPDATE ueberlieferung_edition SET sigle='" + request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]" + "[" + j2 + "]") + "' WHERE  editionID=" + request.getParameter(combinedFeldnamenArray[j] + "_ed[" + i + "]" + "[" + j2 + "]") + " and ueberlieferungID=" + request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid"));
                                                  } else {
                                                      SaveHelper.insertOrUpdateSql("INSERT into ueberlieferung_edition (UeberlieferungID, EditionID, Sigle) VALUES ('" + request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") + "','" + request.getParameter(combinedFeldnamenArray[j] + "_ed[" + i + "]" + "[" + j2 + "]") + "','" + request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]" + "[" + j2 + "]") + "')");
                                                  }
                                              }
                                          }
                                      } else if (combinedFeldtypenArray[j].equals("textfield")
                                              || combinedFeldtypenArray[j].equals("textarea")
                                              || combinedFeldtypenArray[j].equals("select")
                                              || combinedFeldtypenArray[j].equals("sqlselect")
                                              || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                                          if (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") != null
                                                  && ((!request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals("") && attr.get(zielattributArray[j]) == null)
                                                  || (!request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals(attr.get(zielattributArray[j]))))) {
                                              aenderung = true;
                                          }
                                      } else if (combinedFeldtypenArray[j].equals("checkbox")) {
                                          if (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") != null
                                                  && request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals("on")
                                                  && (attr.get(zielattributArray[j]) == null || attr.get(zielattributArray[j]).equals("0"))) {
                                              aenderung = true;
                                          } else if (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") == null
                                                  && (attr.get(zielattributArray[j]) != null && attr.get(zielattributArray[j]).equals("1"))) {
                                              aenderung = true;
                                          }
                                      }
                                  }
                              }
                              if (aenderung && zieltabelle != null) {
                                  String sql = "UPDATE " + zieltabelle + " SET ";
                                  String ed = "";
                                  for (int j = 0; j < combinedFeldnamenArray.length; j++) {
                                      if (combinedFeldtypenArray[j].equals("textfield")
                                              || combinedFeldtypenArray[j].equals("textarea")
                                              || combinedFeldtypenArray[j].equals("select")
                                              || combinedFeldtypenArray[j].equals("sqlselect")
                                              || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                                          //Dont Quote NULL values
                                          if(request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").compareTo("NULL") == 0){
                                            sql += zielattributArray[j] + " = " + DBtoDB(request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]")) + ", ";
                                          }else{
                                            sql += zielattributArray[j] + " = '" + DBtoDB(request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]")) + "', ";
                                          }

                                          if (zieltabelle.equals("quelle_inedition") && zielattributArray[j].equals("EditionID")) {
                                              ed = DBtoDB(request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]"));
                                          }
                                      } else if (combinedFeldtypenArray[j].equals("checkbox")) {
                                          sql += zielattributArray[j] + " = '" + (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") != null && request.getParameter(combinedFeldnamenArray[j] +
                                          "[" + i + "]").equals("on") ? "1" : "0") + "', ";
                                      }
                                  }
                                  sql = sql.substring(0, sql.length() - 2);
                                  sql += " WHERE ID='" + request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") + "';";
                                  String old_ed = "";
                                  if (!ed.equals("")) {
                                      List<Map> editionLst = SaveHelper.getMappedList("select EditionID from quelle_inedition WHERE ID='" + request.getParameter(datenfeld.toLowerCase()
                                      + "[" + i + "]_entryid") + "';");

                                      if (editionLst.size() > 0) {
                                          old_ed = editionLst.get(editionLst.size() - 1).get("EditionID").toString();
                                      }
                                  }
                                  SaveHelper.insertOrUpdateSql(sql);
                                  if (!ed.equals("")) {
                                      SaveHelper.insertOrUpdateSql("Update ueberlieferung_edition set EditionID='" + ed + "' where EditionID=" + old_ed +
                                        " and UeberlieferungID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID=" +
                                        request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") + " and q_i.QuelleID=h_u.QuelleID)"
                                      );

                                      SaveHelper.insertOrUpdateSql("Update einzelbeleg_textkritik set EditionID='" + ed + "' where EditionID=" + old_ed +
                                        " and HandschriftID in (select h_u.ID from handschrift_ueberlieferung h_u, quelle_inedition q_i where q_i.ID=" + request.getParameter(datenfeld.toLowerCase()
                                        + "[" + i + "]_entryid") + " and q_i.QuelleID=h_u.QuelleID)"
                                      );

                                      SaveHelper.insertOrUpdateSql(" Update einzelbeleg set EditionID ='" + ed + "' where EditionID=" + old_ed +
                                        " and ID in (select e_t.EinzelbelegID from handschrift_ueberlieferung h_u, quelle_inedition q_i, einzelbeleg_textkritik e_t where e_t.HandschriftID=h_u.ID and q_i.ID=" +
                                        request.getParameter(datenfeld.toLowerCase() + "[" + i + "]_entryid") + " and q_i.QuelleID=h_u.QuelleID)"
                                      );
                                  }
                              }
                          } // Datensatz neu
                          else if (zieltabelle != null && formularAttribut != null) {
                              boolean aenderung = false;
                              for (int j = 0; j < combinedFeldnamenArray.length; j++) {
                                  if (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") != null
                                          && !request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals("")
                                          && !request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals("-1")
                                          && !request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]").equals("NULL")
                                          ) {
                                      aenderung = true;
                                  }
                              }
                              if (aenderung) {
                                  String sql = "INSERT INTO " + zieltabelle + " SET " + formularAttribut + " = '" + id + "'";
                                  for (int j = 0; j < combinedFeldnamenArray.length; j++) {
                                      if (!combinedFeldnamenArray[j].equals("")) {
                                          if (combinedFeldtypenArray[j].equals("textfield")
                                                  || combinedFeldtypenArray[j].equals("textarea")
                                                  || combinedFeldtypenArray[j].equals("select")
                                                  || combinedFeldtypenArray[j].equals("sqlselect")
                                                  || combinedFeldtypenArray[j].equals("addselect") || combinedFeldtypenArray[j].equals("addselectandtext")) {
                                              sql += ", " + zielattributArray[j] + " = '" + DBtoDB(request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]")) + "'";
                                          } else if (combinedFeldtypenArray[j].equals("checkbox")) {
                                              sql += ", " + zielattributArray[j] + " = '" +
                                              (request.getParameter(combinedFeldnamenArray[j] + "[" + i + "]") != null && request.getParameter(combinedFeldnamenArray[j] +
                                              "[" + i + "]").equals("on") ? "1" : "0") + "'";
                                          }
                                      }
                                  }
                                  SaveHelper.insertOrUpdateSql(sql);
                              }
                          }
                      }
                  }
              } // ENDE combined
          } // ENDE while

          if (request.getParameter("ID").equals("-1") && !form.equals("urkunde")) {
%>
    <script language="JavaScript">
<!--
   location.replace('?ID=<%= id%>');
//-->
</script>
<noscript></noscript>
<%
        }
    } // ENDE if (speichern)
%>
