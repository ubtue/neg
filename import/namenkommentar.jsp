<%
  if (tabelle.equals("namenkommentar")) {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT * FROM tbl_namenkommentar");

      Connection cn2 = null;
      Statement st2 = null;
      try {
        cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st2 = cn2.createStatement();
        while (rs.next()) {
          st2.addBatch("INSERT INTO namenkommentar"
                      +" (ID, ELemma, PLemma, Suffix, Protokoll, Hinweise, Dateiname,"
                      +" LetzteAenderung, LetzteAenderungVon) VALUES ("
                      +"'"+rs.getInt("NK_ID")+"', "
                      +(rs.getString("NK_ELemma"   )!=null?"'"+DBtoDB(rs.getString("NK_ELemma"   ))+"'":"NULL")+", "
                      +(rs.getString("NK_PLemma"   )!=null?"'"+DBtoDB(rs.getString("NK_PLemma"   ))+"'":"NULL")+", "
                      +(rs.getString("NK_Suffix"   )!=null?"'"+DBtoDB(rs.getString("NK_Suffix"   ))+"'":"NULL")+", "
                      +(rs.getString("NK_Protokoll")!=null?"'"+DBtoDB(rs.getString("NK_Protokoll"))+"'":"NULL")+", "
                      +(rs.getString("NK_Hinweise" )!=null?"'"+DBtoDB(rs.getString("NK_Hinweise" ))+"'":"NULL")+", "
                      +(rs.getString("NK_FileName" )!=null?"'"+DBtoDB(rs.getString("NK_FileName" ))+"'":"NULL")+", "
                      +(rs.getString("NK_LastChx"  )!=null?"'"+DBtoDB(rs.getString("NK_LastChx"  ))+"'":"NULL")+", "
                      +(rs.getString("NK_LastChxBy")!=null?"'"+DBtoDB(rs.getString("NK_LastChxBy"))+"'":"NULL")
                      +");");
        }
       st2.executeBatch();
      }
      catch (SQLException e) { out.println(e); }
      finally {
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
      }
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }


  if (tabelle.startsWith("namenkommentar_")) {
    String quelltabelle = "";
    String zieltabelle = "";

    if (tabelle.endsWith("bearbeiter")) {
      quelltabelle = "tbl_nm_nkuser";
      zieltabelle = "namenkommentar_bearbeiter";
    } else if (tabelle.endsWith("korrektor")) {
      quelltabelle = "tbl_nm_nkkorr";
      zieltabelle = "namenkommentar_korrektor";
    }

    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURLOld, sqlUserOld, sqlPasswordOld );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT * FROM "+quelltabelle +"");

      Connection cn2 = null;
      Statement st2 = null;
      try {
        cn2 = DriverManager.getConnection( sqlURLNew, sqlUserNew, sqlPasswordNew );
        st2 = cn2.createStatement();
        while (rs.next()) {
          st2.addBatch("INSERT INTO "+zieltabelle+" (NamenkommentarID, BenutzerID, Zeitstempel) VALUES ("
                      +"'"+rs.getInt("NK_ID")+"', "
                      +"'"+rs.getInt("B_ID")+"', "
                      +"'"+rs.getTimestamp("Akt_datum")+"'"
                      +");");
        }
        st2.executeBatch();
      }
      catch (SQLException e) {}
      finally {
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        try { if( null != cn2 ) cn2.close(); } catch( Exception ex ) {}
      }
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }

%>
