<%
  if (feldtyp.equals("extref") && !array) {
    try {
      if (Integer.parseInt(id) > 0) {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
     
        rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if ( rs.next() && rs.getString(zielAttribut) != null && !rs.getString(zielAttribut).trim().equals("")) {
           out.println("<a href=\""+rs.getString(zielAttribut)+"\" target=\"_new\">Zum Eintrag...</a>");
        }
      }
    }
    catch (Exception e) { }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>