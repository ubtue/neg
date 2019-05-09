<%

  if (tabelle.startsWith("quelle")) {
    String limit = " ";

    if (tabelle.equals("quelle_inedition")) {
      Connection oldDB = null;
      Connection newDB = null;

      Statement st = null;
      Statement st2 = null;

      ResultSet rs = null;

      try {
        Class.forName( sqlDriver );
        oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
        newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

        st = oldDB.createStatement();
        st2 = newDB.createStatement();

        rs = st.executeQuery("SELECT E_ID, fk_Q_ID"
                             +" FROM tbl_qeditionen"
                             +limit);

        while (rs.next()) {
          try {
            st2.addBatch("INSERT INTO quelle_inedition (QuelleID, EditionID)"
                        +" VALUES ("+rs.getInt("fk_Q_ID")+", "+rs.getInt("E_ID")+");");
          }
          catch (SQLException e) { out.println(e); }
        }
        st2.executeBatch();
      }
      catch (SQLException e) { out.println(e); }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }

    if (tabelle.equals("quelle")) {
      Connection oldDB = null;
      Connection newDB = null;

      Statement st = null;
      Statement st2 = null;

      ResultSet rs = null;

      try {
        Class.forName( sqlDriver );
        oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
        newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

        st = oldDB.createStatement();
        st2 = newDB.createStatement();

        rs = st.executeQuery("SELECT *"
                             +" FROM tbl_quellen"
                             +limit);

        while (rs.next()) {
          try {
            st2.addBatch("INSERT INTO quelle (ID, Bezeichnung, Quellennummer, QuellenKommentarDatei, UeberlieferungsKommentarDatei,"
                        + " VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert,"
                        + " GenauigkeitVonTag, GenauigkeitVonMonat, GenauigkeitVonJahr, GenauigkeitVonJahrhundert,"
                        +" BearbeitungsstatusID, LetzteAenderung, LetzteAenderungVon, Erstellt, ErstelltVon)"
                        +" VALUES ("+rs.getInt("Q_ID")+", "
                                   +"'"+rs.getString("QKurztitel").replace("\'", "\\\'")+"', "
                                       +(rs.getString("QNummer"                   )==null?"NULL":"'"+rs.getString("QNummer"                   )+"'")+", "
                                       +(rs.getString("QKritKommentar"            )==null?"NULL":"'"+rs.getString("QKritKommentar"            )+"'")+", "
                                       +(rs.getString("QUeberlieferungskommentar" )==null?"NULL":"'"+rs.getString("QUeberlieferungskommentar" )+"'")+", "
                                       +(rs.getString("QDatumQuelleTag"           )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleTag"           )+"'")+", "
                                       +(rs.getString("QDatumQuelleMonat"         )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleMonat"         )+"'")+", "
                                       +(rs.getString("QDatumQuelleJahr"          )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleJahr"          )+"'")+", "
                                       +(rs.getString("QDatumQuelleJahrhundert"   )==null?"NULL":"'"+rs.getString("QDatumQuelleJahrhundert"   )+"'")+", "
                                       +(rs.getString("QDatumQuelleBisTag"        )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleBisTag"        )+"'")+", "
                                       +(rs.getString("QDatumQuelleBisMonat"      )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleBisMonat"      )+"'")+", "
                                       +(rs.getString("QDatumQuelleBisJahr"       )==null?"NULL":"'"+rs.getInt   ("QDatumQuelleBisJahr"       )+"'")+", "
                                       +(rs.getString("QDatumQuelleBisJahrhundert")==null?"NULL":"'"+rs.getString("QDatumQuelleBisJahrhundert")+"'")+", "
                                       +(rs.getString("QTagGenauigkeit"           )==null?"NULL":"'"+rs.getInt   ("QTagGenauigkeit"           )+"'")+", "
                                       +(rs.getString("QMonatGenauigkeit"         )==null?"NULL":"'"+rs.getInt   ("QMonatGenauigkeit"         )+"'")+", "
                                       +(rs.getString("QJahrGenauigkeit"          )==null?"NULL":"'"+rs.getInt   ("QJahrGenauigkeit"          )+"'")+", "
                                       +(rs.getString("QJhGenauigkeit"            )==null?"NULL":"'"+rs.getInt   ("QJhGenauigkeit"            )+"'")+", "
                                       +(rs.getInt("QBearbeitet")==-1?3:1)+", "
                                       +(rs.getString("LastChx"                   )==null?"NULL":"'"+rs.getString("LastChx"                   )+"'")+", "
                                       +(rs.getString("LastChxBy"                 )==null?"NULL":"'"+rs.getString("LastChxBy"                 )+"'")+", "
                                       +(rs.getString("Created"                   )==null?"NULL":"'"+rs.getString("Created"                   )+"'")+", "
                                       +(rs.getString("CreatedBy"                 )==null?"NULL":"'"+rs.getString("CreatedBy"                 )+"'")
                                       +");");
          }
          catch (SQLException e) { out.println(e); }
        }
        st2.executeBatch();
      }
      catch (SQLException e) { out.println(e); }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }
  }
%>
