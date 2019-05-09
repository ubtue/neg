<%
  if (tabelle.equals("selektion_funktion")) {
    Connection cn = null;
    Connection cn2 = null;

    Statement st = null;
    Statement st2 = null;

    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );

      st = cn.createStatement();
      st2 = cn2.createStatement();

      rs = st.executeQuery("SELECT b_Funktion"
                           +" FROM tbl_einzelbelege"
                           +" WHERE b_Funktion IS NOT NULL AND b_Funktion !=''"
                           +" GROUP BY b_Funktion"
                           +" ORDER BY b_Funktion ASC");

      for (int i = 1; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung)"
                       +" VALUES ('"+i+"', '"+rs.getString("b_Funktion").replace("\'", "\\\'")+"');");
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

      try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
