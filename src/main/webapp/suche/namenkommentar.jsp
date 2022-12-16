<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

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
  

  Vector<String> conditions = new Vector<String> ();

  Vector<String> fields = new Vector<String> ();
  Vector<String> fieldNames = new Vector<String> ();

  Vector<String> tables = new Vector <String> ();
  Vector<String> joins = new Vector <String> ();

  Vector<String> headlines = new Vector<String> ();

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
      tableString += tables.firstElement();
      for (int i=1; i<tables.size(); i++) {
        tableString += ", "+tables.get(i);
      }
    }
  }
%>

<%@ include file="ergebnisliste.jsp" %>
