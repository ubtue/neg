<%
  if (feldtyp.equals("button") && !array) {
    out.print("<input type='button' value=\""+beschriftung+"\" ");
    out.print("onClick=\""+buttonAktion+"\" ");
    out.println(" />");
  }
%>