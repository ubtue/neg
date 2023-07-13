<%
  if (feldtyp.equals("sqlselect") && !array) {
    String sql = "";
    if (datenfeld.equals("Edition")) {
      sql = "SELECT edition.ID ID, edition.Zitierweise Bezeichnung"
            + " FROM edition, quelle_inedition, einzelbeleg"
            + " WHERE einzelbeleg.ID = "+id+" AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND quelle_inedition.EditionID = edition.ID";
    }
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT einzelbeleg.editionID"
            + " FROM edition, quelle_inedition, einzelbeleg"
            + " WHERE einzelbeleg.ID = "+id+" AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND einzelbeleg.EditionID = quelle_inedition.EditionID AND quelle_inedition.EditionID = edition.ID");
      int selected = -1;
      if(rs.next()) {
        selected = rs.getInt(zielAttribut);
      }
      else{
            Statement st3 = cn.createStatement();
            ResultSet rs3 = st3.executeQuery("SELECT edition.ID ID"
            + " FROM edition, quelle_inedition, einzelbeleg"
            + " WHERE einzelbeleg.ID = "+id+" AND einzelbeleg.QuelleID = quelle_inedition.QuelleID AND quelle_inedition.EditionID = edition.ID AND quelle_inedition.Standard=1");
            if(rs3.next())
            {
        selected = rs3.getInt("ID");
      }
      }

      if(!isReadOnly)out.println("<select name=\""+datenfeld+"\">");
      Statement st2 = null;
      ResultSet rs2 = null;
      try {
        st2 = cn.createStatement();
        rs2 = st2.executeQuery(sql);
     //   out.println("<option value=\"-1\">nicht bearbeitet</option>");
        while ( rs2.next() ) {
         if(!isReadOnly) out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==selected?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
         else if(rs2.getInt("ID")==selected) out.println(DBtoHTML(rs2.getString("Bezeichnung")));
        }
      } finally {
        try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      }
      if(!isReadOnly)out.println("</select>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
