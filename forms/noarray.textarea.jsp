<%
  if (feldtyp.equals("textarea") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
     if(!isReadOnly) out.print("<textarea name=\""+datenfeld+"\" "
                   +(cols>0?"cols=\""+cols+"\" ":"")
                   +(rows>0?"rows=\""+rows+"\" ":"")
                   +">");
        else out.print("<div>");
      if ( rs.next() ) {
        out.print((rs.getString(zielAttribut)!=null?DBtoHTML(rs.getString(zielAttribut)):""));
      }
       if(!isReadOnly) out.println("</textarea>");
       else out.println("</div>");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>