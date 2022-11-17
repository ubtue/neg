<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");
 /* int pageoffset = 0;
  if (request.getParameter("pageoffset") != null) {
    pageoffset = Integer.parseInt(request.getParameter("pageoffset"));
  }*/
//  String sql = "";

  Vector<String> conditions = new Vector<String> ();

  Vector<String> fields = new Vector<String> ();
  Vector<String> fieldNames = new Vector<String> ();

  Vector<String> tables = new Vector <String> ();
  Vector<String> joins = new Vector <String> ();

  Vector<String> headlines = new Vector<String> ();

  String order = "";
  String orderdirection = "ASC";

    String tableString = "";
  String export = "browse";
  if (request.getParameter("neworder") != null) {
    order = "ORDER BY "+request.getParameter("neworder")+" ";
    if (request.getParameter("newdirection") != null) {
      order +=request.getParameter("newdirection");
    }
    else
      order += "ASC";
  }
  

  if (formular.equals("literatur")) {

    // Bedingungen
    if (!request.getParameter("Titel").equals("")) {
      conditions.add("literatur.Titel LIKE \""+request.getParameter("Titel")+"\"");
    }

    if (!request.getParameter("Typ").equals("-99")) {
      conditions.add("literatur.LiteraturTypID = \""+request.getParameter("Typ")+"\"");
    }

    if (!request.getParameter("HerausgeberVorname").equals("")) {
      if(!tableString.contains("literatur_herausgeber")) tableString += " LEFT OUTER JOIN literatur_herausgeber ON literatur_herausgeber.LiteraturID = literatur.ID ";
      conditions.add("literatur_herausgeber.Vorname LIKE \""+request.getParameter("HerausgeberVorname")+"\"");
    }

    if (!request.getParameter("HerausgeberNachname").equals("")) {
      if(!tableString.contains("literatur_herausgeber")) tableString += " LEFT OUTER JOIN literatur_herausgeber ON literatur_herausgeber.LiteraturID = literatur.ID ";
      conditions.add("literatur_herausgeber.Nachname LIKE \""+request.getParameter("HerausgeberNachname")+"\"");
    }
    if (!request.getParameter("AutorVorname").equals("")) {
      if(!tableString.contains("literatur_autor")) tableString += " LEFT OUTER JOIN literatur_autor ON literatur_autor.LiteraturID = literatur.ID ";
      conditions.add("literatur_autor.Vorname LIKE \""+request.getParameter("AutorVorname")+"\"");
    }

    if (!request.getParameter("AutorNachname").equals("")) {
       if(!tableString.contains("literatur_autor")) tableString += " LEFT OUTER JOIN literatur_autor ON literatur_autor.LiteraturID = literatur.ID ";
      conditions.add("literatur_autor.Nachname LIKE \""+request.getParameter("AutorNachname")+"\"");
    }

    // Ausgabfelder
    fields.add("literatur.ID ID");
    fieldNames.add("ID");
    headlines.add("Link");

    tables.add("literatur");

    if (request.getParameter("AusgabeKurzzitierweise") != null && request.getParameter("AusgabeKurzzitierweise").equals("on")) {
    }

    if (request.getParameter("AusgabeTitel") != null && request.getParameter("AusgabeTitel").equals("on")) {
      fields.add("Titel");
      fieldNames.add("Titel");
      headlines.add("Titel");
    }

    if (request.getParameter("AusgabeTyp") != null && request.getParameter("AusgabeTyp").equals("on")) {
      fields.add("selektion_literaturtyp.Bezeichnung Typ");
      fieldNames.add("Typ");
      headlines.add("Typ");
      if(!tableString.contains("selektion_literaturtyp")) tableString += " LEFT OUTER JOIN selektion_literaturtyp ON literatur.LiteraturTypID = selektion_literaturtyp.ID ";
    }

    if (request.getParameter("AusgabeHerausgeber") != null && request.getParameter("AusgabeHerausgeber").equals("on")) {
      if (!tableString.contains("literatur_herausgeber")) {
      tableString += " LEFT OUTER JOIN literatur_herausgeber ON literatur_herausgeber.LiteraturID = literatur.ID ";

      }
      fields.add("literatur_herausgeber.Verbindungstext");
      fields.add("literatur_herausgeber.Vorname");
      fields.add("literatur_herausgeber.Nachname");
      fieldNames.add("literatur_herausgeber.Verbindungstext");
      fieldNames.add("literatur_herausgeber.Vorname");
      fieldNames.add("literatur_herausgeber.Nachname");
      headlines.add("Vb.-text");
      headlines.add("Vorname Hrsg.");
      headlines.add("Nachname Hrsg.");
    }

    if (request.getParameter("AusgabeAutor") != null && request.getParameter("AusgabeAutor").equals("on")) {
      if(!tableString.contains("literatur_autor")) tableString += " LEFT OUTER JOIN literatur_autor ON literatur_autor.LiteraturID = literatur.ID ";
      fields.add("literatur_autor.Vorname");
      fields.add("literatur_autor.Nachname");
      fieldNames.add("literatur_autor.Vorname");
      fieldNames.add("literatur_autor.Nachname");
      headlines.add("Vorname Autor");
      headlines.add("Nachname Autor");
    }
    
            // Tabellen
    //tableString = "literatur" + tableString;
    String tmp = "";
    if (tables.size() > 0) {
      tmp = tables.firstElement();
      for (int i=1; i<tables.size(); i++) {
        tmp += ", "+tables.get(i);
      }
    }
    tableString = tmp + tableString;
    

  }
%>

<%@ include file="ergebnisliste.jsp" %>
