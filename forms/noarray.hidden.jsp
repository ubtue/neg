<%
  if (feldtyp.equals("hidden") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
      out.print("<input type='hidden' name=\""+datenfeld+"\" ");
      if ( rs.next() && rs.getString(zielAttribut) != null) {
        out.print("value=\""+rs.getString(zielAttribut)+"\" ");
      }
      out.println(" />");
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>