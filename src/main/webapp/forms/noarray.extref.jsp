<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>

<%
  if (feldtyp.equals("extref") && !array) {

      if (Integer.parseInt(id) > 0) {
        String value_zielAttribut = AbstractBase.getStringNative("SELECT "+zielAttribut+" FROM "+zielTabelle+" WHERE ID=\""+id+"\"");
        if (value_zielAttribut != null && !value_zielAttribut.trim().equals("")) {
           out.println("<a href=\""+value_zielAttribut+"\" target=\"_new\">Zum Eintrag...</a>");
        }
      }

  }
%>
