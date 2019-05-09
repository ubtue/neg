<%
  if (feldtyp.equals("textfield") && array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT ID, "+zielAttribut+" FROM "+zielTabelle+" WHERE "+formular+"ID=\""+id+"\"");
      out.println("<table>");
      boolean repeat = true;
      int i=0;
      while(repeat) {
        out.println("<tr>");
        out.println("<td>");
       if(!isReadOnly) out.print("<input name=\""+datenfeld+"["+i+"]\" ");
        String hidden = "";
        if (rs.next()) {
          hidden = "<input type=\"hidden\" name =\""+datenfeld+"["+i+"]"+"_entryid\" value=\""+rs.getInt("ID")+"\">";
          if(!isReadOnly)out.print("value=\"");
          out.print(DBtoHTML(rs.getString(zielAttribut)));
          if(!isReadOnly)out.println("\" ");
        } else {
          repeat = false;
        }
        if(!isReadOnly)out.println((size>0?"size=\""+size+"\" ":"")
                    +"maxlength=\""+rs.getMetaData().getColumnDisplaySize(rs.findColumn(zielAttribut))+"\" "
                    +"/>");
        if(!isReadOnly)out.println(hidden);
        out.println("</td>");
        if (repeat) {
          String href = "javascript:deleteEntry('"+zielTabelle+"', '"+rs.getInt("ID")+"', '"+returnpage+"', '"+id+"');";
         out.println("<td>");
         if(!isReadOnly){ out.println("<a href=\""+href+"\">");
          out.println(txt_delete);
          out.println("</a>");
          }
          out.println("</td>");
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
