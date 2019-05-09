<%
  if (tabelle.startsWith("urkunde")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT Q_ID q, QAussteller a, QEmpfaenger e, QBetreff b, QActumort ac, QDorsalnotiz d"
                           +" FROM tbl_quellen"
                           +" WHERE QAussteller IS NOT NULL OR QEmpfaenger IS NOT NULL OR QBetreff IS NOT NULL OR QActumort IS NOT NULL OR QDorsalnotiz IS NOT NULL"
                           +" ");
      for (int i = 1; rs.next(); i++) {
        Connection cn2 = null;
        Statement st2 = null;
        try {
          Class.forName( sqlDriver );
          cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
          st2 = cn2.createStatement();
          st2.execute("INSERT INTO urkunde (ID, QuelleID, Actumort)"
                      +" VALUES ('"+i+"', '"+rs.getInt("q")+"', '"+rs.getString("ac")+"');");
          if (rs.getString("d") != null && !rs.getString("d").equals("")) {
            st2.execute("INSERT INTO urkunde_dorsalnotiz (UrkundeID, Dorsalnotiz)"
                       +" VALUES ('"+i+"', '"+rs.getString("d")+"');");
          }
          if (rs.getString("b") != null && !rs.getString("b").equals("")) {
            st2.execute("INSERT INTO urkunde_betreff (UrkundeID, Betreff)"
                       +" VALUES ('"+i+"', '"+rs.getString("b")+"');");
          }
          st2.execute("INSERT INTO urkunde_hatempfaenger (UrkundeID, EmpfaengerID)"
                        +" (SELECT '"+i+"', ID FROM selektion_urkundeausstellerempfaenger"
                        +" WHERE Bezeichnung = '"+rs.getString("e")+"');");
          st2.execute("INSERT INTO urkunde_hataussteller (UrkundeID, AusstellerID)"
                        +" (SELECT '"+i+"', ID FROM selektion_urkundeausstellerempfaenger"
                        +" WHERE Bezeichnung = '"+rs.getString("a")+"');");
        } catch (SQLException e) {
        } finally {
          try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
          try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
        }
      }
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
