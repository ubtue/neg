<%@ page import="de.uni_tuebingen.ub.nppm.db.*" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>

<%@ include file="functions.jsp" %>

<%
  String formular = request.getParameter("Formular");
  String datenfeld = request.getParameter("Datenfeld");

  List<Map> rowlist = DatenbankDB.getMappedList("SELECT * FROM "+formular+" ORDER BY Bezeichnung ASC");

  out.println("<select name=\""+datenfeld+"\">");
  out.println("<option value=\"-99\" selected>---</option>");
  for (Map row : rowlist) {
    out.println("<option value=\""+row.get("ID").toString()+"\">"+DBtoHTML(row.get("Bezeichnung").toString())+"</option>");
  }
  out.println("</select>");
%>
