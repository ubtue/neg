<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%
  if (feldtyp.equals("select") && array) {

      List<Map> rowlist = AbstractBase.getMappedList("SELECT ID, " + zielAttribut
                                                   + " FROM " + zielTabelle
                                                   + " WHERE " + formular + "ID='" + id + "'"
                                                   + " ORDER BY ID ASC");

      out.println("<table class=\"ut-table ut-table--striped ut-table--striped--color-primary-3\">");
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

        out.println("<tr class=\"ut-table__row\">");
        out.println("<td class=\"ut-table__item ut-table__body__item\">");


          List<Map> rowlist2 = AbstractBase.getMappedList("SELECT * FROM "+auswahlherkunft+" ORDER BY Bezeichnung ASC");

          for (Map row2 : rowlist2) {
            if (repeat && Integer.parseInt(row2.get("ID").toString())==selected) out.println(DBtoHTML(row2.get("Bezeichnung").toString()));
          }

        out.println("</td>");
        out.println("</tr>");
        i++;
      }
      out.println("</table>");
  }
%>
