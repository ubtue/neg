<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.SucheDB" isThreadSafe="false" %>
<%@ page import="java.util.Date" isThreadSafe="false" %>
<%@ page import="java.util.Map" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>
<%
  Language.setLanguage(request);
%>
  <div>
      
    <jsp:include page="layout/titel.suche.html" />

       <div id="form">
       <ul>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Lemma</a></li>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_textkritik&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Textkritik</a></li>
          <li><a href="ohneVerknuepfung?form=einzelbeleg&dbForm=einzelbeleg&zwischentabelle=einzelbeleg_hatperson&attribut=Belegform&zwAttribut=einzelbelegID">Einzelbelege ohne Person</a></li>
          <li><a href="ohneVerknuepfung?form=namenkommentar&dbForm=namenkommentar&zwischentabelle=einzelbeleg_hatnamenkommentar&attribut=PLemma&zwAttribut=namenkommentarID">Namen ohne Belege</a></li>
          <li><a href="ohneVerknuepfung?form=person&dbForm=person&zwischentabelle=einzelbeleg_hatperson&attribut=Standardname&zwAttribut=personID">Person ohne Belege</a></li>
          <li><a href="ohneVerknuepfung?form=quelle&dbForm=quelle&zwischentabelle=quelle_inedition&attribut=Bezeichnung&zwAttribut=QuelleID">Quelle ohne Edition</a></li>
          <li><a href="ohneVerknuepfung?form=quelle&dbForm=quelle&zwischentabelle=handschrift_ueberlieferung&attribut=Bezeichnung&zwAttribut=QuelleID">Quelle ohne Überlieferung</a></li>
          <li><a href="ohneVerknuepfung?form=handschrift&dbForm=handschrift&zwischentabelle=handschrift_ueberlieferung&attribut=Bibliothekssignatur&zwAttribut=HandschriftID">Textzeugen ohne Überlieferung</a></li>
       </ul>


    <%
    String form=request.getParameter("form");
    if(form!=null){
        Map<Integer,String> attr = SucheDB.getAttributes(request);
        for(Integer key : attr.keySet()){
            out.println("<a href=\""+form+"?ID=" + key + "\">-" + attr.get(key) + "</a><br>");
        }
    }
    %>
    </div>
  </div>
