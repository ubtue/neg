<%
  if (readonly!=null && readonly.equals("yes") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      int selected = -1;
      if (Integer.parseInt(id) > 0) {     
        rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if(rs.next()) {
          selected = rs.getInt(zielAttribut);
        }
      }
      Statement st2 = null;
      ResultSet rs2 = null;
      try {
        st2 = cn.createStatement();
        rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft+" where ID=" +selected+ " ORDER BY Bezeichnung ASC");
        while ( rs2.next() ) {
          out.println(DBtoHTML(rs2.getString("Bezeichnung")));
        }
      } finally {
        try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      }
      out.println("</select>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
