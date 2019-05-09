<%
  if (feldtyp.startsWith("search") && !array) {
    String[] fields = feldtyp.substring(feldtyp.lastIndexOf('(')+1, feldtyp.lastIndexOf(')')).split(",");
    out.println("<a href=\"javascript:popup('search', this, '"+fields[0]+"', '"+fields[2]+"', '"+fields[1]+"');\">"+txt_search+"</a>");
  }
%>
