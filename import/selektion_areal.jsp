<%
  if (tabelle.equals("selektion_areal")) {
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

      // Daten aus tbl_areale
      rs = st.executeQuery("SELECT DISTINCT Areal FROM tbl_areale ORDER BY Areal ASC");
      int i;
      for (i = 1; rs.next(); i++) {
        try {
          st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+DBtoDB(rs.getString("Areal"))+"');\n");
        }
        catch (SQLException e) {
          out.println(i+": >>"+rs.getString("Areal")+"<< "+e+"<br/>");
        }
      }
      st2.executeBatch();

      // Daten aus tbl_personen
      rs = st.executeQuery("SELECT DISTINCT p_Ort FROM tbl_personen ORDER BY p_Ort ASC");
      for (;rs.next(); i++) {
        try {
          st3 = cn2.createStatement();
          rs2 = st3.executeQuery("SELECT * FROM "+tabelle+" WHERE Bezeichnung='"+DBtoDB(rs.getString("p_Ort"))+"';\n");
          rs2.last();
          if (rs2.getRow() < 1)
            st2.addBatch("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+DBtoDB(rs.getString("p_Ort"))+"');\n");
        }
        catch (SQLException e) {
          out.println(i+": >>"+rs.getString("p_Ort")+"<< "+e+"<br/>");
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