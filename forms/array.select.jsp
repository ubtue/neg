<%
  if (feldtyp.equals("select") && array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      
      rs = st.executeQuery("SELECT ID, "+zielAttribut
                           +" FROM "+zielTabelle
                           +" WHERE "+formular+"ID='"+id+"'"
                           +" ORDER BY ID ASC;");
      out.println("<table>");
      boolean repeat = true;
      int i = 0;
      while (repeat) {
        int selected = -1;
        if (rs.next()) {
          selected = rs.getInt(zielAttribut);
          out.println("<input type=\"hidden\" name =\""+datenfeld+"["+i+"]"+"_entryid\" value=\""+rs.getInt("ID")+"\">");
        }
        else {
          repeat = false;
        }

        out.println("<tr>");
        out.println("<td>");

        if(!isReadOnly)out.println("<select name='"+datenfeld+"["+i+"]'>");
        Statement st2 = null;
        ResultSet rs2 = null;
        try {
          st2 = cn.createStatement();
          rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");
          while ( rs2.next() ) {
            if(!isReadOnly)out.println("<option value='"+rs2.getInt("ID")+"' "+(rs2.getInt("ID")==selected?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
            else if (repeat && rs2.getInt("ID")==selected)out.println(DBtoHTML(rs2.getString("Bezeichnung")));
          }
        } finally {
          try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
          try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
        }
       if(!isReadOnly) out.println("</select>");
        out.println("</td>");
        if (repeat) {
          String href = "javascript:deleteEntry('"+zielTabelle+"', '"+rs.getInt("ID")+"', '"+returnpage+"', '"+id+"');";
          out.println("<td>");
          if(!isReadOnly){
            out.println("<a href=\""+href+"\">");
            out.println(txt_delete);
            out.println("</a>");
          }
          out.println("</td>");
        }
        out.println("</tr>");
        i++;
      }
      out.println("</table>");
    } catch (SQLException e) {out.println(e);
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
