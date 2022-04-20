<%
  if (feldtyp.equals("note") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      String sql = "";
      if (datenfeld.startsWith("Bemerkung")) {
        sql = "SELECT " + zielAttribut
              +" FROM " + zielTabelle
              +" WHERE "+formularAttribut+"=\""+id+"\"";
        if (datenfeld.endsWith("Alle")) {
          sql += " AND GruppeID IS NULL AND BenutzerID IS NULL";
        }
        else if (datenfeld.endsWith("Gruppe")) {
          sql += " AND GruppeID = "+session.getAttribute("GruppeID")+" AND BenutzerID IS NULL";
        }
        else if (datenfeld.endsWith("Privat")) {
          sql += " AND GruppeID IS NULL AND BenutzerID = "+session.getAttribute("BenutzerID")+"";
        }
        rs = st.executeQuery(sql);
      }
     if(!isReadOnly) out.print("<textarea name=\""+datenfeld+"\" "
                   +(cols>0?"cols=\""+cols+"\" ":"")
                   +(rows>0?"rows=\""+rows+"\" ":"")
                   +">");
      if ( rs.next() ) {
        out.print((rs.getString(zielAttribut)!=null?DBtoHTML(rs.getString(zielAttribut)):""));
      }
           if(!isReadOnly)out.println("</textarea>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
