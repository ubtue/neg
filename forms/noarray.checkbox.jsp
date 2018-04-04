<%
  if (feldtyp.equals("checkbox") && !array) {
    out.print("<input name=\""+datenfeld+"\" ");
    out.print("type=\"checkbox\"");
    if (zielAttribut != null && zielTabelle != null) {
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if ( rs.next() && rs.getString(zielAttribut) != null && rs.getInt(zielAttribut) == 1) {
          out.print(" checked ");
        }
        if(isReadOnly) out.print(" disabled ");
      } finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }
    out.println("/>");
  }
%>