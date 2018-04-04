<%
  if (feldtyp.equals("addselect") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
      int selected = -1;
      if(rs.next()) {
        selected = rs.getInt(zielAttribut);
      }
      out.println("<select name=\""+datenfeld+"\" id=\""+datenfeld+"\">");
      Statement st2 = null;
      ResultSet rs2 = null;
      try {
        st2 = cn.createStatement();
        rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");
        while ( rs2.next() ) {
          out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==selected?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
        }
                  out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '"+auswahlherkunft.substring(10)+"', '"+datenfeld+"', '');\">"+txt_newentry+"</a></td>");

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