<%
  if (true) {
    // Bedigungen
    String conditionsString = "";
    if (conditions.size() > 0) {
      conditionsString += conditions.firstElement();
      for (int i=1; i<conditions.size(); i++) {
        conditionsString += " AND "+conditions.get(i);
      }
    }
    else {
      conditionsString += "1";
    }

    // Ausgabefelder
    String fieldsString = "";
    if (fields.size() > 0) {
      fieldsString += fields.firstElement();
      for (int i=1; i<fields.size(); i++) {
        fieldsString += ", "+fields.get(i);
      }
    }
    else {
      fieldsString += "1";
    }

    // Tabellen
    String tablesString = "";
    if (tables.size() > 0) {
      tablesString += tables.firstElement();
      for (int i=1; i<tables.size(); i++) {
        tablesString += ", "+tables.get(i);
      }
    }
    else {
      tablesString += "1";
    }

    int linecount = 0;
    sql = "SELECT "+fieldsString+" FROM "+tablesString+" WHERE ("+conditionsString+") LIMIT "+(pageoffset*pageLimit)+", "+pageLimit;
    String countsql = "SELECT COUNT(*) c FROM "+tablesString+" WHERE ("+conditionsString+")";
    // " ORDER BY "+order+" "+orderdirection+" "+
    Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      rs = st.executeQuery(countsql);
      if ( rs.next() )
        linecount = rs.getInt("c");

      rs = st.executeQuery(sql);

      out.println("<table>");
      out.println("<tr>");
      for (int i=0; i<headlines.size(); i++) {
        out.println("<th>");
        out.println(headlines.get(i));
        out.println("</th>");
      }
      while ( rs.next() ) {
        out.println("<tr>");

        if (formular.equals("einzelbeleg"))
          out.println("<td valign=\"top\"><a href=\"einzelbeleg.jsp?ID="+rs.getString("einzelbeleg.ID")+"\">GoTo</a></td>");
        if (formular.equals("person"))
          out.println("<td valign=\"top\"><a href=\"person.jsp?ID="+rs.getString("person.ID")+"\">GoTo</a></td>");

        for(int i=1; i<fieldNames.size(); i++) {
          out.println("<td valign=\"top\">");
          if (rs.getString(fieldNames.get(i)) != null)
            out.println(rs.getString(fieldNames.get(i)).replace("<", "&lt;").replace(">", "&gt;"));
          out.println("</td>");
        }
        out.println("</tr>");
      }
      out.println("</tr>");
      out.println("</table>");

      // Seitennavigation
      out.println("<p align=\"center\">");
      int pages = (linecount / pageLimit)+1;
      for (int i=0; i< pages; i++) {
        String parameter = "?pageoffset="+i;
        for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements(); ) {
          String paramName = e.nextElement();
          if (!paramName.equals("pageoffset"))
            parameter += "&"+paramName+"="+request.getParameter(paramName);
        }
        out.println("<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;");
      }
      out.println("</p>");
    }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
  }
%>