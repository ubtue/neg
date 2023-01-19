<%

//	out.println(orderV[0]);

  if (true) {
    conditions = removeDuplicates(conditions);
    fields = removeDuplicates(fields);
    tables = removeDuplicates(tables);

    joins = removeDuplicates(joins);



    // Bedingungen
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

    // Tabellen
    String tablesString = "";
    if (tables.size() > 0) {
      tablesString += tables.firstElement();
      for (int i=1; i<tables.size(); i++) {
        tablesString += ", "+tables.get(i);
      }
    }

    // Joins
    String joinsString = "";
    if (joins.size() > 0) {
      joinsString += joins.firstElement();
      for (int i=1; i<joins.size(); i++) {
        joinsString += " "+joins.get(i);
      }
    }

    Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;

    tablesString = tableString;
    try {
      int pageoffset = 0;
      if (request.getParameter("pageoffset") != null) {
        pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
      }

      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

	  if(fields.size()==0){
	  	out.println("Bitte wÃ¤hlen Sie mind. ein Ausgabefeld aus (Schritt 2).");
	  	return;
	  }


      String sql = "SELECT "+fieldsString+" FROM "+tablesString+" WHERE ("+conditionsString+")"; // GROUP BY "+fieldsString;
      rs = st.executeQuery(sql);
      rs.last();
      int linecount = rs.getRow();


      sql = "SELECT "+fieldsString+" FROM "+tablesString+" WHERE ("+conditionsString+") "+order; //GROUP BY "+fieldsString+"
      if (export.equals("liste") || export.equals("browse"))
        sql += " LIMIT "+(pageoffset*pageLimit)+", "+pageLimit;
      //out.println(sql);
      rs = st.executeQuery(sql);


      out.println("<h3>Gesamte Treffer: "+linecount+"</h3>");


      %>

      <%

      // ########## LISTE/BROWSE ##########
      if (export.equals("liste") || export.equals("browse")) {
      String oldValue [] = new String [5];

        out.println("<table id=\"namen-insgesamt\" class=\"resultlist content-table\">");
        out.println("<tr>");
        for (int i=0; i<headlines.size(); i++) {
          out.println("<th class=\"resultlist\">");
          // Link fÃ¼r Seite erzeugen
          String direction = "";
          if (order.contains(fieldNames.get(i))) {
            direction = order.substring(order.indexOf(fieldNames.get(i)+" ")+fieldNames.get(i).length()+1, min(order.length(), order.indexOf(fieldNames.get(i)+" ")+fieldNames.get(i).length()+5));
            if (direction.contains("DESC")) {
              direction = "DESC";
            }
            else {
              direction = "ASC";
            }
          }

          String parameter = "?neworder="+fieldNames.get(i);
          if (direction.equals("ASC"))
            parameter += "&newdirection=DESC";
          else
            parameter += "&newdirection=ASC";

          for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements(); ) {
            String paramName = e.nextElement();
            if (!paramName.contains("order") && !paramName.equals("newdirection"))
              parameter += "&"+paramName+"="+urlEncode(request.getParameter(paramName));
          }

          out.print("<a href=\""+parameter+"\">");
          out.print(headlines.get(i));
          if (direction.equals("ASC"))
            out.print("<img src='layout/icons/arrowup.gif'>");
          else if (direction.equals("DESC"))
            out.print("<img src='layout/icons/arrowdown.gif'>");
          out.println("</a>");
          out.println("</th>");
        }
        boolean even = false;

        while ( rs.next() ) {

    //    if(!rs.getString(orderV[0]).equals(oldValue[0])) out.println();

          out.println("<tr class=\""+(even?"":"un")+"even\">");
          if (!formular.equals("favorit") && !formular.equals("freie_suche")&&  !formular.equals("mgh_lemma") &&!formular.equals("namenkommentar")&& !formular.equals("literatur")) {
            out.println("<td class=\"resultlist\" valign=\"top\" align=\"center\"><a href=\""+formular+".jsp?ID="+rs.getString(formular+".ID")+"\">Gehe zu</a></td>");
          }

          for(int i=0; i<fieldNames.size(); i++) {
            out.println("<td class=\"resultlist\" valign=\"top\">");
            if (rs.getString(fieldNames.get(i)) != null && !DBtoHTML(rs.getString(fieldNames.get(i))).equals("")) {
              String cell =  DBtoHTML(rs.getString(fieldNames.get(i)));
              if (export.equals("browse")) {
                boolean link = false;
                if (fieldNames.get(i).contains("einzelbeleg.Belegform")) {
                  out.print("<a href=\"einzelbeleg?ID="+rs.getInt("einzelbeleg.ID")+"\">");
                  link = true;
                }
                else if (fieldNames.get(i).contains("person.Standardname")) {
                  out.print("<a href=\"person?ID="+rs.getInt("person.ID")+"\">");
                  link = true;
                }
                else if (fieldNames.get(i).contains("perszu.Standardname")) {
                  out.print("<a href=\"person?ID="+rs.getInt("perszu.ID")+"\">");
                  link = true;
                }
                else if (fieldNames.get(i).contains("namenkommentar.PLemma")) {
                  out.print("<a href=\"namenkommentar?ID="+rs.getInt("namenkommentar.ID")+"\">");
                  link = true;
                }
                else if (fieldNames.get(i).contains("quelle.Bezeichnung")) {
                  out.print("<a href=\"quelle.jsp?ID="+rs.getInt("quelle.ID")+"\">");
                  link = true;
                }
                else if (fieldNames.get(i).contains("edition.Titel")) {
                  try{
                  out.print("<a href=\"edition?ID="+rs.getInt("edition.ID")+"\">");
                  link = true;
                  }catch(Exception e){
                     link=false;
                  }
                }
                else if (fieldNames.get(i).contains("ID")) {
            out.println("<a href=\""+formular+".jsp?ID="+rs.getString(formular+".ID")+"\">Gehe zu: ");
                              link = true;
                }
                out.print(cell);
                if (link) {
                  out.println("</a>");
                }
              }
              else
                out.println(cell);
            }
            else
              out.println("&nbsp;");
            out.println("</td>");
          }
          out.println("</tr>");
          even = !even;
        }
        out.println("</tr>");
        out.println("</table>");
      }
      // ########## LISTE/BROWSE #########

      // ########## EXCEL #########
      if (export.equals("excel")) {
        PrintWriter excel = new PrintWriter(new FileWriter(this.getServletContext().getRealPath("/")+"print\\output_"+session.getAttribute("Benutzername")+".csv"));
        for (int i=0; i<headlines.size(); i++) {
          excel.print("\""+headlines.get(i)+"\";");
        }
        excel.println();
        while ( rs.next() ) {
          for(int i=0; i<fieldNames.size(); i++) {
            if (rs.getString(fieldNames.get(i)) == null || rs.getString(fieldNames.get(i)).equals("null"))
              excel.print("\"\";");
            else
              excel.print("\""+rs.getString(fieldNames.get(i))+"\";");
          }
          excel.println();
        }
        excel.close();
        out.println("<a href='../../print/output_"+session.getAttribute("Benutzername")+".csv'>herunterladen</a>");
      }
      // ########## EXCEL #########


      // ########## SEITENNAVIGATION #########
      if (export.equals("liste") || export.equals("browse")) {
        out.println("<p class=\"resultlistnavigation\" align=\"center\">");
        int pages = (linecount / pageLimit)+1;
        for (int i=0; i< pages; i++) {
          // Link fÃ¼r Seite erzeugen
          String parameter = "?pageoffset="+i;
          for (Enumeration<String> e = request.getParameterNames(); e.hasMoreElements(); ) {
            String paramName = e.nextElement();
            if (!paramName.equals("pageoffset"))
              parameter += "&"+paramName+"="+urlEncode(request.getParameter(paramName));
          }

          // Link zur ersten Seite anzeigen falls nÃ¶tig
          if (i ==  0 && i <= pageoffset - 10) {
            out.println("<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;...&nbsp;");
          }

          // gelinkte Seitennummer anzeigen
          if (i < pageoffset + 10 && i > pageoffset - 10) {
            if (i==pageoffset) {
              out.println("<b>");
            }
            out.println("<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;");
            if (i==pageoffset) {
              out.println("</b>");
            }
          }
          // Link zur letzten Seite anzeigen falls nÃ¶tig
          if (i ==  pages-1 && i >= pageoffset + 10) {
            out.println("...&nbsp;<a href=\""+parameter+"\">"+(i+1)+"</a>&nbsp;");
          }
        }
        out.println("</p>");
      }
      // ########## SEITENNAVIGATION #########
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
