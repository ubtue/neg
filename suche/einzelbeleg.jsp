<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");
  int pageoffset = 0;
  if (request.getParameter("pageoffset") != null) {
    pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
  }
  String sql = "";

  Vector<String> conditions = new Vector<String> ();

  Vector<String> fields = new Vector<String> ();
  Vector<String> fieldNames = new Vector<String> ();

  Vector<String> tables = new Vector <String> ();
  Vector<String> joins = new Vector <String> ();

  Vector<String> headlines = new Vector<String> ();

  String order = request.getParameter("order");
  String orderdirection = "ASC";

  if (formular.equals("einzelbeleg")) {
    // Bedingungen
    if (!request.getParameter("Belegnummer").equals("")) {
      conditions.add("einzelbeleg.Belegnummer LIKE \""+request.getParameter("Belegnummer")+"\"");
    }

    if (!request.getParameter("PKZ").equals("")) {
      tables.add("person");
      tables.add("einzelbeleg_hatperson");
      conditions.add("einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID");
      conditions.add("einzelbeleg_hatperson.PersonID = person.ID");
      conditions.add("person.PKZ LIKE \""+request.getParameter("PKZ")+"\"");
    }

    if (!request.getParameter("Belegform").equals("")) {
      conditions.add("Belegform LIKE \""+request.getParameter("Belegform")+"\"");
    }

    // Ausgabfelder
    headlines.add("Link");
    fields.add("einzelbeleg.ID ID");
    fieldNames.add("ID");

    headlines.add("Belegnummer");
    fields.add("Belegnummer");
    fieldNames.add("Belegnummer");
    tables.add("einzelbeleg");
    order = "einzelbeleg.ID";

    if (request.getParameter("AusgabeBelegform") != null && request.getParameter("AusgabeBelegform").equals("on")) {
      fields.add("Belegform");
      fieldNames.add("Belegform");
      headlines.add("Belegform");
    }

    if (request.getParameter("AusgabePKZ") != null && request.getParameter("AusgabePKZ").equals("on")) {
      if (!tables.contains("person")) {
        tables.add("person");
        tables.add("einzelbeleg_hatperson");
        conditions.add("einzelbeleg.ID = einzelbeleg_hatperson.EinzelbelegID");
        conditions.add("einzelbeleg_hatperson.PersonID = person.ID");
      }
      fields.add("PKZ");
      fieldNames.add("PKZ");
      headlines.add("PKZ");
    }

    if (request.getParameter("AusgabeKapitel") != null && request.getParameter("AusgabeKapitel").equals("on")) {
      fields.add("EditionKapitel");
      fieldNames.add("EditionKapitel");
      headlines.add("Kapitel");
    }

    if (request.getParameter("AusgabeSeite") != null && request.getParameter("AusgabeSeite").equals("on")) {
      fields.add("EditionSeite");
      fieldNames.add("EditionSeite");
      headlines.add("Seite");
    }

    if (request.getParameter("AusgabeKontext") != null && request.getParameter("AusgabeKontext").equals("on")) {
      fields.add("Kontext");
      fieldNames.add("Kontext");
      headlines.add("Kontext");
    }

    if (request.getParameter("AusgabeAreal") != null && request.getParameter("AusgabeAreal").equals("on")) {
      fields.add("selektion_areal.Bezeichnung Areal");
      fieldNames.add("Areal");
      headlines.add("Areal");
      if (!tables.contains("selektion_areal"))
        tables.add("selektion_areal");
      if (!tables.contains("einzelbeleg_hatareal"))
        tables.add("einzelbeleg_hatareal");
      conditions.add("einzelbeleg.ID = einzelbeleg_hatareal.EinzelbelegID AND einzelbeleg_hatareal.ArealID = selektion_areal.ID");
    }

    if (request.getParameter("AusgabeVerwandtschaft") != null && request.getParameter("AusgabeVerwandtschaft").equals("on")) {
      fields.add("KommentarVerwandtschaft");
      fieldNames.add("KommentarVerwandtschaft");
      headlines.add("Verwandtschaft");
    }

    if (request.getParameter("AusgabeFunktion") != null && request.getParameter("AusgabeFunktion").equals("on")) {
      fields.add("selektion_funktion.Bezeichnung Funktion");
      fieldNames.add("Funktion");
      headlines.add("Funktion");
      if (!tables.contains("selektion_funktion"))
        tables.add("selektion_funktion");
      if (!tables.contains("einzelbeleg_hatfunktion"))
        tables.add("einzelbeleg_hatfunktion");
      conditions.add("einzelbeleg.ID = einzelbeleg_hatfunktion.EinzelbelegID AND einzelbeleg_hatfunktion.FunktionID = selektion_funktion.ID");
    }

  }
%>
<%@ include file="ergebnisliste.jsp" %>