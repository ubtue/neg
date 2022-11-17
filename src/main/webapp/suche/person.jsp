<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");

  Vector<String> conditions = new Vector<String> ();

  Vector<String> fields = new Vector<String> ();
  Vector<String> fieldNames = new Vector<String> ();

  Vector<String> tables = new Vector <String> ();
  Vector<String> joins = new Vector <String> ();

  Vector<String> headlines = new Vector<String> ();

  String order = request.getParameter("order");
  String orderdirection = "ASC";

  if (formular.equals("person")) {

    // Bedingungen
    if (!request.getParameter("PKZ").equals("")) {
      conditions.add("PKZ LIKE \""+request.getParameter("PKZ")+"\"");
    }

    if (!request.getParameter("Person").equals("")) {
      conditions.add("Standardname LIKE \""+request.getParameter("Person")+"\"");
    }

    if (!request.getParameter("Stand").equals("-99")) {
      tables.add("person_hatstand");
      conditions.add("person_hatstand.PersonID = person.ID AND person_hatstand.StandID=\""+request.getParameter("Stand")+"\"");
    }

    if (!request.getParameter("Ethnie").equals("-99")) {
      tables.add("person_hatethnie");
      conditions.add("person_hatethnie.PersonID = person.ID AND person_hatethnie.EthnieID=\""+request.getParameter("Ethnie")+"\"");
    }

    if (!request.getParameter("Geschlecht").equals("-99")) {
      conditions.add("Geschlecht=\""+request.getParameter("Geschlecht")+"\"");
    }

    // Ausgabfelder
    headlines.add("Link");
    fields.add("person.ID ID");
    fieldNames.add("ID");

    headlines.add("PKZ");
    fields.add("PKZ");
    fieldNames.add("PKZ");
    tables.add("person");
    order = "person.ID";

    if (request.getParameter("AusgabePerson") != null && request.getParameter("AusgabePerson").equals("on")) {
      fields.add("Standardname");
      fieldNames.add("Standardname");
      headlines.add("Person");
    }

    if (request.getParameter("AusgabeStand") != null && request.getParameter("AusgabeStand").equals("on")) {
      if (!tables.contains("person_hatstand"))
        tables.add("person_hatstand");
      if (!tables.contains("selektion_stand"))
        tables.add("selektion_stand");
      conditions.add("person_hatstand.StandID = selektion_stand.ID");
      conditions.add("person.ID = person_hatstand.PersonID");

      fields.add("selektion_stand.Bezeichnung Stand");
      fieldNames.add("Stand");
      headlines.add("Stand");
    }

    if (request.getParameter("AusgabeEthnie") != null && request.getParameter("AusgabeEthnie").equals("on")) {
      if (!tables.contains("person_hatethnie"))
        tables.add("person_hatethnie");
      if (!tables.contains("selektion_ethnie"))
        tables.add("selektion_ethnie");
      conditions.add("person_hatethnie.EthnieID = selektion_ethnie.ID");
      conditions.add("person.ID = person_hatethnie.PersonID");
//      joins.add("LEFT OUTER JOIN person_hatethnie ON person.ID = person_hatethnie.PersonID");

      fields.add("selektion_ethnie.Bezeichnung Ethnie");
      fieldNames.add("Ethnie");
      headlines.add("Ethnie");
    }

    if (request.getParameter("AusgabeGeschlecht") != null && request.getParameter("AusgabeGeschlecht").equals("on")) {
      fields.add("selektion_geschlecht.Bezeichnung Geschlecht");
      fieldNames.add("Geschlecht");
      headlines.add("Geschlecht");
      if (!tables.contains("selektion_geschlecht"))
        tables.add("selektion_geschlecht");
      conditions.add("person.Geschlecht = selektion_geschlecht.ID");
    }

  }
%>

<%@ include file="ergebnisliste.jsp" %>
