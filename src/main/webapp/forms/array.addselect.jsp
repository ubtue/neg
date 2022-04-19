<%
  if (feldtyp.equals("addselect") && array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT ID, "+zielAttribut+" FROM "+zielTabelle+" WHERE "+formular+"ID=\""+id+"\"");
      int selected = -1;
      out.println("<table>");
      int i=0;
      boolean repeat = true;
      while (repeat) {
        out.println("<tr>");
        out.println("<td>");
        if (rs.next()) {
          selected = rs.getInt(zielAttribut);
          if(!isReadOnly)out.println("<input type=\"hidden\" name =\""+datenfeld+"["+i+"]"+"_entryid\" value=\""+rs.getInt("ID")+"\">");
        } else {
          selected = -1;
          repeat = false;
        }
        if(!isReadOnly)out.println("<select name=\""+datenfeld+"["+i+"]\" id=\""+datenfeld+"["+i+"]\">");
        Statement st2 = null;
        ResultSet rs2 = null;
        try {
          st2 = cn.createStatement();
          rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");
          if(!isReadOnly){
             out.println("<option value=\"-1\">nicht bearbeitet</option>");
             out.println("<option value=\"0\">unklar</option>");
          }
          while ( rs2.next() ) {
           if(!isReadOnly) out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==selected?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
           else if(repeat && rs2.getInt("ID")==selected) out.println(DBtoHTML(rs2.getString("Bezeichnung")));
          }
        } finally {
          try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
          try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        }
        if(!isReadOnly)out.println("</select>");
        out.println("</td>");
        if (repeat) {
          String href = "javascript:deleteEntry('"+zielTabelle+"', '"+rs.getInt("ID")+"', '"+returnpage+"', '"+id+"');";
          out.println("<td>");
         if(!isReadOnly){ out.println("<a href=\""+href+"\">");
          out.println(txt_delete);
          out.println("</a>");}
          out.println("</td>");
        }
        else {
          if(!isReadOnly)out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '"+auswahlherkunft.substring(10)+"', '"+datenfeld+"["+i+"]', '');\">"+txt_newentry+"</a></td>");
        }
        out.println("</tr>");
        i++;
      }
      out.println("</table>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
 %>
