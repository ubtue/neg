<%
  if (feldtyp.equals("date") && !array) {
    out.println("<table>\n");
    out.println("<tr>\n");
    for (int i=0; i<combinedAnzeigenamen.length; i++) {
     if(!isReadOnly) out.println("<th width=\"90\">"+combinedAnzeigenamen[i]+"</th>\n");
    }
    out.println("</tr>\n");

    String[] zielattributArray = zielAttribut.split(";");
    for (int i=0; i<zielattributArray.length; i++) {
      zielattributArray[i] = zielattributArray[i].trim();
    }

    String[] auswahlherkunftArray = auswahlherkunft.split(";");
    for (int i=0; i<auswahlherkunftArray.length; i++) {
      auswahlherkunftArray[i] = auswahlherkunftArray[i].trim();
    }

    try {
      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      String zielattribute = "Genauigkeit"+zielattributArray[0] + ", "+zielattributArray[0];
      for (int i=1; i<zielattributArray.length; i++) {
      	zielattribute += ", Genauigkeit"+zielattributArray[i] + ", "+zielattributArray[i];
      }
      rs = st.executeQuery("SELECT "+zielattribute+" FROM "+zielTabelle+" WHERE ID ='"+id+"'");
      Statement st2 = cn.createStatement();
      ResultSet rs2 = st2.executeQuery("SELECT * FROM "+auswahlherkunft + " ORDER by Bezeichnung");
      out.println("<tr>");
      boolean next = false;

      if(rs.next()) {
		boolean empty = true;
        for (int j=0; j<combinedFeldnamen.length; j++) {
          if ((rs.getInt(1+2*j)!=-1) || (rs.getString(1+2*j+1)!=null && !rs.getString(1+2*j+1).equals("0"))){
              empty=false;
              break;
           }
        }
        if(empty && defaultValues!=null){
           rs = st.executeQuery(defaultValues[0].replaceAll("%id%",id));
           next = rs.next();
        }
        for (int j=0; j<combinedFeldnamen.length; j++) {
          out.println("<td>");
          int selected = -1;
          if((!empty || next) && rs.getString(1+j*2)!=null)selected = rs.getInt(1+j*2);
          if(!isReadOnly){
            out.println("<select name=\"Genauigkeit"+combinedFeldnamen[j]+"\">");
            out.println("<option value=\"-1\">nicht bearbeitet</option>");
          }

          while ( rs2.next() ) {
            if(!isReadOnly) out.println("<option value=\""+rs2.getInt("ID")+"\" "+(rs2.getInt("ID")==selected?"selected":"")+">"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
            else if (rs2.getInt("ID")==selected){
              String bez = rs2.getString("Bezeichnung");
              if(!bez.equals("--")) out.println(DBtoHTML(bez));
            }
          }
          if(!isReadOnly) out.println("</select>");
          rs2.beforeFirst();

          if(!isReadOnly)  out.println("<input name=\""+combinedFeldnamen[j]+"\""
                      +" value=\""+((!empty || next) && rs.getString(2*j+2)!=null?rs.getString(2*j+2):"")+"\""
                      +" size=\"10\""
                      + " " + (j==2?"onblur=\"javascript:makeCentury('" + combinedFeldnamen[j] +"', '" + combinedFeldnamen[j+1] +"')\"":"")
                      +" />");
          else out.println(((!empty || next) && rs.getString(2*j+2)!=null?rs.getString(2*j+2):""));
          out.println("</td>");
        }
      }
      else {
        for (int j=0; j<combinedFeldnamen.length; j++) {
          out.println("<td>");
          if(!isReadOnly){ 
            out.println("<select name=\"Genauigkeit"+combinedFeldnamen[j]+"\">");
            out.println("<option value=\"-1\">nicht bearbeitet</option>");
          }
          
          while ( rs2.next() ) {
            if(!isReadOnly) out.println("<option value=\""+rs2.getInt("ID")+"\" >"+DBtoHTML(rs2.getString("Bezeichnung"))+"</option>");
          }
          if(!isReadOnly)out.println("</select>");
          rs2.beforeFirst();
          if(!isReadOnly) out.println("<input name=\""+combinedFeldnamen[j]+"\""
                      +" value=\""+"\""
                      +" maxlength=\""+rs.getMetaData().getColumnDisplaySize(rs.findColumn(zielattributArray[j]))+"\" "
                      +" size=\"10\""
                      + " " + (j==2?"onblur=\"javascript:makeCentury('" + combinedFeldnamen[j] +"', '" + combinedFeldnamen[j+1] +"')\"":"")
                      +" >");
          out.println("</td>");
        }
      }        
      out.println("</tr>");
    }
    catch (Exception e) {out.println(e); }
    finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    out.println("</table>\n");
  }
%>