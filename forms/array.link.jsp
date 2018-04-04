<%
  if (feldtyp.startsWith("link") && array) {
  
        String[] fields = feldtyp.substring(feldtyp.lastIndexOf('(')+1, feldtyp.lastIndexOf(')')).split(",");
     try {
   Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
    //  out.println("SELECT * FROM "+zielTabelle+" WHERE "+formularAttribut+"=\""+id+"\"");
            rs = st.executeQuery("SELECT * FROM "+zielTabelle+" WHERE "+formularAttribut+"=\""+id+"\"");
           while(rs.next()){
      Statement st2 = cn.createStatement();
    //  out.println("SELECT "+fields[2]+" FROM "+fields[0]+" WHERE tab.ID="+rs.getInt(fields[1])+";");
             ResultSet rs2 = st2.executeQuery("SELECT "+fields[2]+" FROM "+fields[0]+" WHERE tab.ID="+rs.getInt(fields[1])+";");
             if(rs2.next()) {
               	 String bez = format(rs2.getString(fields[2]),fields[2]);
            	 if(bez==null) bez = "Zum Datensatz";
            	 else if(!fields[2].startsWith("PLemma")) bez = DBtoHTML(bez);
            	 
            	 String add = fields[3];
 
            	 out.println("<a href=\""+add+".jsp?ID="+rs.getInt(fields[1])+"\">"+bez+"</a><br>");
             }

      }
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    }
%>