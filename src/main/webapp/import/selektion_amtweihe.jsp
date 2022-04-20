<%
  if (tabelle.equals("selektion_amtweihe")) {
    Connection cn = null;
    Connection cn2 = null;

    Statement st = null;
    Statement st2 = null;
    Statement st3 = null;

    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = cn.createStatement();
      st2 = cn2.createStatement();

      // Daten aus tbl_selpersonenamt
      rs = st.executeQuery("SELECT DISTINCT PersonAmt FROM tbl_selpersonenamt ORDER BY PersonAmt ASC");
      int i;
      for (i = 1; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+DBtoDB(rs.getString("PersonAmt"))+"');\n");
        }
        catch (SQLException e) {
          out.println(e+"<br/>");
        }
      }
      st2.executeBatch();

      // Daten aus tbl_selaemter
      rs = st.executeQuery("SELECT DISTINCT Amt FROM tbl_selaemter ORDER BY Amt ASC");
      for (;rs.next(); i++) {
        try {
          st3 = cn2.createStatement();
          rs2 = st3.executeQuery("SELECT * FROM "+tabelle+" WHERE Bezeichnung='"+DBtoDB(rs.getString("Amt"))+"';\n");
          rs2.last();
          if (rs2.getRow() < 1)
            st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+DBtoDB(rs.getString("Amt"))+"');\n");
          else
            i--;
        }
        catch (SQLException e) {
          out.println(e+"<br/>");
        }
      }
      st2.executeBatch();

      // Daten aus tbl_selamtpersonen
      rs = st.executeQuery("SELECT DISTINCT Amt FROM tbl_selamtpersonen ORDER BY Amt ASC");
      for (;rs.next(); i++) {
        try {
          st3 = cn2.createStatement();
          rs2 = st3.executeQuery("SELECT * FROM "+tabelle+" WHERE Bezeichnung='"+DBtoDB(rs.getString("Amt"))+"';\n");
          rs2.last();
          if (rs2.getRow() < 1)
            st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+DBtoDB(rs.getString("Amt"))+"');\n");
          else
            i--;
        }
        catch (SQLException e) {
          out.println(e+"<br/>");
        }
      }
      st2.executeBatch();

    }
    catch (SQLException e) {
      out.println(e);
    }
    finally {
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st3 ) st3.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
