<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Filter" isThreadSafe="false" %>
<%@ include file="configuration.jsp"%>

<%
  int id = -2;
  String formular = "mgh_lemma";
  Language.setLanguage(request);
  Filter.setFilter(request, formular, out);
  if (AuthHelper.isBenutzerLogin(request)) {  
  
    if(request.getParameter("ID") != null){
        id = Integer.parseInt(request.getParameter("ID"));
    }
    
    Class.forName( sqlDriver );
    Connection cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    Statement st = cn.createStatement();
    ResultSet rs = null;
    String sql = "";
    
    try{
        if (id < -1) {
          try {
            //get the sql filter string from the database
            sql = Filter.getFilterSql(request, formular);
            //select the minimum ID
            sql = sql.replace("*", "min("+formular+".ID) m");
            rs = st.executeQuery(sql);
            //set id
            if (rs.next())
              id = rs.getInt("m");
          } catch (Exception e) {
               out.println(e);
          }      
         }else {
          try {
            //get the sql filter string from the database        
            sql = Filter.getFilterSql(request, formular);
            //select the item count
            String sql2 = sql.replace("*", "count(*) c");
            rs = st.executeQuery(sql2);
            if (rs.next()){
               if(rs.getString("c").equals("0")){
                //no items with this filter
                id=-1;
               }else{
                sql = sql.replace("*", "min("+formular+".ID) m");
                rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
                if (rs.next()&& id>-1 && rs.getString("m")==null){
                  out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
                  return;
                }
               }
            }
          } catch (Exception e) {
              out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
              return;
          }
        }
    }finally{
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
    }
%>

<jsp:include page="dosave.jsp">
	<jsp:param name="form" value="mgh_lemma" />
	<jsp:param name="ID" value="<%= id %>" />
</jsp:include>
<jsp:include page="dojump.jsp">
	<jsp:param name="form" value="mgh_lemma" />
</jsp:include>


<HTML>
<HEAD>
<TITLE>Nomen et Gens - <jsp:include
	page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Textfeld" value="Titel" />
</jsp:include></TITLE>
<link rel="stylesheet" href="layout/layout.css" type="text/css">
<script src="javascript/funktionen.js" type="text/javascript"></script>
<noscript></noscript>
</HEAD>

<BODY
	onLoad="javascript:onoff('tab4','tab1'); onoff('tab1','tab4');urlRewrite(<%=id%>);">
<FORM method="POST"><jsp:include page="layout/navigation.inc.jsp" />
<jsp:include page="layout/image.inc.html" /> <jsp:include
	page="layout/titel.inc.jsp">
	<jsp:param name="title" value="mgh_lemma" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="mgh_lemma" />
</jsp:include>

<div id="form">
 <table style="width:100%;">
	<tbody>
		<tr>
			<td width="200">
                            <% Language.printDatafield(out,session, formular,"MGHLemma");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="MGHLemma" />
				<jsp:param name="size" value="25" />
			</jsp:include><span style="float:right;display:block;font-weight:bold;"><jsp:include page="forms/id.jsp">
            <jsp:param name="ID" value="<%=id%>"/>
            <jsp:param name="title" value="mghlemma"/>
          </jsp:include></span></td>
			<td></td>
		</tr>
	</tbody>
</table>

<div id="tab1">
<div id="header">
<ul id="primary">
	<li>
            <span>
                <% Language.printTextfield(out,session, formular,"TabBearbeiter");%> 
            </span>
        </li>
	<li>
            <a href="javascript:onoff('tab3','tab1');">
                <% Language.printTextfield(out,session, formular,"TabBelege");%>
            </a>
        </li>
	<li>
            <a href="javascript:onoff('tab4','tab1');">
                <% Language.printTextfield(out,session, formular,"TabBemerkungen");%>
            </a>
        </li>
</ul>
</div>
<div id="main">
<table>
	<tbody>
		<tr>
			<td width="250" valign="top">
                            <% Language.printDatafield(out,session, formular,"BearbeiterNeu");%>
                        </td>
			<td width="200"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="BearbeiterNeu" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="250" valign="top">
                            <% Language.printDatafield(out,session, formular,"KorrektorNeu");%>
                        </td>
			<td width="200"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="KorrektorNeu" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>

<jsp:include page="inc.modul.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Modul" value="bearbeiter" />
</jsp:include> <br>
<jsp:include page="inc.modul.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Modul" value="korrektor" />
</jsp:include></div>
</div>

<div id="tab3">
<div id="header">
<ul id="primary">
	<li>
            <a href="javascript:onoff('tab1','tab3');">
                <% Language.printTextfield(out,session, formular,"TabBearbeiter");%>
            </a>
        </li>
	<li>
            <span>
                <% Language.printTextfield(out,session, formular,"TabBelege");%>
            </span>
        </li>
	<li>
            <a href="javascript:onoff('tab4','tab3');">
                <% Language.printTextfield(out,session, formular,"TabBemerkungen");%>
            </a>
        </li>
</ul>
</div>
<div id="main"><jsp:include page="inc.modul.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="mgh_lemma" />
	<jsp:param name="Modul" value="belege" />
</jsp:include></div>
</div>


<div id="tab4">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab4');"> 
            <% Language.printTextfield(out,session, formular,"TabBearbeiter");%>
            </a></li>
	<li><a href="javascript:onoff('tab3','tab4');"> 
            <% Language.printTextfield(out,session, formular,"TabBelege");%>
            </a></li>
	<li><span>
            <% Language.printTextfield(out,session, formular,"TabBemerkungen");%>
            </span></li>
</ul>
</div>
<div id="main">
<table>
	<tbody>
		<tr>
			<td valign="top" width="200">
                            <% Language.printDatafield(out,session, formular,"BemerkungAlle");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="BemerkungAlle" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                            <% Language.printDatafield(out,session, formular,"BemerkungGruppe");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="BemerkungGruppe" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                        <% Language.printDatafield(out,session, formular,"BemerkungPrivat");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="BemerkungPrivat" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                        <% Language.printDatafield(out,session, formular,"Bearbeitungsstatus");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="Bearbeitungsstatus" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                        <% Language.printDatafield(out,session, formular,"LetzteAenderung");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="LetzteAenderung" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                            <% Language.printDatafield(out,session, formular,"LetzteAenderungVon");%>
                        </td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="LetzteAenderungVon" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                            <% Language.printDatafield(out,session, formular,"Erstellt");%>
                        </td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="Erstellt" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200">
                            <% Language.printDatafield(out,session, formular,"ErstelltVon");%>
                        </td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="mgh_lemma" />
				<jsp:param name="Datenfeld" value="ErstelltVon" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
</div>
</div>
</div>
</FORM>
</BODY>
</HTML>
<%

  }
  else {
  %>
    <p>
        <% Language.printTextfield(out,session, "error","Zugriff");%>
    </p>
    <a href="index.jsp">
        <% Language.printTextfield(out,session, "all","Startseite");%>
    </a>
  <%
  }
%>
