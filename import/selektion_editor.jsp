<%
  if (tabelle.equals("selektion_editor")) {
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

      rs = st.executeQuery("SELECT QHA_Vorname, QHA_Nachname"
                           +" FROM tbl_qehrsgautor"
                           +" GROUP BY QHA_Vorname, QHA_Nachname"
                           +" ORDER BY QHA_Nachname, QHA_Vorname ASC");
      for (int i = 1; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO selektion_editor (ID, Nachname, Vorname, Bezeichnung)"
                       +" VALUES ('"+i+"', "
                       +(rs.getString("QHA_Nachname")==null?"NULL":"'"+rs.getString("QHA_Nachname").replace("\'", "\\'")+"'")+", "
                       +(rs.getString("QHA_Vorname" )==null?"NULL":"'"+rs.getString("QHA_Vorname" ).replace("\'", "\\'")+"'")+", "
                   +"'"+(rs.getString("QHA_Nachname")==null?"":rs.getString("QHA_Nachname").replace("\'", "\\'")+", ")
                       +(rs.getString("QHA_Vorname" )==null?"":rs.getString("QHA_Vorname" ).replace("\'", "\\'")+"'")
                       +");");
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
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != newDB ) newDB.close(); } catch( Exception ex ) {}
      try { if( null != oldDB ) oldDB.close(); } catch( Exception ex ) {}
    }
  }
%>
