﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>

<%
  int id = -1;
  String title = request.getParameter("title");

  //Filter berechnen
  session = request.getSession(true);
  int filter = 0;
  String filterParameter = null;
  String formular = request.getParameter("Formular"); 
  try {
    filter = ((Integer) session.getAttribute(formular + "filter")).intValue();
    filterParameter = (String) session.getAttribute(formular + "filterParameter");
  }
  catch (Exception e) {}

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  }
  catch (NumberFormatException e) {}
%>
<div id="titel">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td align="left">
        <h1>
          <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="<%= request.getParameter("title") %>"/>
            <jsp:param name="Textfeld" value="Titel"/>
          </jsp:include>
          <% 
           if(title.equals("Einzelbeleg") || title.equals("Person") || title.equals("Namenkommentar") || title.equals("Quelle")){
			String url = request.getRequestURL().toString();
          	String query = request.getQueryString();
			url = url.substring(0, url.lastIndexOf('/') + 1)  + "gast/" + url.substring(url.lastIndexOf('/') + 1, url.length()) ;
			out.println("<a href=\""+url);
			if (query!=null) out.println("?"+query);
			out.println("\">");
          
          %><img src="layout/icons/lupe.png" height="16" width="16" alt="Zeige Eintrag im Gast-Modus"></a>
          <%} %>
        </h1>
      </td>
      <td align="right">
        <jsp:include page="../forms/link.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="Command" value="new"/>
        </jsp:include>

<% // Nur Anzeigen, wenn eigener Datensatz oder Datensatz ohne Besitzer
  int akt = 0;
  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;
  try {
    id = Integer.parseInt(request.getParameter("ID"));
    String disabled ="";

    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT GehoertGruppe"
                           +" FROM "+request.getParameter("title").toLowerCase()
                           +" WHERE ID = "+id
                           +" ");
   /* if (rs.next() && rs.getString("GehoertGruppe")!=null && rs.getInt("GehoertGruppe")!=((Integer) session.getAttribute("GruppeID")).intValue() ) {
      disabled = " disabled";
    }*/
    out.println("    <script src=\"javascript/shortcuts.js\" type=\"text/javascript\"></script>");
    if(!disabled.equals(" disabled"))
      out.println("    <script type=\"text/javascript\">shortcut.add(\"Ctrl+Shift+S\",function() {document.forms[0].speichern.click();	},{	'type':'keydown',	'propagate':false,	'target':document});</script>");
%>
    <input type="submit" name="speichern" value="speichern" <%= disabled %>>
    <input type="reset" name="abbrechen" value="zur&uuml;cksetzen" <%= disabled %>>
<%
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
        <jsp:include page="../forms/link.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="Command" value="first"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
           <jsp:param name="formular" value="<%= formular %>"/>
        </jsp:include>

        <jsp:include page="../forms/link.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="Command" value="back"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
           <jsp:param name="formular" value="<%= formular %>"/>
        </jsp:include>

        <jsp:include page="../forms/link.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="Command" value="next"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
           <jsp:param name="formular" value="<%= formular %>"/>
        </jsp:include>

        <jsp:include page="../forms/link.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="Command" value="last"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
           <jsp:param name="formular" value="<%= formular %>"/>
        </jsp:include>

        <jsp:include page="../forms/duplicate.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
        </jsp:include>
      </td>
    </tr>
    <tr>
      <td align="left">
       <jsp:include page="../forms/jumpID.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
        </jsp:include>
       <jsp:include page="../forms/jump.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
        </jsp:include>
       </td>
      <td align="right">
        <jsp:include page="../forms/filter.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="formular" value="<%= formular %>"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
        </jsp:include>
      </td>
    </tr>
    </table>
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
    
    <tr>
      <td align="left" nowrap>
          <jsp:include page="../forms/shortcut.jsp">
          <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
          <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
          <jsp:param name="filter" value="<%= filter %>"/>
          <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
          <jsp:param name="formular" value="<%= formular %>"/>
        </jsp:include>
       </td>
      <td align="right" style="color:white;font-weight:bold;">
Eintrag           <jsp:include page="../forms/counter.jsp">
            <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
            <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
            <jsp:param name="filter" value="<%= filter %>"/>
            <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
          </jsp:include>
      </td>
    </tr>
  </table>
</div>