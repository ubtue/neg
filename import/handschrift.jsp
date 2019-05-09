<%
  if (tabelle.startsWith("handschrift")) {
    String limit = " ";
    if (tabelle.equals("handschrift")) {
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

        rs = st.executeQuery("SELECT QU_Bibliothekssignatur"
                             +" FROM tbl_quellenueberlieferung"
                             +" GROUP BY QU_Bibliothekssignatur"
                             +limit);
        for (int i=1; rs.next(); i++) {
          try {
            st2.addBatch("INSERT INTO handschrift (ID, Bibliothekssignatur) VALUES ("+i+", \""+DBtoDB(rs.getString("QU_Bibliothekssignatur"))+"\");");
          }
          catch (SQLException e) { out.println(e); }
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

    if (tabelle.equals("handschrift_ueberlieferung")) {
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

        rs = st.executeQuery("SELECT QU_ID, FK_Q_ID, QU_Sigle, QU_Herkunftsort, QU_Bibliothekssignatur, QU_JahrGenauigkeit, QU_MonatGenauigkeit,"
                             +" QU_TagGenauigkeit, QU_JhGenauigkeit, QU_Dat_Ueberlieferung, QU_Jahr, QU_BisJahr, QU_Monat, QU_BisMonat, QU_Tag, QU_BisTag,"
                             +" QU_Jh, QU_BisJH"
                             +" FROM tbl_quellenueberlieferung"
                             +limit);

        while (rs.next()) {
          try {
            st2.addBatch("INSERT INTO handschrift_ueberlieferung (ID, QuelleID, Sigle, Bibliothekssignatur, VonTag, VonMonat, VonJahr, VonJahrhundert, BisTag, BisMonat, BisJahr, BisJahrhundert,"
                        +" GenauigkeitVonTag, GenauigkeitVonMonat, GenauigkeitVonJahr, GenauigkeitVonJahrhundert, UeberlieferungDatierung)"
                        +" VALUES ("+rs.getInt("QU_ID")+", "
                                   +"'"+rs.getInt("FK_Q_ID")+"', "
                                       +(rs.getString("QU_Sigle"           )==null?"NULL":"'"+DBtoDB(rs.getString("QU_Sigle"))+"'")+", "
                                       +(rs.getString("QU_Bibliothekssignatur")==null?"NULL":"'"+DBtoDB(rs.getString("QU_Bibliothekssignatur" ))+"'")+", "
                                       +(rs.getString("QU_Tag"             )==null?"NULL":"'"+rs.getInt("QU_Tag"             )+"'")+", "
                                       +(rs.getString("QU_Monat"           )==null?"NULL":"'"+rs.getInt("QU_Monat"           )+"'")+", "
                                       +(rs.getString("QU_Jahr"            )==null?"NULL":"'"+rs.getInt("QU_Jahr"            )+"'")+", "
                                       +(rs.getString("QU_Jh"              )==null?"NULL":"'"+rs.getString("QU_Jh"           )+"'")+", "
                                       +(rs.getString("QU_BisTag"          )==null?"NULL":"'"+rs.getInt("QU_BisTag"          )+"'")+", "
                                       +(rs.getString("QU_BisMonat"        )==null?"NULL":"'"+rs.getInt("QU_BisMonat"        )+"'")+", "
                                       +(rs.getString("QU_BisJahr"         )==null?"NULL":"'"+rs.getInt("QU_BisJahr"         )+"'")+", "
                                       +(rs.getString("QU_BisJh"           )==null?"NULL":"'"+rs.getString("QU_BisJh"        )+"'")+", "
                                       +(rs.getString("QU_TagGenauigkeit"  )==null?-1    :"'"+rs.getInt("QU_TagGenauigkeit"  )+"'")+", "
                                       +(rs.getString("QU_MonatGenauigkeit")==null?-1    :"'"+rs.getInt("QU_MonatGenauigkeit")+"'")+", "
                                       +(rs.getString("QU_JahrGenauigkeit" )==null?-1    :"'"+rs.getInt("QU_JahrGenauigkeit" )+"'")+", "
                                       +(rs.getString("QU_JhGenauigkeit"   )==null?-1    :"'"+rs.getInt("QU_JhGenauigkeit"   )+"'")+", "
                                       +(rs.getString("QU_Dat_Ueberlieferung")==null?"NULL":"'"+DBtoDB(rs.getString("QU_Dat_Ueberlieferung"  ))+"'")+");");
          }
          catch (SQLException e) { out.println(e); }
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
  }
%>
