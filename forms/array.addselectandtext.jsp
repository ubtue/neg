<%
  if (feldtyp.equals("addselectandtext") && array) {
    Statement st2 = null;
    ResultSet rs2 = null;
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT "+zielTabelle+".ID, "+auswahlherkunft+".Bezeichnung, "+auswahlherkunft+".ID value FROM "+zielTabelle+", "+auswahlherkunft+" WHERE "+zielTabelle+"."+formular+"ID="+id+" AND "+zielTabelle+"."+zielAttribut+"="+auswahlherkunft+".ID ORDER BY "+auswahlherkunft+".Bezeichnung;");
      out.println("<table>");
      int i=0;
      boolean repeat = true;
      while (repeat) {
        out.println("<tr>");
        if (rs.next()) {
          out.println("<input type=\"hidden\" name =\""+datenfeld+"["+i+"]"+"_entryid\" value=\""+rs.getInt("ID")+"\">");
        } else {
          repeat = false;
        }

        if (repeat) {
          out.println("<input type=\"hidden\" name=\""+datenfeld+"["+i+"]\" value=\""+rs.getInt("value")+"\" />"); 
          out.println("<td>"+rs.getString(auswahlherkunft+".Bezeichnung")+"</td>");
          String href = "javascript:deleteEntry('"+zielTabelle+"', '"+rs.getInt(zielTabelle+".ID")+"', '"+returnpage+"', '"+id+"');";
          out.println("<td>");
          out.println("<a href=\""+href+"\">");
          out.println(txt_delete);
          out.println("</a>");
          out.println("</td>");
        }
        else {
          out.println("<td>");
          out.println("<select name=\""+datenfeld+"["+i+"]\">");
          st2 = cn.createStatement();
          rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");
          while ( rs2.next() ) {
            out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==-1?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
          }
          out.println("</select>");
          out.println("</td>");
          out.println("<td>&nbsp;</td><td><a href=\"javascript:popup('addselect', this, '"+auswahlherkunft.substring(10)+"', '"+datenfeld+"["+i+"]', '');\">"+txt_newentry+"</a></td>");
        }
        out.println("</tr>");
        i++;
      }
      out.println("</table>");
    } finally {
      try { if( null != rs2 ) rs2.close(); } catch( Exception ex ) {}
      try { if( null != st2 ) st2.close(); } catch( Exception ex ) {}
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
