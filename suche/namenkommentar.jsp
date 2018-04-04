<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
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

    if (!request.getParameter("SW_Motivation").equals("")) {
      tables.add("schlagwort_motivation");
      tables.add("selektion_sw_motivation");
      conditions.add("schlagwort_motivation.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_motivation.Schlagwort = selektion_sw_motivation.ID");
      conditions.add("selektion_sw_motivation.Bezeichnung LIKE \""+request.getParameter("SW_Motivation")+"\"");
    }

    if (!request.getParameter("SW_SprachHerkunft").equals("")) {
      tables.add("schlagwort_sprachherkunft");
      tables.add("selektion_sw_sprachherkunft");
      conditions.add("schlagwort_sprachherkunft.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_sprachherkunft.Schlagwort = selektion_sw_sprachherkunft.ID");
      conditions.add("selektion_sw_sprachherkunft.Bezeichnung LIKE \""+request.getParameter("SW_SprachHerkunft")+"\"");
    }

    if (!request.getParameter("SW_PhonGraph").equals("")) {
      tables.add("schlagwort_phongraph");
      tables.add("selektion_sw_phongraph");
      conditions.add("schlagwort_phongraph.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_phongraph.Schlagwort = selektion_sw_phongraph.ID");
      conditions.add("selektion_sw_phongraph.Bezeichnung LIKE \""+request.getParameter("SW_PhonGraph")+"\"");
    }

    if (!request.getParameter("SW_Morphologie").equals("")) {
      tables.add("schlagwort_morphologie");
      tables.add("selektion_sw_morphologie");
      conditions.add("schlagwort_morphologie.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_morphologie.Schlagwort = selektion_sw_morphologie.ID");
      conditions.add("selektion_sw_morphologie.Bezeichnung LIKE \""+request.getParameter("SW_Morphologie")+"\"");
    }

    if (!request.getParameter("SW_Namenelement").equals("")) {
      tables.add("schlagwort_namenlexikon");
      tables.add("selektion_sw_namenlexikon");
      conditions.add("schlagwort_namenlexikon.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_namenlexikon.Schlagwort = selektion_sw_namenlexikon.ID");
      conditions.add("selektion_sw_namenlexikon.Bezeichnung LIKE \""+request.getParameter("SW_Namenelement")+"\"");
    }

    if (!request.getParameter("SW_ArealGens").equals("")) {
      tables.add("schlagwort_arealgens");
      tables.add("selektion_sw_arealgens");
      conditions.add("schlagwort_arealgens.NamenkommentarID = namenkommentar.ID");
      conditions.add("schlagwort_arealgens.Schlagwort = selektion_sw_arealgens.ID");
      conditions.add("selektion_sw_arealgens.Bezeichnung LIKE \""+request.getParameter("SW_ArealGens")+"\"");
    }

    // Ausgabfelder
    fields.add("namenkommentar.ID");
    fieldNames.add("ID");
    headlines.add("ID");

    fields.add("PLemma");
    fieldNames.add("namenkommentar.PLemma");
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