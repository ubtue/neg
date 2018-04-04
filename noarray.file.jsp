<%
  if (feldtyp.equals("file") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT ID, "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
      if ( rs.next() && rs.getString(zielAttribut) != null) {
        String folder = "";
      if (zielTabelle.equals("person"))
          folder = "personenkommentar";
          else if (zielTabelle.equals("namenkommentar"))
          folder = "namenkommentar";
       /* else if (zielTabelle.equals("quelle") && zielAttribut.equals("QuellenKommentarDatei"))
          folder = commentFolder_quellenkommentar;
        else if (zielTabelle.equals("quelle") && zielAttribut.equals("UeberlieferungsKommentarDatei"))
          folder = commentFolder_ueberlieferungskommentar;
     */   String href = "javascript:deleteFile('"+zielTabelle+"', '"+zielAttribut+"', '"+rs.getString("ID")+"', '"+returnpage+"');";
        out.println("<a href='"+folder+"/"+rs.getString(zielAttribut)+"'>"+rs.getString(zielAttribut)+"</a>");
        out.println("<a href=\""+href+"\">");
        out.println(txt_delete);
        out.println("</a>");
      }
      else {
      //  out.print("<div id=\"upload\"><input type=\"button\" value=\"Hochladen\" onClick=\"javascript:uploadFile(window, '"+zielTabelle+"', '"+zielAttribut+"','"+rs.getString("ID")+"');\"></div>");
      }
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>