<%
  if (feldtyp.equals("infouser") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT benutzer.Vorname, benutzer.Nachname, benutzer_gruppe.Bezeichnung  FROM "+zielTabelle+", benutzer, benutzer_gruppe WHERE "+zielTabelle+".ID=\""+id+"\" AND "+zielTabelle+"."+zielAttribut+"=benutzer.ID AND benutzer.GruppeID = benutzer_gruppe.ID");
      if ( rs.next()) {
        out.print(
           DBtoHTML(rs.getString("benutzer.Vorname"))
          +" "
          +DBtoHTML(rs.getString("benutzer.Nachname"))
          +" ("
          +DBtoHTML(rs.getString("benutzer_gruppe.Bezeichnung"))
          +")");
      }
    }
    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>