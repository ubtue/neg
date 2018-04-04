<%
  if (feldtyp.startsWith("link") && !array) {
        String[] fields = feldtyp.substring(feldtyp.lastIndexOf('(')+1, feldtyp.lastIndexOf(')')).split(",");
    try {
   Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
    //  out.println("SELECT * FROM "+zielTabelle+" WHERE "+formularAttribut+"=\""+id+"\"");
            rs = st.executeQuery("SELECT * FROM "+zielTabelle+" WHERE "+formularAttribut+"=\""+id+"\"");
           if(rs.next()){
      Statement st2 = cn.createStatement();
             ResultSet rs2 = st2.executeQuery("SELECT "+fields[2]+" FROM "+fields[0]+" WHERE ID="+rs.getInt(fields[1])+";");
             if(rs2.next())  {
            	 out.println("<a href=\""+fields[0]+".jsp?ID="+rs.getInt(fields[1])+"\">"+(rs2.getString(fields[2])!=null?DBtoHTML(rs2.getString(fields[2])):"Zum Datensatz")+"</a>");
             }

      }
    } finally {
      try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
      try { if( null != st ) st.close(); } catch( Exception ex ) {}
      try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
    }
%>