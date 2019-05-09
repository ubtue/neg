<%
  if (feldtyp.equals("generator") && !array) {
    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();

      String sql = "";
      sql = "SELECT " + zielAttribut
            +" FROM " + zielTabelle
            +" WHERE "+zielAttribut
            +" LIKE '"+numberResize(((Integer) session.getAttribute("GruppeID")).intValue(), 2) + numberResize(((Integer) session.getAttribute("BenutzerID")).intValue(), 2)+"%'"
            +" ORDER BY "+zielAttribut+" DESC";

      rs = st.executeQuery(sql);
      if (rs.next()) {
        String newNumber = rs.getString(zielAttribut).substring(4);
        newNumber = numberResize(((Integer) session.getAttribute("GruppeID")).intValue(), 2) + numberResize(((Integer) session.getAttribute("BenutzerID")).intValue(), 2) + numberResize(Integer.parseInt(newNumber)+1, 5);
        out.println("<input type=\"button\" value=\"generieren"+newNumber+"\" onClick=\"javascript:\"/>");
      }
    }
    catch (Exception e) {
      out.println(e);
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>
