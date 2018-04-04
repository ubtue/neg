<%

  if (tabelle.startsWith("literatur")) {

    String limit = " ";

    if (tabelle.startsWith("literatur_sw")) {
      String quelltabelle = "";
      String zieltabelle = "";
      String id = "";
      String literaturID = "";
      String schlagwort = "";

      if (tabelle.endsWith("arealgens")) {
        quelltabelle = "tbl_swlitarealgens";
        zieltabelle = "literatur_sw_arealgens";
        id = "SWLitArealGens_ID";
        literaturID = "FK_LIT_ID";
        schlagwort = "SWArealGens";
      }
      else if (tabelle.endsWith("morphologie")) {
        quelltabelle = "tbl_swlitmorphologie";
        zieltabelle = "literatur_sw_morphologie";
        id = "SWLitMorphologie_ID";
        literaturID = "FK_LIT_ID";
        schlagwort = "SWMorphologie";
      }
      else if (tabelle.endsWith("namenelemente")) {
        quelltabelle = "tbl_swlitnamenelement";
        zieltabelle = "literatur_sw_namenelemente";
        id = "SWLitNamenElement_ID";
        literaturID = "FK_LIT_ID";
        schlagwort = "SWNamenElement";
      }
      else if (tabelle.endsWith("phongraph")) {
        quelltabelle = "tbl_swlitphonograph";
        zieltabelle = "literatur_sw_phongraph";
        id = "SWLitPhonGraph_ID";
        literaturID = "FK_LIT_ID";
        schlagwort = "SWPhonGraph";
      }

      if (!quelltabelle.equals("")) {
        Connection cn = null;
        Connection cn2 = null;

        Statement st = null;
        Statement st2 = null;

        ResultSet rs = null;

        try {
          Class.forName(sqlDriver);
          cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
          cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
          st = cn.createStatement();
          st2 = cn2.createStatement();
          rs = st.executeQuery("SELECT * FROM "+quelltabelle+" WHERE "+schlagwort+" IS NOT NULL");
          while (rs.next()) {
            st2.addBatch("INSERT INTO "+tabelle
                        +" (ID, LiteraturID, Schlagwort)"
                        +" VALUES ("
                        +rs.getInt(id)+", "
                        +rs.getInt(literaturID)+", "
                        +rs.getString(schlagwort)+");");
          }
          st2.executeBatch();
        }
        finally {
          try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
          try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
          try { if( null != st ) st.close(); } catch( Exception ex ) {}
          try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
          try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
        }
      }
    }
  
    if (tabelle.equals("literatur_autor")) {
      Connection cn = null;
      Connection cn2 = null;

      Statement st = null;
      Statement st2 = null;

      ResultSet rs = null;

      try {
        Class.forName(sqlDriver);
        cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
        cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st = cn.createStatement();
        st2 = cn2.createStatement();
        rs = st.executeQuery("SELECT * FROM tbl_literaturautor ORDER BY Nachname, Vorname");
        while (rs.next()) {
          st2.addBatch("INSERT INTO literatur_autor "
                      +" (LiteraturID, Nachname, Vorname)"
                      +" VALUES ("
                      +rs.getInt   ("FK_Lit_ID")+", "
                      +(rs.getString("Nachname")==null?"NULL":"'"+rs.getString("Nachname").replace("\'", "\\\'")+"'")+", "
                      +(rs.getString("Vorname" )==null?"NULL":"'"+rs.getString("Vorname" ).replace("\'", "\\\'")+"'")
                      +");");
        }
        st2.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }

    if (tabelle.equals("literatur_herausgeber")) {
      Connection cn = null;
      Connection cn2 = null;

      Statement st = null;
      Statement st2 = null;

      ResultSet rs = null;

      try {
        Class.forName(sqlDriver);
        cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
        cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st = cn.createStatement();
        st2 = cn2.createStatement();
        rs = st.executeQuery("SELECT * FROM tbl_literaturhrsg1 h JOIN tbl_literatur l ON l.Lit_ID = h.FK_Lit_ID1 ORDER BY Nachname, Vorname");
        while (rs.next()) {
          st2.addBatch("INSERT INTO literatur_herausgeber "
                      +" (LiteraturID, Nachname, Vorname, Verbindungstext)"
                      +" VALUES ("
                      +rs.getInt   ("FK_Lit_ID1")+", "
                      +(rs.getString("Nachname"            )==null?"NULL":"'"+DBtoDB(rs.getString("Nachname"            ))+"'")+", "
                      +(rs.getString("Vorname"             )==null?"NULL":"'"+DBtoDB(rs.getString("Vorname"             ))+"'")+", "
                      +(rs.getString("Lit_Verbindungstext1")==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Verbindungstext1"))+"'")
                      +");");
        }
        rs = st.executeQuery("SELECT * FROM tbl_literaturhrsg2 h JOIN tbl_literatur l ON l.Lit_ID = h.FK_Lit_ID2 ORDER BY Nachname, Vorname");
        while (rs.next()) {
          st2.addBatch("INSERT INTO literatur_herausgeber "
                      +" (LiteraturID, Nachname, Vorname, Verbindungstext)"
                      +" VALUES ("
                      +rs.getInt   ("FK_Lit_ID2")+", "
                      +(rs.getString("Nachname"            )==null?"NULL":"'"+DBtoDB(rs.getString("Nachname"            ))+"'")+", "
                      +(rs.getString("Vorname"             )==null?"NULL":"'"+DBtoDB(rs.getString("Vorname"             ))+"'")+", "
                      +(rs.getString("Lit_Verbindungstext2")==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Verbindungstext2"))+"'")
                      +");");
        }
        rs = st.executeQuery("SELECT * FROM tbl_literaturhrsg3 h JOIN tbl_literatur l ON l.Lit_ID = h.FK_Lit_ID3 ORDER BY Nachname, Vorname");
        while (rs.next()) {
          st2.addBatch("INSERT INTO literatur_herausgeber "
                      +" (LiteraturID, Nachname, Vorname, Verbindungstext)"
                      +" VALUES ("
                      +rs.getInt   ("FK_Lit_ID3")+", "
                      +(rs.getString("Nachname"            )==null?"NULL":"'"+DBtoDB(rs.getString("Nachname"            ))+"'")+", "
                      +(rs.getString("Vorname"             )==null?"NULL":"'"+DBtoDB(rs.getString("Vorname"             ))+"'")+", "
                      +(rs.getString("Lit_Verbindungstext3")==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Verbindungstext3"))+"'")
                      +");");
        }
        st2.executeBatch();
      }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }

    else if (tabelle.equals("literatur")) {
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
                             +" FROM tbl_literatur"
                             +limit);

        while (rs.next()) {
          try {
            st2.addBatch("INSERT INTO Literatur (ID, Titel, Titel2, LiteraturTypID, Auflage, Ort, Jahr, Seite, Reihe, "
                                               +"PhilologischRelevant, Kurzzitierweise, "
                                               +"LetzteAenderung, LetzteAenderungVon)"
                        +" VALUES ("+rs.getInt("Lit_ID")+", "
                                   +(rs.getString("Lit_Titel"          )==null?"''"  :"'"+DBtoDB(rs.getString("Lit_Titel"          ))+"'")+", "
                                   +(rs.getString("Lit_Titel2"         )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Titel2"         ))+"'")+", "
                                   +(rs.getString("Lit_Typ"            )==null?"NULL":"'"+       rs.getInt   ("Lit_Typ"            ) +"'")+", "
                                   +(rs.getString("Lit_Auflage"        )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Auflage"        ))+"'")+", "
                                   +(rs.getString("Lit_Ort"            )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Ort"            ))+"'")+", "
                                   +(rs.getString("Lit_Jahr"           )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Jahr"           ))+"'")+", "
                                   +(rs.getString("Lit_Seite"          )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Seite"          ))+"'")+", "
                                   +(rs.getString("Lit_Reihe"          )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Reihe"          ))+"'")+", "
                                   +(rs.getString("Lit_PhilologischRel")==null?"NULL":"'"+(rs.getInt("Lit_PhilologischRel")==0?0:1)  +"'")+", "
                                   +(rs.getString("Lit_Kurzzitierweise")==null?"NULL":"'"+DBtoDB(rs.getString("Lit_Kurzzitierweise"))+"'")+", "
                                   +(rs.getString("Lit_LastChx"        )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_LastChx"        ))+"'")+", "
                                   +(rs.getString("Lit_LastChxBy"      )==null?"NULL":"'"+DBtoDB(rs.getString("Lit_LastChxBy"      ))+"'")
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