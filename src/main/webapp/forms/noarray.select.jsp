<%
  if (feldtyp.equals("select") && !array) {
    try {


      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      int selected = -1;
      if (Integer.parseInt(id) > 0) {
        String sql = "SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"";
        System.out.println(sql);
        rs = st.executeQuery(sql);
        if(rs.next()) {
        	String selection = rs.getString(zielAttribut);
          if(selection!=null)selected = rs.getInt(zielAttribut);
        }
      }
      System.out.println("Geschlecht: " + selected);
      if(!isReadOnly){
         out.println("<select name=\""+datenfeld+"\"  style=\"width: 250px\"");
         out.println(">");
         if(typeFile != null)
         out.println("<option value=\"\">Datei ausw&auml;hlen</option>");
      }
      if(isEmpty)out.println("<option value=\"-2\">ist leer</option>");
      Statement st2 = null;
      ResultSet rs2 = null;
      try {
        st2 = cn.createStatement();
        String sql = "SELECT * FROM "+auswahlherkunft;
        if (auswahlherkunftFilter != null && !auswahlherkunftFilter.equals("") && filter != null && !filter.equals("")) {
            sql += " WHERE " + auswahlherkunftFilter +"='" + filter + "'";
        }
        if(!isSorted) sql += " ORDER BY Bezeichnung ASC";

        rs2 = st2.executeQuery(sql);
        while ( rs2.next() ) {
            String value = DBtoHTML(rs2.getString("Bezeichnung"));
            if(datenfeld.startsWith("Namenkommentar")) value = format(value, "PLemma");

            if(!isReadOnly)out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==selected?"selected":"")+">"+value+"</option>");
            else if(rs2.getInt("ID")==selected)out.println(value);
        }
      } finally {
        try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
        try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      }
     if(!isReadOnly) out.println("</select>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
          if(!tooltip.equals("")) out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\""+tooltip+"\"> ? </a>");

  }
%>
