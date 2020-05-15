<%
  if (feldtyp.equals("textfield") && !array) {
    if(!isReadOnly){
       out.print("<input name=\""+datenfeld+"\" style=\"width: 250px\"");
       if(formular.endsWith("freie_suche"))out.print(" placeholder=\""+platzhalter+"\" ");
    }
    try {
      if (Integer.parseInt(id) > 0) {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
     
        rs = st.executeQuery("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if ( rs.next() && rs.getString(zielAttribut) != null) {
          if(!isReadOnly) {
        	  out.print("value=\""+DBtoHTML(rs.getString(zielAttribut))+"\" ");
          }
          else {
        	  String belegformHtml = DBtoHTML(format(rs.getString(zielAttribut), isKlarlemma? "Klarlemma" : ""));
        	  if(formular.equals("einzelbeleg") && datenfeld.equals("Belegform")) {
	        	  belegformHtml = getBelegformLinked(cn, id, belegformHtml);
          	  }
        	  out.println(belegformHtml);
          }
        }
        else if (def!=null){
          if(!isReadOnly)out.print("value=\""+def+"\" ");
          else out.println(format(def, isKlarlemma? "Klarlemma" : ""));
        }
      }
      if (zielAttribut != null) {
        if(!isReadOnly) out.println((size>0?"size=\""+size+"\" ":"")
                    +"maxlength=\""+rs.getMetaData().getColumnDisplaySize(rs.findColumn(zielAttribut))+"\" ");
      }
      
    }
    catch (Exception e) { }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    if(!isReadOnly)out.println(">");
         if(!tooltip.equals(""))  out.println("<a href=\"javascript:return false;\" style=\"text-decoration:none;color:gray;\" title=\""+tooltip+"\"> ? </a>");
    
  }
%>
