<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<jsp:include page="dolanguage.jsp" />


<%
  if (AuthHelper.isLogin(request)) {

    int id = -1;
    int filter = 0;
    String formular = "freie_suche";
%>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens</TITLE>
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <script src="javascript/funktionen.js" type="text/javascript"></script>
  </HEAD>

  <BODY>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.suche.html" />

       <div id="form">
       <ul>
          <li><a href="ohneVerknuepfung.jsp?form=einzelbeleg.jsp&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Lemma</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=einzelbeleg.jsp&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_textkritik&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Textkritik</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=einzelbeleg.jsp&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatperson&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Person</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=namenkommentar.jsp&dbForm=namenkommentar&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=PLemma&zwAttribut=namenkommentarID">Namen ohne Belege</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=person.jsp&dbForm=person&zwischentabelle=einzelbeleg_hatperson&attribut=Standardname&zwAttribut=personID">Person ohne Belege</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=quelle.jsp&dbForm=quelle&zwischentabelle=quelle_inedition&attribut=Bezeichnung&zwAttribut=QuelleID">Quelle ohne Edition</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=quelle.jsp&dbForm=quelle&zwischentabelle=handschrift_ueberlieferung&attribut=Bezeichnung&zwAttribut=QuelleID">Quelle ohne Überlieferung</a></li>
          <li><a href="ohneVerknuepfung.jsp?form=handschrift.jsp&dbForm=handschrift&zwischentabelle=handschrift_ueberlieferung&attribut=Bibliothekssignatur&zwAttribut=HandschriftID">Textzeugen ohne Überlieferung</a></li>
          <!--li><a href="http://localhost:8080/NeG_final/ohneVerknuepfung.jsp?form=handschrift.jsp&dbForm=handschrift&zwischentabelle=einzelbeleg_textkritik&attribut=Bibliothekssignatur&zwAttribut=HandschriftID">Textkritik ohne Belege</a></li-->
       </ul>
       
       
    <%
    
    Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;
    
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    
    String form=request.getParameter("form");
    String dbForm=request.getParameter("dbForm");
   	String tabelle=request.getParameter("zwischentabelle");
   	String zwAttribut=request.getParameter("zwAttribut");
    String attribut=request.getParameter("attribut");
    
         
    
    if(form!=null){
    String sql = "select ID, "+attribut+" from "+dbForm+" e where not exists (select * from "+tabelle+" eh where e.ID=eh."+zwAttribut+") order by " + attribut;
    rs = st.executeQuery(sql);
    
	while(rs.next()){
	   out.println("<a href=\""+form+"?ID=" + rs.getString("ID") + "\">-" + rs.getString(attribut) + "</a><br>");
	}    
    }
    %>
    </div>
  </BODY>
</HTML>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
