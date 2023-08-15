<%@ page import="java.util.ArrayList" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.List" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");
  int pageoffset = 0;
  if (request.getParameter("pageoffset") != null) {
    pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
  }
  String sql = "";

  List<String> conditions = new ArrayList<>();

  List<String> fields = new ArrayList<>();
  List<String> fieldNames = new ArrayList<>();

  List<String> tables = new ArrayList<>();
  List<String> joins = new ArrayList<>();

  List<String> headlines = new ArrayList<>();

  String order = request.getParameter("order");
  String orderdirection = "ASC";

  if (formular.equals("quelle")) {

    // Bedingungen
    if (request.getParameter("Quelle") != null && !request.getParameter("Quelle").equals("")) {
      conditions.add("Bezeichnung LIKE \""+request.getParameter("Quelle")+"\"");
    }

    if (request.getParameter("Handschrift") != null && !request.getParameter("Handschrift").equals("")) {
    }


    if (request.getParameter("Edition")!=null && !request.getParameter("Edition").equals("")) {
      tables.add("quelle_inedition");
      tables.add("edition");
      conditions.add("quelle_inedition.QuelleID = quelle.ID");
      conditions.add("quelle_inedition.EditionID = edition.ID");
      conditions.add("edition.Titel LIKE \""+request.getParameter("Edition")+"\"");
    }


    // Ausgabfelder
    fields.add("quelle.ID ID");
    fieldNames.add("ID");
    headlines.add("Link");

    tables.add("quelle");

    if (request.getParameter("AusgabeKurztitel") != null && request.getParameter("AusgabeKurztitel").equals("on")) {
      fields.add("Bezeichnung");
      fieldNames.add("Bezeichnung");
      headlines.add("Kurztitel");
    }

    if (request.getParameter("AusgabeHandschrift") != null && request.getParameter("AusgabeHandschrift").equals("on")) {
    }

    if (request.getParameter("AusgabeEdition") != null && request.getParameter("AusgabeEdition").equals("on")) {
      fields.add("edition.Titel Edition");
      fieldNames.add("Edition");
      headlines.add("Edition");
      if (!tables.contains("quelle_inedition"))
        tables.add("quelle_inedition");
      if (!tables.contains("edition"))
        tables.add("edition");
      conditions.add("quelle_inedition.QuelleID = quelle.ID");
      conditions.add("quelle_inedition.EditionID = edition.ID");

    }

    if (request.getParameter("AusgabeBelegform") != null && request.getParameter("AusgabeBelegform").equals("on")) {
    }
  }
%>

<%@ include file="ergebnisliste.jsp" %>
