<%

  if (tabelle.startsWith("person")) {
  String limit = ""; // LIMIT 20000, 10000";

  if (tabelle.equals("person_verwandtmit")) {
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

      rs = st.executeQuery("SELECT tbl_verwandtschaft.fk_P_ID pidV, tbl_personen.P_ID pidZ, tbl_verwandtschaft.Verwandtschaftsgrad vwg"
                           +" FROM tbl_verwandtschaft, tbl_personen"
                           +" WHERE tbl_verwandtschaft.v_pkz = tbl_personen.p_pkz"
                           +limit);

      for (int i = 1; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO person_verwandtmit (ID, PersonIDvon, PersonIDzu, VerwandtschaftsgradID)"
                        +" VALUES ("+i+", "+rs.getInt("pidV")+", "+rs.getInt("pidZ")+", "+rs.getInt("vwg")+");");
        }
        catch (SQLException e) { out.println(e); }
        if (i % 5000 == 0)
          st2.executeBatch();
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


    else if (tabelle.equals("person_hatamtstandweihe")) {
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

        rs = st.executeQuery("SELECT tbl_personaemter.fk_P_ID, tbl_selpersonenamt.PersonAmt, PA_Zeitraum, PA_Identifizierung"
                             +" FROM tbl_personaemter, tbl_selpersonenamt"
                             +" WHERE tbl_personaemter.PA_Amt = tbl_selpersonenamt.PA_ID"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st3 = newDB.createStatement();
            rs2 = st3.executeQuery("SELECT ID FROM selektion_amtweihe WHERE Bezeichnung ='"+DBtoDB(rs.getString("PersonAmt"))+"';");
            if (rs2.next()) {
              st2.addBatch("INSERT INTO "+tabelle+" (ID, PersonID, AmtWeiheID, Zeitraum, Identifizierung)"
                            +" VALUES ("+i+", "
                                        +rs.getInt("fk_P_ID")+", "
                                        +rs2.getInt("ID")+", "
                                        +"\""+DBtoDB(rs.getString("PA_Zeitraum"))+"\", "
                                        +rs.getInt("PA_Identifizierung")+");");
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

    else if (tabelle.equals("person_hatstand")) {
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

        rs = st.executeQuery("SELECT P_ID, p_Stand"
                             +" FROM tbl_personen"
                             +" WHERE p_Stand IS NOT NULL"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO person_hatstand (ID, PersonID, StandID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("P_ID"           )+", "
                                      +rs.getInt("p_Stand"            )+");");
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

    else if (tabelle.equals("person_quiet")) {
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

        rs = st.executeQuery("SELECT P_ID, p_QuiEt, p_Name2"
                             +" FROM tbl_personen"
                             +" WHERE (p_QuiEt IS NOT NULL AND p_QuiEt !='') OR (p_Name2 IS NOT NULL AND p_Name2 !='')"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO person_quiet (ID, PersonID, QuiEt, Zusatz)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("P_ID"       )+", "
                                      +(rs.getString("p_QuiEt")==null?"NULL":"'"+rs.getString("p_QuiEt")+"'")+", "
                                      +(rs.getString("p_Name2")==null?"NULL":"'"+rs.getString("p_Name2")+"'")+");");
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

    else if (tabelle.equals("person_hatethnie")) {
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

        rs = st.executeQuery("SELECT P_ID, p_GentileZuordnung"
                             +" FROM tbl_personen"
                             +" WHERE p_GentileZuordnung IS NOT NULL"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO person_hatethnie (ID, PersonID, EthnieID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("P_ID"              )+", "
                                      +rs.getInt("p_GentileZuordnung")+");");
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

    else if (tabelle.equals("person_hatareal")) {
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

        rs = st.executeQuery("SELECT P_ID, p_Ort"
                             +" FROM tbl_personen"
                             +" WHERE p_Ort IS NOT NULL AND p_Ort != ''"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          try {
            st3 = newDB.createStatement();
            rs2 = st3.executeQuery("SELECT ID FROM selektion_areal WHERE Bezeichnung ='"+DBtoDB(rs.getString("p_Ort"))+"';");
            rs2.next();

            st2.addBatch("INSERT INTO person_hatareal (ID, PersonID, ArealID)"
                          +" VALUES ("+i+", "
                                      +rs.getInt("P_ID")+", "
                                      +rs2.getInt("ID")+");");
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


    else if (tabelle.equals("person")) {
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

        rs = st.executeQuery("SELECT *"
                             +" FROM tbl_personen"
                             +limit);

        for (int i = 1; rs.next(); i++) {
          st2.addBatch("INSERT INTO person (ID, PKZ, Standardname, Geschlecht,"
                        +" Fiktiv, BearbeitungsstatusID, KommentarEthnie, KommentarAreal,"
                        +" PersonenkommentarDatei, Identifizierungsproblem, Ort,"
                        +" LetzteAenderung, LetzteAenderungVon, Erstellt, ErstelltVon)"
                        +" VALUES ("+rs.getInt   ("P_ID"                      )+", "
                                   +(rs.getString("p_pkz"                     )==null?"\"\"":"'"+DBtoDB(rs.getString("p_pkz"                     ))+"'")+", "
                                   +(rs.getString("p_Standardname"            )==null?"NULL":"'"+DBtoDB(rs.getString("p_Standardname"            ))+"'")+", "
                                   +(rs.getString("p_Geschlecht"              )==null?"NULL":"'"+DBtoDB(rs.getString("p_Geschlecht"              ))+"'")+", "
                                   +(rs.getString("p_FiktivePerson"           )==null?"NULL":"'"+DBtoDB(rs.getString("p_FiktivePerson"           ))+"'")+", "
                                   +(rs.getInt   ("p_bearbeitet"              )==-1?3:1)+", "
                                   +(rs.getString("p_Ethnie"                  )==null?"NULL":"'"+DBtoDB(rs.getString("p_Ethnie"                  ))+"'")+", "
                                   +(rs.getString("p_Ort"                     )==null?"NULL":"'"+DBtoDB(rs.getString("p_Ort"                     ))+"'")+", "
                                   +(rs.getString("p_KomFileName"             )==null?"NULL":"'"+DBtoDB(rs.getString("p_KomFileName"             ))+"'")+", "
                                   +(rs.getString("p_Identifizierungsprobleme")==null?"NULL":"'"+DBtoDB(rs.getString("p_Identifizierungsprobleme"))+"'")+", "
                                   +(rs.getString("p_Ort"                     )==null?"NULL":"'"+DBtoDB(rs.getString("p_Ort"                     ))+"'")+", "
                                   +(rs.getString("LastChx"                   )==null?"NULL":"'"+DBtoDB(rs.getString("LastChx"                   ))+"'")+", "
                                   +(rs.getString("LastChxBy"                 )==null?"NULL":"'"+DBtoDB(rs.getString("LastChxBy"                 ))+"'")+", "
                                   +(rs.getString("Created"                   )==null?"NULL":"'"+DBtoDB(rs.getString("Created"                   ))+"'")+", "
                                   +(rs.getString("CreatedBy"                 )==null?"NULL":"'"+DBtoDB(rs.getString("CreatedBy"                 ))+"'")
                                   +");");
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