<%@ page import="java.util.ArrayList" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");
//  int pageoffset = 0;
//  if (request.getParameter("pageoffset") != null) {
//    pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
//  }
//  String sql = "";

    String tableString = "";
  String export = "browse";
    String order = "";
  if (request.getParameter("neworder") != null) {
    order = "ORDER BY "+request.getParameter("neworder")+" ";
    if (request.getParameter("newdirection") != null) {
      order +=request.getParameter("newdirection");
    }
    else
      order += "ASC";
  }


  List<String> conditions = new ArrayList<>();

  List<String> fields = new ArrayList<>();
  List<String> fieldNames = new ArrayList<>();

  List<String> tables = new ArrayList<>();
  List<String> joins = new ArrayList<>();

  List<String> headlines = new ArrayList<>();

  if(request.getParameter("order")!=null) order = request.getParameter("order");
  String orderdirection = "ASC";

  if (formular.equals("namenkommentar")) {

    // Bedingungen
    if (!request.getParameter("Zwischenlemma").equals("")) {
      conditions.add("PLemma LIKE \""+request.getParameter("Zwischenlemma")+"\"");
    }

    // Ausgabfelder
    fields.add("namenkommentar.ID AS namenkommentarID");
    fieldNames.add("namenkommentarID");
    headlines.add("ID");

    fields.add("PLemma");
    fieldNames.add("PLemma");
    headlines.add("Zwischenlemma");

    tables.add("namenkommentar");

    if (request.getParameter("AusgabeNamenelement") != null && request.getParameter("AusgabeNamenelement").equals("on")) {
      fields.add("Suffix");
      fieldNames.add("Suffix");
      headlines.add("Namenelement");
    }

        // Tabellen
    tableString = "";
    if (tables.size() > 0) {
      tableString += tables.get(0);
      for (int i=1; i<tables.size(); i++) {
        tableString += ", "+tables.get(i);
      }
    }
  }
%>

<%@ include file="ergebnisliste.jsp" %>
