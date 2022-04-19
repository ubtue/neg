<%
  String quelltabelle = "";
  String quellbemerkung = "";
  String quellID = "";
  String zielID = "";

  if (tabelle.equals("quelle")) {
    quelltabelle = "tbl_quellen";
    quellbemerkung = "QBemerkung";
    quellID = "Q_ID";
    zielID = "QuelleID";
  }

  if (tabelle.equals("einzelbeleg")) {
    quelltabelle = "tbl_einzelbelege";
    quellbemerkung = "b_Bemerkungen";
    quellID = "BelegID";
    zielID = "EinzelbelegID";
  }

  if (tabelle.equals("edition")) {
    quelltabelle = "tbl_qeditionen";
    quellbemerkung = "E_Bemerkung";
    quellID = "E_ID";
    zielID = "EditionID";
  }

  if (tabelle.equals("handschrift")) {
    quelltabelle = "tbl_quellenueberlieferung";
    quellbemerkung = "QU_Bemerkung";
    quellID = "QU_ID";
    zielID = "HandschriftID";
  }

  if (!quelltabelle.equals("")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;
    try {
      Class.forName(sqlDriver);
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT * FROM "+quelltabelle+" WHERE "+quellbemerkung+" IS NOT NULL AND "+quellbemerkung+" != '' ORDER BY "+quellID+" ASC");
      while (rs.next()) {
        Connection cn2 = null;
        Statement st2 = null;
        ResultSet rs2 = null;  
        try {
          Class.forName( sqlDriver );
          cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
          st2 = cn2.createStatement();
          st2.execute("INSERT INTO bemerkung"
                      +" ("+zielID+", Bemerkung)"
                      +"VALUES ("
                      +rs.getInt(quellID)+", "
                      +"'"+rs.getString(quellbemerkung)+"');");
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
