<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankMapping" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%

  String id = "-1";
  String formular = request.getParameter("Formular");
  String datenfeld = request.getParameter("Datenfeld");
  String visible = request.getParameter("Visibility");
  String readonly = request.getParameter("Readonly");
  String emp = request.getParameter("Empty");
  String sorted = request.getParameter("Sorted");
  String klarlemma = request.getParameter("Klarlemma");
  String def = "";
  String disabled = "";

  boolean isReadOnly = (readonly!=null && readonly.equals("yes"));
  boolean isEmpty = (emp!=null && emp.equals("yes"));
  boolean isSorted = (sorted!=null && sorted.equals("yes"));
  boolean isKlarlemma = (isReadOnly && klarlemma != null && klarlemma.equals("yes"));


  if (request.getParameter("ID") != null)
    id = request.getParameter("ID");

  int size = 0;
  int rows = 0;
  int cols = 0;

  try {
    def = request.getParameter("Default");
  } catch (Exception e) {}
  try {
    size = Integer.parseInt(request.getParameter("size"));
  } catch (Exception e) {}
  try {
    rows = Integer.parseInt(request.getParameter("rows"));
  } catch (Exception e) {}
  try {
    cols = Integer.parseInt(request.getParameter("cols"));
  } catch (Exception e) {}


  String feldtyp = "";
  boolean array = false;

  String sprache = (String)session.getAttribute("Sprache");
  String beschriftung = "";
  String platzhalter = "";
  String tooltip = "";
  String zielTabelle = "";
  String zielAttribut = "";
  String auswahlherkunft = "";
  String formularAttribut = "";
  String buttonAktion = "";
  String returnpage = "";

  String[] defaultValues = null;
  String[] combinedFeldnamen = null;
  String[] combinedFeldtypen = null;
  String[] combinedAnzeigenamen = null;

  DatenbankMapping mapping = DatenbankDB.getMapping(formular, datenfeld);

  if (mapping != null) {
    feldtyp = mapping.getFeldtyp();
    array = mapping.getArray();
    beschriftung = mapping.getBeschriftung(sprache);
    platzhalter = mapping.getPlatzhalter(sprache);
    if(platzhalter==null || platzhalter.equals("null"))platzhalter="";
    tooltip = mapping.getTooltip(sprache);
    if(tooltip==null || platzhalter.equals("null"))tooltip="";
    zielTabelle = mapping.getZielTabelle();
    zielAttribut = mapping.getZielAttribut();
    auswahlherkunft = mapping.getAuswahlherkunft();
    formularAttribut = mapping.getFormularAttribut();
    buttonAktion = mapping.getButtonAktion();
    returnpage = mapping.getSeite();

    defaultValues = mapping.getAltAsArray();
    combinedFeldnamen = mapping.getCombinedFeldnamenAsArray();
    combinedFeldtypen = mapping.getCombinedFeldtypenAsArray();
    combinedAnzeigenamen = mapping.getCombinedAnzeigenamenAsArray(sprache);
  }
%>

<% if (visible!=null && visible.equals("hidden")) out.println("<div style=\"visibility:hidden\">");%>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
// TODO: These definitions here are still necessary for the forms/templates to work.
// We should refactor them at a later point.
Connection cn = null;
Statement  st = null;
ResultSet  rs = null;
%>

<%@ include file="forms/autocomplete.jsp" %>
<%@ include file="forms/array.addselect.jsp" %>
<%@ include file="forms/array.addselectandtext.jsp" %>
<%@ include file="forms/array.combined.jsp" %>
<%@ include file="forms/array.link.jsp" %>
<%@ include file="forms/array.select.jsp" %>
<%@ include file="forms/array.textfield.jsp" %>

<%@ include file="forms/noarray.button.jsp" %>
<%@ include file="forms/noarray.checkbox.jsp" %>
<%@ include file="forms/noarray.date.jsp" %>
<%@ include file="forms/noarray.dateRO.jsp" %>
<%@ include file="forms/noarray.extref.jsp" %>
<%@ include file="forms/noarray.file.jsp" %>
<%@ include file="forms/noarray.generator.jsp" %>
<%@ include file="forms/noarray.infodate.jsp" %>
<%@ include file="forms/noarray.infogroup.jsp" %>
<%@ include file="forms/noarray.infouser.jsp" %>
<%@ include file="forms/noarray.nkeditor.jsp" %>
<%@ include file="forms/noarray.note.jsp" %>
<%@ include file="forms/noarray.search.jsp" %>
<%@ include file="forms/noarray.link.jsp" %>
<%@ include file="forms/noarray.select.jsp" %>
<%@ include file="forms/noarray.addselect.jsp" %>
<%@ include file="forms/noarray.sqlselect.jsp" %>
<%@ include file="forms/noarray.textarea.jsp" %>
<%@ include file="forms/noarray.textfield.jsp" %>

<% if (visible!=null && visible.equals("hidden")) out.println("</div>");%>
