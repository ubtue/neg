<%
  if (tabelle.startsWith("einzelbeleg")) {
  String limit = ""; // LIMIT 50000, 10000";

  if (tabelle.equals("einzelbeleg_hatfunktion")) {
    Connection oldDB = null;
    Connection newDB = null;

    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
      Class.forName( sqlDriver );
      oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = oldDB.createStatement();
      st2 = newDB.createStatement();
      st3 = newDB.createStatement(); 

      rs = st.executeQuery("SELECT BelegID, b_Funktion, b_Nummer"
                           +" FROM tbl_einzelbelege"
                           +" WHERE (b_Funktion IS NOT NULL AND b_Funktion !='')"
                           +" OR (b_Nummer IS NOT NULL AND b_Nummer != '')"
                           +limit);


      for (int i=20001; rs.next(); i++) {
        String sql = "INSERT INTO einzelbeleg_hatfunktion (ID, EinzelbelegID, FunktionID, Nummer)"
                        +" VALUES ("+i+", "
                        +rs.getInt("BelegID")+", "
                        +"NULL, "
                        +"'"+(rs.getString("b_Nummer")!=null?rs.getString("b_Nummer").replace("\'", "\\\'"):"NULL")+"');";
        // Funktion-ID bestimmen
        if (rs.getString("b_Funktion") != null) {
          rs2 = st2.executeQuery("SELECT ID FROM selektion_funktion"
                                 +" WHERE Bezeichnung='"+rs.getString("b_Funktion").replace("\'", "\\\'")+"';");
          if (rs2.next()) {
            sql = "INSERT INTO einzelbeleg_hatfunktion (ID, EinzelbelegID, FunktionID, Nummer)"
                        +" VALUES ("+i+", "
                        +rs.getInt("BelegID")+", "
                        +rs2.getInt("ID")+", "
                        +"'"+(rs.getString("b_Nummer")!=null?rs.getString("b_Nummer").replace("\'", "\\\'"):"NULL")+"');";
          }
        }
        st3.addBatch(sql);
      }
      st3.executeBatch();
    }
    catch (SQLException e) { out.println(e); }
    finally {
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg_hatperson")) {
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
      rs = st.executeQuery("SELECT BelegID, P_ID FROM tbl_einzelbelege e, tbl_personen p"
                           +" WHERE (e.fk_Pkz=p.p_pkz)"
                           +""
                           );
      st2 = newDB.createStatement();

      for(int i=0; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO einzelbeleg_hatperson (EinzelbelegID, PersonID)"
                        +" VALUES ("+rs.getInt("BelegID")+", "+rs.getInt("P_ID")+");");
          if (i%5000==0) {
            st2.executeBatch();
            st2 = newDB.createStatement();
            out.println("<p>"+i+" erledigt!</p>");
          }
        }
        catch (SQLException e) {
          out.println(e);
        }
      }
      st2.executeBatch();
    }
    catch (SQLException e) {
      out.println(e);
    }
    finally {
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg_hatnamenkommentar")) {
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
      rs = st.executeQuery("SELECT tbl_einzelbelege.BelegID, tbl_namenkommentar.NK_ID"
                           +" FROM tbl_einzelbelege, tbl_namenkommentar"
                           +" WHERE tbl_einzelbelege.b_LemmaPhil = tbl_namenkommentar.NK_PLemma"
                           +limit);
      st2 = newDB.createStatement();
      while (rs.next()) {
        st2.addBatch("INSERT INTO einzelbeleg_hatnamenkommentar (EinzelbelegID, NamenkommentarID)"
                        +" VALUES ("+rs.getInt("tbl_einzelbelege.BelegID")+", "+rs.getInt("tbl_namenkommentar.NK_ID")+");");
      }
      st2.executeBatch();
    }
    catch (SQLException e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg_textkritik")) {
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
      rs = st.executeQuery("SELECT fk_BelegID, Sigle, Variante, Bemerkung"
                           +" FROM tbl_textkritik"
                           +limit);
      st2 = newDB.createStatement();
      while (rs.next()) {
        st2.addBatch("INSERT INTO einzelbeleg_textkritik (EinzelbelegID, HandschriftID, Variante, Bemerkung)"
                        +" VALUES ("+rs.getInt("fk_BelegID")+", "+rs.getInt("Sigle")+", '"+(rs.getString("Variante")==null?"":DBtoDB(rs.getString("Variante")))+"', '"+(rs.getString("Bemerkung")==null?"":DBtoDB(rs.getString("Bemerkung")))+"');");
      }
      st2.executeBatch();
    }
    catch (SQLException e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg_hatareal")) {
    Connection oldDB = null;
    Connection newDB = null;

    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
      Class.forName( sqlDriver );
      oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = oldDB.createStatement();
      st2 = newDB.createStatement();

      rs = st.executeQuery("SELECT fk_BelegID, Areal"
                           +" FROM tbl_areale"
                           +" WHERE Areal IS NOT NULL AND Areal != ''"
                           +limit);

      for (int i = 1; rs.next(); i++) {
        try {
          st3 = newDB.createStatement();
          rs2 = st3.executeQuery("SELECT ID FROM selektion_areal WHERE Bezeichnung ='"+DBtoDB(rs.getString("Areal"))+"';");
          rs2.next();

          st2.addBatch("INSERT INTO einzelbeleg_hatareal (ID, EinzelbelegID, ArealID)"
                        +" VALUES ("+i+", "
                                    +rs.getInt("fk_BelegID")+", "
                                    +rs2.getInt("ID")+");");
          if (i%1000 == 0)
            st2.executeBatch();
        }
        catch (SQLException e) { out.println(e); }
      }
      st2.executeBatch();
    }
    finally {
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg_hatamtweihe")) {
    Connection oldDB = null;
    Connection newDB = null;

    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
      Class.forName( sqlDriver );
      oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = oldDB.createStatement();
      st2 = newDB.createStatement();

      rs = st.executeQuery("SELECT tbl_ebasw.fk_BelegID, tbl_selaemter.Amt"
                           +" FROM tbl_ebasw, tbl_selaemter"
                           +" WHERE tbl_ebasw.AswID = tbl_selaemter.ID"
                           +limit);

      for (int i = 1; rs.next(); i++) {
        try {
          st3 = newDB.createStatement();
          rs2 = st3.executeQuery("SELECT ID FROM selektion_amtweihe WHERE Bezeichnung ='"+DBtoDB(rs.getString("Amt"))+"';");
          if (rs2.next()) {
            st2.addBatch("INSERT INTO "+tabelle+" (ID, EinzelbelegID, AmtWeiheID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("fk_BelegID")+", "
                                      +rs2.getInt("ID")+");");
          }
          else {
            out.println(DBtoHTML(rs.getString("PersonAmt"))+"<br>");
          }
        }
        catch (SQLException e) { out.println(e); }
      }
      st2.executeBatch();
    }
    finally {
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }

  else if (tabelle.equals("einzelbeleg")) {
    Connection oldDB = null;
    Connection newDB = null;
    Statement st = null;
    Statement st2 = null;
    ResultSet rs = null;

    String sql = "";

    try {
      Class.forName( sqlDriver );
      oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
      st = oldDB.createStatement();
      st2 = newDB.createStatement();
      rs = st.executeQuery("SELECT *"
                           +" FROM tbl_einzelbelege"
                           +limit);
      while ( rs.next() ) {
        sql = "INSERT INTO einzelbeleg"
                      + "(ID, Belegnummer, Kontext, GeschlechtID, LebendVerstorbenID, EditionID, HandschriftID, QuelleID,"
                      + " EditionKapitel, EditionSeite, QuelleGattungID, QuelleEchtheitID, QuelleDatierung, UeberlieferungDatierung, Belegform,"
                      + " Griechisch, Diakritisch, KasusID, GrammatikGeschlechtID, ASWQuellenzitat,"
                      + " BearbeitungsstatusID, KommentarEthnie, KommentarAreal, KommentarVerwandtschaft,"
                      + " VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert,"
                      + " GenauigkeitVonTag, GenauigkeitVonMonat, GenauigkeitVonJahr, GenauigkeitVonJahrhundert,"
                      + " LetzteAenderung, LetzteAenderungVon, Erstellt, ErstelltVon)"
                      +" VALUES (  '"+rs.getInt("BelegID"                    )+"',"
                                + "'"+rs.getString("b_Belegnr"               )+"',"
                                + (rs.getString("b_Kontext"                  )==null?"NULL":"'"+DBtoDB(rs.getString("b_Kontext"                  ))+"'")+","
                                + "'"+rs.getInt("b_Geschlecht"               )+"',"
                                + "'"+rs.getInt("b_Lebend"                   )+"',"
                                + "NULL,"
                                + "NULL,"
                                + (rs.getString("b_Quelle"                   )==null?"NULL":"'"+       rs.getInt   ("b_Quelle"                   ) +"'")+","
                                + (rs.getString("b_Kapitel"                  )==null?"NULL":"'"+DBtoDB(rs.getString("b_Kapitel"                  ))+"'")+","
                                + (rs.getString("b_Seite"                    )==null?"NULL":"'"+DBtoDB(rs.getString("b_Seite"                    ))+"'")+","
                                + (rs.getString("b_Quellengattung"           )==null?"NULL":"'"+DBtoDB(rs.getString("b_Quellengattung"           ))+"'")+","
                                + (rs.getString("b_Echtheit"                 )==null?"NULL":"'"+       rs.getInt   ("b_Echtheit"                 ) +"'")+","
                                + (rs.getString("b_datQuelle"                )==null?"NULL":"'"+DBtoDB(rs.getString("b_datQuelle"                ))+"'")+","
                                + (rs.getString("b_datUeberlief"             )==null?"NULL":"'"+DBtoDB(rs.getString("b_DatUeberlief"             ))+"'")+","
                                + (rs.getString("b_Belegform"                )==null?"NULL":"'"+DBtoDB(rs.getString("b_Belegform"                ))+"'")+","
                                + (rs.getString("b_GrPersonenname"           )==null?"NULL":"'"+DBtoDB(rs.getString("b_GrPersonenname"           ))+"'")+","
                                + (rs.getString("b_DiaPersonenname"          )==null?"NULL":"'"+DBtoDB(rs.getString("b_DiaPersonenname"          ))+"'")+","
                                + (rs.getString("b_Kasus"                    )==null?"NULL":"'"+       rs.getInt   ("b_Kasus"                    ) +"'")+","
                                + (rs.getString("b_GeschlLexikalisch"        )==null?"NULL":"'"+       rs.getInt   ("b_GeschlLexikalisch"        ) +"'")+","
                                + "NULL,"
                                + "'"+(rs.getInt("b_bearbeitet")==0?3:1)+"',"
                                + (rs.getString("b_Ethnie"                   )==null?"NULL":"'"+DBtoDB(rs.getString("b_Ethnie"                   ))+"'")+","
                                + (rs.getString("b_Areal"                    )==null?"NULL":"'"+DBtoDB(rs.getString("b_Areal"                    ))+"'")+","
                                + (rs.getString("b_Verwandtschaft"           )==null?"NULL":"'"+DBtoDB(rs.getString("b_Verwandtschaft"           ))+"'")+","
                                + (rs.getString("b_DatumPerNenTag"           )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenTag"           ) +"'")+","
                                + (rs.getString("b_DatumPerNenMonat"         )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenMonat"         ) +"'")+","
                                + (rs.getString("b_DatumPerNenJahr"          )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenJahr"          ) +"'")+","
                                + (rs.getString("b_DatumPerNenJahrhundert"   )==null?"NULL":"'"+DBtoDB(rs.getString("b_DatumPerNenJahrhundert"   ))+"'")+","
                                + (rs.getString("b_DatumPerNenBisTag"        )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenBisTag"        ) +"'")+","
                                + (rs.getString("b_DatumPerNenBisMonat"      )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenBisMonat"      ) +"'")+","
                                + (rs.getString("b_DatumPerNenBisJahr"       )==null?"NULL":"'"+       rs.getInt   ("b_DatumPerNenBisJahr"       ) +"'")+","
                                + (rs.getString("b_DatumPerNenBisJahrhundert")==null?"NULL":"'"+DBtoDB(rs.getString("b_DatumPerNenBisJahrhundert"))+"'")+","
                                + (rs.getString("b_TagGenauigkeit"           )==null?"NULL":"'"+       rs.getInt   ("b_TagGenauigkeit"           ) +"'")+","
                                + (rs.getString("b_MonatGenauigkeit"         )==null?"NULL":"'"+       rs.getInt   ("b_MonatGenauigkeit"         ) +"'")+","
                                + (rs.getString("b_JahrGenauigkeit"          )==null?"NULL":"'"+       rs.getInt   ("b_JahrGenauigkeit"          ) +"'")+","
                                + (rs.getString("b_JHGenauigkeit"            )==null?"NULL":"'"+       rs.getInt   ("b_JHGenauigkeit"            ) +"'")+","
                                + (rs.getString("LastChx"                    )==null?"NULL":"'"+DBtoDB(rs.getString("LastChx"                    ))+"'")+","
                                +((rs.getString("LastChxBy")==null||rs.getString("LastChxBy").equals("AW"))?"NULL":"'"+DBtoDB(rs.getString("LastChxBy"))+"'")+","
                                + (rs.getString("Created"                    )==null?"NULL":"'"+DBtoDB(rs.getString("Created"                    ))+"'")+","
                                + (rs.getString("CreatedBy"                  )==null?"NULL":"'"+DBtoDB(rs.getString("CreatedBy"                  ))+"'")
                                +");";
        st2.addBatch(sql);
      }
      st2.executeBatch();
    }
    catch (SQLException e) {
      out.println(sql);
      out.println(">>"+e+"<<");
    }
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