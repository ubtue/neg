<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%
  if (feldtyp.equals("select") && array) {

      List<Map> rowlist = AbstractBase.getMappedList("SELECT ID, " + zielAttribut
                                                   + " FROM " + zielTabelle
                                                   + " WHERE " + formular + "ID='" + id + "'"
                                                   + " ORDER BY ID ASC");

      out.println("<table>");
      boolean repeat = true;
      int i = 0;
      while (repeat) {
        Map row = null;

        int selected = -1;
        if (rowlist.size() > i) {
          row = rowlist.get(i);
          selected = Integer.parseInt(row.get(zielAttribut).toString());
          out.println("<input type=\"hidden\" name =\""+datenfeld+"["+i+"]"+"_entryid\" value=\""+row.get("ID").toString()+"\">");
        }
        else {
          repeat = false;
        }

        out.println("<tr>");
        out.println("<td>");

        if(!isReadOnly)out.println("<select name='"+datenfeld+"["+i+"]'>");
          List<Map> rowlist2 = AbstractBase.getMappedList("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");
          for (Map row2 : rowlist2) {
            if(!isReadOnly)out.println("<option value='"+row2.get("ID").toString()+"' "+(Integer.parseInt(row2.get("ID").toString())==selected?"selected":"")+">"+DBtoHTML(row2.get("Bezeichnung").toString())+"</option>");
            else if (repeat && Integer.parseInt(row2.get("ID").toString())==selected) out.println(DBtoHTML(row2.get("Bezeichnung").toString()));
          }
       if(!isReadOnly) out.println("</select>");
        out.println("</td>");
        if (repeat) {
          String href = "javascript:deleteEntry('"+zielTabelle+"', '"+row.get("ID").toString() +"', '"+returnpage+"', '"+id+"');";
          out.println("<td>");
          if(!isReadOnly){
            out.println("<a href=\""+href+"\">");
            out.println(txt_delete);
            out.println("</a>");
          }
          out.println("</td>");
        }
        out.println("</tr>");
        i++;
      }
      out.println("</table>");
  }
%>
