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

  if (formular.equals("favorit")) {
    // Tabellen
    tables.add("person");
    tables.add("einzelbeleg_hatperson");
    tables.add("einzelbeleg");
    tables.add("einzelbeleg_textkritik");
    tables.add("handschrift_ueberlieferung");
    tables.add("selektion_ort");

    // Bedingungen
    conditions.add("person.ID = 21812");
    conditions.add("einzelbeleg_hatperson.EinzelbelegID = einzelbeleg.ID");
    conditions.add("person.ID = einzelbeleg_hatperson.PersonID");
    conditions.add("einzelbeleg.ID = einzelbeleg_textkritik.EinzelbelegID");
    conditions.add("einzelbeleg_textkritik.HandschriftID = handschrift_ueberlieferung.ID");
    conditions.add("handschrift_ueberlieferung.Schriftheimat = selektion_ort.ID");

    // Ausgabfelder
    headlines.add("Standardname");
    fields.add("person.Standardname");
    fieldNames.add("person.Standardname");

    headlines.add("Belegform");
    fields.add("einzelbeleg.Belegform");
    fieldNames.add("einzelbeleg.Belegform");

    headlines.add("Beleg-Nr.");
    fields.add("einzelbeleg.Belegnummer");
    fieldNames.add("einzelbeleg.Belegnummer");

    headlines.add("Variante");
    fields.add("einzelbeleg_textkritik.Variante");
    fieldNames.add("einzelbeleg_textkritik.Variante");

    headlines.add("Schriftheimat");
    fields.add("selektion_ort.Bezeichnung");
    fieldNames.add("selektion_ort.Bezeichnung");
  }
%>

<%@ include file="ergebnisliste.jsp" %>