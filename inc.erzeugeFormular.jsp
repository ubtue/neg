<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

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
  String def = "";
  String disabled = "";
  
  boolean isReadOnly = (readonly!=null && readonly.equals("yes"));
  boolean isEmpty = (emp!=null && emp.equals("yes"));
  boolean isSorted = (sorted!=null && sorted.equals("yes"));
  

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

  // Textfeldtyp auslesen
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;
  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM datenbank_mapping WHERE Formular=\""+formular+"\" AND datenfeld=\""+datenfeld+"\"");
    if ( rs.next() ) {
      feldtyp = rs.getString("Feldtyp");
      array = (rs.getInt("Array") == 1 ? true : false);
      beschriftung = rs.getString((String)session.getAttribute("Sprache")+"_Beschriftung");
      platzhalter = rs.getString((String)session.getAttribute("Sprache")+"_Platzhalter");
      if(platzhalter==null || platzhalter.equals("null"))platzhalter="";
      tooltip = rs.getString((String)session.getAttribute("Sprache")+"_Tooltip");
      if(tooltip==null || platzhalter.equals("null"))tooltip="";
      zielTabelle = rs.getString("ZielTabelle");
      zielAttribut = rs.getString("ZielAttribut");
      auswahlherkunft = rs.getString("Auswahlherkunft");
      formularAttribut = rs.getString("FormularAttribut");
      buttonAktion = rs.getString("buttonAktion");
      returnpage = rs.getString("Seite");
      if (rs.getString("default") != null && !rs.getString("default").equals("")) {
        defaultValues = rs.getString("default").split(";");
        for (int i=0; i<defaultValues.length; i++)
          defaultValues[i] = defaultValues[i].trim();
      }

      if (rs.getString("combinedFeldnamen") != null && !rs.getString("combinedFeldnamen").equals("")) {
        combinedFeldnamen = rs.getString("combinedFeldnamen").split(";");
        for (int i=0; i<combinedFeldnamen.length; i++)
          combinedFeldnamen[i] = combinedFeldnamen[i].trim();
      }
      if (rs.getString("combinedFeldtypen") != null && !rs.getString("combinedFeldtypen").equals("")) {
        combinedFeldtypen = rs.getString("combinedFeldtypen").split(";");
        for (int i=0; i<combinedFeldtypen.length; i++)
          combinedFeldtypen[i] = combinedFeldtypen[i].trim();
      }
      if (rs.getString(((String)session.getAttribute("Sprache"))+"_combinedAnzeigenamen") != null && !rs.getString(((String)session.getAttribute("Sprache"))+"_combinedAnzeigenamen").equals("")) {
        combinedAnzeigenamen = rs.getString(((String)session.getAttribute("Sprache"))+"_combinedAnzeigenamen").split(";");
        for (int i=0; i<combinedAnzeigenamen.length; i++)
          combinedAnzeigenamen[i] = combinedAnzeigenamen[i].trim();
      }
    }
  }
  catch (Exception e) {
    out.println(e);
  }
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>

<% if (visible!=null && visible.equals("hidden")) out.println("<div style=\"visibility:hidden\">");%>
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