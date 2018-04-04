<%
  if (tabelle.startsWith("schlagwort")) {
    String quelltabelle = "";
    String zieltabelle = "";
    String id = "";
    String namenkommentarID = "";
    String schlagwort = "";

    if (tabelle.endsWith("arealgens")) {
      quelltabelle = "tbl_swarealgens";
      zieltabelle = "schlagwort_arealgens";
      id = "SWArealGens_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWArealGens";
    }
    else if (tabelle.endsWith("morphologie")) {
      quelltabelle = "tbl_swmorphologie";
      zieltabelle = "schlagwort_morphologie";
      id = "SWMorphologie_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWMorphologie";
    }
    else if (tabelle.endsWith("motivation")) {
      quelltabelle = "tbl_swmotivation";
      zieltabelle = "schlagwort_motivation";
      id = "SWMotivation_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWMotivation";
    }
    else if (tabelle.endsWith("namenlexikon")) {
      quelltabelle = "tbl_swnamenlexik";
      zieltabelle = "schlagwort_namenlexikon";
      id = "SWNamenlexik_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWNamenlexik";
    }
    else if (tabelle.endsWith("phongraph")) {
      quelltabelle = "tbl_swphonograph";
      zieltabelle = "schlagwort_phongraph";
      id = "SWPhonGraph_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWPhonoGraph";
    }
    else if (tabelle.endsWith("sprachherkunft")) {
      quelltabelle = "tbl_swsprachlherkunft";
      zieltabelle = "schlagwort_sprachherkunft";
      id = "SWSprachlHerkunft_ID";
      namenkommentarID = "FK_NK_ID";
      schlagwort = "SWSprachlHerkunft";
    }


    if (!quelltabelle.equals("")) {
      Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      try {
        Class.forName(sqlDriver);
        cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM "+quelltabelle);
        while (rs.next()) {
          Connection cn2 = null;
          Statement st2 = null;
          ResultSet rs2 = null;  
          try {
            Class.forName( sqlDriver );
            cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
            st2 = cn2.createStatement();
            st2.execute("INSERT INTO "+tabelle
                        +" (ID, NamenkommentarID, Schlagwort)"
                        +" VALUES ("
                        +rs.getInt(id)+", "
                        +rs.getInt(namenkommentarID)+", "
                        +rs.getString(schlagwort)+");");
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
  }
%>