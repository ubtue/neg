<%@ page import="java.sql.*" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp"%>

<jsp:include page="dolanguage.jsp" />
<jsp:include page="dofilter.jsp">
     <jsp:param name="form" value="quelle" />
</jsp:include>

<%
	if (AuthHelper.isLogin(request)) {

		int id = -2;
		int urkundeid = -1;
		int filter = 0;
		String formular = "quelle";

		try {
			id = Integer.parseInt(request.getParameter("ID"));
		} catch (Exception e) {
		}
		try {
			filter = ((Integer) session.getAttribute(formular+"filter"))
					.intValue();
		} catch (Exception e) {
		}
		
    if (id < -1) {
      Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      String sql = "";
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+formular+"' AND Nummer='"+filter+"';");
        if (rs.next()) {
          sql = rs.getString("SQLString");
        }
        else{
        rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+formular+"' AND Nummer='0';");
           if (rs.next()) {
             sql = rs.getString("SQLString");
           }
        
        }
 //       out.println("SQL: " + sql);
        sql = sql.replace("*", "min("+formular+".ID) m");
        String filterParameter = (String) session.getAttribute(formular+"filterParameter");
        if (filterParameter != null)
          sql = sql.replace("###", filterParameter);
        sql = sql.replace("#userid#", ""+((Integer)session.getAttribute("BenutzerID")).intValue());
        sql = sql.replace("#groupid#", ""+((Integer)session.getAttribute("GruppeID")).intValue());
 //       rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID < "+id);
  //      out.println("SQL: " + sql);
        rs = st.executeQuery(sql);
        if (rs.next())
          id = rs.getInt("m");
 	   } catch (Exception e) {
           out.println(e);
       }      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
     }else    {
      Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      String sql = "";
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+formular+"' AND Nummer='"+filter+"';");
        if (rs.next()) {
          sql = rs.getString("SQLString");
        }
        else{
           rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='"+formular+"' AND Nummer='0';");
           if (rs.next()) {
             sql = rs.getString("SQLString");
           }
        
        }
        if (rs.next()) {
          sql = rs.getString("SQLString");
        }
        String filterParameter = (String) session.getAttribute(formular + "filterParameter");
        if (filterParameter != null)
          sql = sql.replace("###", filterParameter);
        sql = sql.replace("#userid#", ""+((Integer)session.getAttribute("BenutzerID")).intValue());
        sql = sql.replace("#groupid#", ""+((Integer)session.getAttribute("GruppeID")).intValue());
         String sql2 = sql.replace("*", "count(*) c");
 //       out.println(sql2);
 //       if(true)return;
        rs = st.executeQuery(sql2);
        if (rs.next()){
           if(rs.getString("c").equals("0")) id=-1;
           else{
           sql = sql.replace("*", "min("+formular+".ID) m");
           rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
           if (rs.next()&& id>-1 && rs.getString("m")==null){
              out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
              return;
           }}}
	      } catch (Exception e) {
              out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
             return;
           }
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }
    }

		Connection cn = null;
		Statement st = null;
		ResultSet rs = null;
		try {
			Class.forName(sqlDriver);
			cn = DriverManager.getConnection(sqlURL, sqlUser,
					sqlPassword);
			st = cn.createStatement();
			rs = st
					.executeQuery("SELECT ID FROM urkunde WHERE QuelleID ="
							+ id + ";");
			if (rs.next())
				urkundeid = rs.getInt("ID");
			else {
				st
						.executeUpdate("INSERT into urkunde (QuelleID) values ('"
								+ id + "')");
				rs = st
						.executeQuery("SELECT ID FROM urkunde WHERE QuelleID ="
								+ id + ";");
				if (rs.next())
					urkundeid = rs.getInt("ID");

			}
		} finally {
			try {
				if (null != rs)
					rs.close();
			} catch (Exception ex) {
			}
			try {
				if (null != st)
					st.close();
			} catch (Exception ex) {
			}
			try {
				if (null != cn)
					cn.close();
			} catch (Exception ex) {
			}
		}
%>
<jsp:include page="dosave.jsp">
	<jsp:param name="form" value="quelle" />
	<jsp:param name="ID" value="<%= id %>" />
</jsp:include>
<jsp:include page="dosave.jsp">
	<jsp:param name="form" value="urkunde" />
	<jsp:param name="ID" value="<%= urkundeid %>" />
</jsp:include>
<jsp:include page="dojump.jsp">
	<jsp:param name="form" value="quelle" />
</jsp:include>

<HTML>
<HEAD>
<TITLE>Nomen et Gens - <jsp:include
	page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="quelle" />
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
	<jsp:param name="title" value="Quelle" />
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="size" value="" />
	<jsp:param name="Formular" value="quelle" />
</jsp:include> <jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Datenfeld" value="ID" />
	<jsp:param name="size" value="11" />
</jsp:include>

<div id="form">
 <table style="width:100%;">
	<tbody>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Quellennummer" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Quellennummer" />
				<jsp:param name="size" value="15" />
				<jsp:param name="Default" value="<%= id %>" />
			</jsp:include></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Bezeichnung" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Bezeichnung" />
				<jsp:param name="size" value="50" />
			</jsp:include></td>
			<td><span style="float:right;display:block;font-weight:bold;"><jsp:include page="forms/id.jsp">
            <jsp:param name="ID" value="<%=id %>"/>
            <jsp:param name="title" value="quelle"/>
          </jsp:include></span></td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Quellenkommentar" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Quellenkommentar" />
			</jsp:include></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Ueberlieferungskommentar" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Ueberlieferungskommentar" />
			</jsp:include></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="200"><jsp:include page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="ZuVeroeffentlichen" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="ZuVeroeffentlichen" />
			</jsp:include></td>
			<td>&nbsp;</td>
		</tr>
	</tbody>
</table>
<br>
<table class="date">
	<tbody>
		<tr>
			<th class="date" colspan="2"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Textfeld" value="Datierung" />
			</jsp:include></th>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatumVon" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatumVon" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatumBis" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatumBis" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatierungUngewiss" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="DatierungUngewiss" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="KommentarDatierung" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="KommentarDatierung" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>

<div id="tab1">
<div id="header">
<ul id="primary">
	<li><span> <jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabEdition" />
	</jsp:include> </span></li>
	<li><a href="javascript:onoff('tab2','tab1');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUeberlieferung" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab3','tab1');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUrkunde" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab4','tab1');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabBemerkungen" />
	</jsp:include> </a></li>
</ul>
</div>
<div id="main"><jsp:include page="inc.erzeugeFormular.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Datenfeld" value="Edition" />
</jsp:include></div>
</div>

<div id="tab2">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab2');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabEdition" />
	</jsp:include> </a></li>
	<li><span> <jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUeberlieferung" />
	</jsp:include> </span></li>
	<li><a href="javascript:onoff('tab3','tab2');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUrkunde" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab4','tab2');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabBemerkungen" />
	</jsp:include> </a></li>
</ul>
</div>
<div id="main"><jsp:include page="inc.modul.jsp">
	<jsp:param name="ID" value="<%= id %>" />
	<jsp:param name="Formular" value="quelle" />
	<jsp:param name="Modul" value="ueberlieferung" />
</jsp:include></div>
</div>

<div id="tab3">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab3');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabEdition" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab2','tab3');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUeberlieferung" />
	</jsp:include> </a></li>
	<li><span> <jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUrkunde" />
	</jsp:include> </span></li>
	<li><a href="javascript:onoff('tab4','tab3');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabBemerkungen" />
	</jsp:include> </a></li>
</ul>
</div>
<div id="main">
<table>
	<tbody>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Actumort" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= urkundeid %>" />
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Actumort" />
				<jsp:param name="size" value="50" />
			</jsp:include></td>
		</tr>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Betreff" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= urkundeid %>" />
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Betreff" />
				<jsp:param name="size" value="50" />
			</jsp:include></td>
		</tr>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Aussteller" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= urkundeid %>" />
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Aussteller" />
			</jsp:include></td>
		</tr>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Empfaenger" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= urkundeid %>" />
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Empfaenger" />
			</jsp:include></td>
		</tr>
		<tr>
			<th width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Dorsalnotiz" />
			</jsp:include></th>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= urkundeid %>" />
				<jsp:param name="Formular" value="urkunde" />
				<jsp:param name="Datenfeld" value="Dorsalnotiz" />
				<jsp:param name="size" value="50" />
			</jsp:include></td>
		</tr>
	</tbody>
</table>
</div>
</div>

<div id="tab4">
<div id="header">
<ul id="primary">
	<li><a href="javascript:onoff('tab1','tab4');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabEdition" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab2','tab4');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUeberlieferung" />
	</jsp:include> </a></li>
	<li><a href="javascript:onoff('tab3','tab4');"> <jsp:include
		page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabUrkunde" />
	</jsp:include> </a></li>
	<li><span> <jsp:include page="inc.erzeugeBeschriftung.jsp">
		<jsp:param name="Formular" value="quelle" />
		<jsp:param name="Textfeld" value="TabBemerkungen" />
	</jsp:include> </span></li>
</ul>
</div>
<div id="main">
<table>
	<tbody>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungAlle" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungAlle" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungGruppe" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungGruppe" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungPrivat" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="BemerkungPrivat" />
				<jsp:param name="cols" value="40" />
				<jsp:param name="rows" value="5" />
			</jsp:include></td>
		</tr>
		<tr>
			<td width="200" valign="top"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Bearbeitungsstatus" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Bearbeitungsstatus" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="LetzteAenderung" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="LetzteAenderung" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="LetzteAenderungVon" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="LetzteAenderungVon" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Erstellt" />
			</jsp:include></td>
			<td width="450"><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="Erstellt" />
			</jsp:include></td>
		</tr>
		<tr>
			<td valign="top" width="200"><jsp:include
				page="inc.erzeugeBeschriftung.jsp">
				<jsp:param name="Formular" value="quelle" />
				<jsp:param name="Datenfeld" value="ErstelltVon" />
			</jsp:include></td>
			<td><jsp:include page="inc.erzeugeFormular.jsp">
				<jsp:param name="ID" value="<%= id %>" />
				<jsp:param name="Formular" value="quelle" />
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
	} else {
%>
<p><jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="error" />
	<jsp:param name="Textfeld" value="Zugriff" />
</jsp:include></p>
<a href="index.jsp"> <jsp:include page="inc.erzeugeBeschriftung.jsp">
	<jsp:param name="Formular" value="all" />
	<jsp:param name="Textfeld" value="Startseite" />
</jsp:include> </a>
<%
	}
%>
