﻿<%
  if (tabelle.equals("selektion_urkundeausstellerempfaenger")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT QAussteller uae FROM tbl_quellen WHERE QAussteller != '' UNION SELECT QEmpfaenger uae FROM tbl_quellen WHERE QEmpfaenger != '' GROUP BY uae ORDER BY uae ASC");
      for (int i=1; rs.next(); i++) {
        Connection cn2 = null;
        Statement st2 = null;
        ResultSet rs2 = null;  
        try {
          Class.forName( sqlDriver );
          cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
          st2 = cn2.createStatement();
          st2.execute("INSERT INTO "+tabelle+" (ID, Bezeichnung) VALUES ('"+i+"', '"+rs.getString("uae")+"');\n");
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