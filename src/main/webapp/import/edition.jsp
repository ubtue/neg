<%

  if (tabelle.startsWith("edition")) {

    String limit = " ";

    if (tabelle.equals("edition_band")) {
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
                             +" FROM tbl_qeband"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO edition_band (ID, EditionID, Bandnummer, Jahr, Standard)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("FK_QE_ID"        )+", "
                                      +(rs.getString("QEB_BandNr"  )==null?"NULL":"'"+rs.getString("QEB_BandNr"  )+"'")+", "
                                      +(rs.getString("QEB_Jahr"    )==null?"NULL":"'"+rs.getString("QEB_Jahr"    )+"'")+", "
                                      +(rs.getInt("QEB_Standard")==-1?1:0)+");");
          }
          catch (SQLException e) { out.println(e); }
        }
        st2.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }

    else if (tabelle.equals("edition_hateditor")) {
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

        rs = st.executeQuery("SELECT *"
                             +" FROM tbl_qehrsgautor"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            rs2 = st2.executeQuery("SELECT ID"
                                   +" FROM selektion_editor"
                                   +" WHERE Vorname='"+rs.getString("QHA_Vorname")+"' AND Nachname='"+DBtoDB(rs.getString("QHA_Nachname"))+"';");
            if (rs2.next()) {           
              st3.addBatch("INSERT INTO edition_hateditor (ID, EditionID, EditorID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("FK_QE_ID")+", "
                                      +rs2.getInt("ID")+");");
            }
          }
          catch (SQLException e) { out.println(e); }
        }
        st3.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st3 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }


    else if (tabelle.equals("edition_hateditor")) {
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

        rs = st.executeQuery("SELECT *"
                             +" FROM tbl_qehrsgautor"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            rs2 = st2.executeQuery("SELECT ID"
                                   +" FROM selektion_editor"
                                   +" WHERE Vorname='"+rs.getString("QHA_Vorname")+"' AND Nachname='"+DBtoDB(rs.getString("QHA_Nachname"))+"';");
            if (rs2.next()) {           
              st3.addBatch("INSERT INTO edition_hateditor (ID, EditionID, EditorID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("FK_QE_ID")+", "
                                      +rs2.getInt("ID")+");");
            }
          }
          catch (SQLException e) { out.println(e); }
        }
        st3.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st3 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }

    if (tabelle.equals("edition_bestand")) {
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
                             +" FROM tbl_qebestand"
                             +limit);

        for (int i=1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO edition_bestand (ID, EditionID, BKZ, Signatur)"
                          +" VALUES ("+i+", "
                                      +rs.getInt    ("FK_QE_ID"    )+", "
                                      +(rs.getString("QEB_BKZ"     )==null?"NULL":"'"+rs.getString("QEB_BKZ"     )+"'")+", "
                                      +(rs.getString("QEB_Signatur")==null?"NULL":"'"+rs.getString("QEB_Signatur")+"'")+");");
          }
          catch (SQLException e) { out.println(e); }
        }
        st2.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
        try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
      }
    }

    else if (tabelle.equals("edition")) {
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
                             +" FROM tbl_qeditionen"
                             +limit);

        while (rs.next()) {
          st2.addBatch("INSERT INTO edition (ID, Titel, Jahr, Seiten, Zitierweise, OrtID, ReiheID, SammelbandID, Verbindlich, BearbeitungsstatusID,"
                        +" LetzteAenderung, LetzteAenderungVon)"
                        +" VALUES ("+rs.getInt("E_ID")+", "
                                   +"'"+DBtoDB(rs.getString("E_Edition"))+"', "
                                       +(rs.getString("E_Jahr"         )==null?"NULL":"'"+DBtoDB(rs.getString("E_Jahr"         ))+"'")+", "
                                       +(rs.getString("E_Seiten"       )==null?"NULL":"'"+DBtoDB(rs.getString("E_Seiten"       ))+"'")+", "
                                       +(rs.getString("E_Zitierweise"  )==null?"NULL":"'"+DBtoDB(rs.getString("E_Zitierweise"  ))+"'")+", "
                                       +(rs.getString("E_Ort"          )==null?"NULL":"'"+rs.getInt   ("E_Ort"          )+"'")+", "
                                       +(rs.getString("E_Reihe"        )==null?"-1"  :"'"+rs.getInt   ("E_Reihe"        )+"'")+", "
                                       +(rs.getString("E_Sammelband_ID")==null?"-1"  :"'"+rs.getInt   ("E_Sammelband_ID")+"'")+", "
                                       +(rs.getInt   ("E_Primaer"      )==-1 ? 1 : 0 )+", "
                                       +"'1', "
                                       +(rs.getString("LastChx"        )==null?"NULL":"'"+DBtoDB(rs.getString("LastChx"        ))+"'")+", "
                                       +(rs.getString("LastChxBy"      )==null?"NULL":"'"+DBtoDB(rs.getString("LastChxBy"      ))+"'")
                                       +");");
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
  }
%>
