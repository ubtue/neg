<%
  if (tabelle.equals("ueberlieferung_edition")) {
    Connection oldDB = null;
    Connection newDB = null;

    Statement st = null;
    Statement st2 = null;

    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      oldDB = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      newDB = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = newDB.createStatement();

      // Vorbereitungen
      st.addBatch("ALTER table handschrift_ueberlieferung ADD COLUMN `EditionID` int(11) NOT NULL default '-1';");
      st.addBatch("ALTER table handschrift_ueberlieferung ADD COLUMN `Bibliotheksheimat` int(11) NOT NULL default '-1';");
      st.addBatch("ALTER TABLE datenbank_mapping MODIFY COLUMN `ZielAttribut` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;");
      st.addBatch("UPDATE einzelbeleg SET EditionID=-1 WHERE EditionID IS NULL;");
      st.executeBatch();
      out.println("<p>done</p>");
    }
    catch (SQLException e) {
      out.println(e+"<br>");
    }

    try{
      st = newDB.createStatement();
      rs = st.executeQuery("SELECT * FROM handschrift_ueberlieferung");

      while ( rs.next() ) {
        st2 = newDB.createStatement();
        String sql = "INSERT INTO ueberlieferung_edition (UeberlieferungID, EditionID, Sigle)"
                     +" VALUES ("+rs.getInt("ID")+", "+rs.getInt("EditionID")+",'"+DBtoDB(rs.getString("Sigle"))+"')";
        out.println(DBtoHTML(sql)+"<br>");
        st2.execute(sql);
      }
    }
    catch (SQLException e) {
      out.println(e+"<br>");
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }
%>