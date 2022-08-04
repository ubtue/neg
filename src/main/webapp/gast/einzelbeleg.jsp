<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<jsp:include page="../dolanguage.jsp" />
<jsp:include page="../dofilter.jsp" />


<%

  if (session.getAttribute("BenutzerID")==null) {
     Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    if (request.getParameter("language") != null) {
      session = request.getSession(true);
      session.setAttribute("Sprache", request.getParameter("language"));
      session.setMaxInactiveInterval(sessionTimeout);
    }

      String login = "Gast";
      String password = "gast";

      // Passwort verschlÃ¼sseln
      MessageDigest m = MessageDigest.getInstance("MD5");
      m.update(password.getBytes(), 0, password.length());
      String passwordMD5 = (new BigInteger(1, m.digest()).toString(16));

      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT ID, Login, GruppeID, IstAdmin, Sprache, IstGast FROM benutzer WHERE Login='"+login+"' AND Password ='"+passwordMD5+"'");

        if (rs.next()) {
          // Falls Session vorhanden, lÃ¶schen
          if (session != null) {
            session.invalidate();
          }

          // Neue Session erzeugen

          session = request.getSession(true);
          session.setAttribute("BenutzerID", new Integer(rs.getInt("ID")));
          session.setAttribute("GruppeID", new Integer(rs.getInt("GruppeID")));
          session.setAttribute("Benutzername", rs.getString("Login"));
          session.setAttribute("Administrator", new Boolean((rs.getInt("IstAdmin")==1?true:false)));
          session.setAttribute("Gast", new Boolean((rs.getInt("IstGast")==1?true:false)));
          session.setAttribute("Sprache", rs.getString("Sprache"));
          session.setMaxInactiveInterval(sessionTimeout);
     } }     finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }

  }

  if (session.getAttribute("BenutzerID")!=null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

                          session.setAttribute("filter", 0);
        session.setAttribute("filterParameter", "");


    int id = -2;
    int filter = 0;
    String formular = "einzelbeleg";

    try {
      id = Integer.parseInt(request.getParameter("ID"));
    }
    catch (Exception e) {}
    try {
      filter = ((Integer)session.getAttribute("filter")).intValue();
    }
    catch (Exception e) {}

      Connection cn = null;
      Statement st = null;
      ResultSet rs = null;
      String sql = "";
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();
        rs = st.executeQuery("SELECT * FROM datenbank_filter WHERE Formular='gast_"+formular+"' AND Nummer='"+filter+"';");

        if (rs.next()) {
          sql = rs.getString("SQLString");
        }
        sql = sql.replace("*", "min("+formular+".ID) m");
        String filterParameter = (String) session.getAttribute("filterParameter");
        if (filterParameter != null)
          sql = sql.replace("###", filterParameter);
        sql = sql.replace("#userid#", ""+((Integer)session.getAttribute("BenutzerID")).intValue());
        sql = sql.replace("#groupid#", ""+((Integer)session.getAttribute("GruppeID")).intValue());
//        out.println(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        if(id>-1)rs = st.executeQuery(sql+(sql.contains("WHERE")?" AND ":" WHERE ")+formular+".ID = "+id);
        else rs = st.executeQuery(sql);
        if (rs.next() && id>-1 && rs.getString("m")==null){
           out.println("ID nicht vorhanden. <a href=\"javascript:history.back();\">Zur&uuml;ck zur vorherigen Seite</a>");
           return;
        }
        else id = rs.getInt("m");
      }
      catch (Exception e) {out.println(e);}
      finally {
        try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
        try { if( null != st ) st.close(); } catch( Exception ex ) {}
        try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
      }

%>


<jsp:include page="../dojump.jsp">
  <jsp:param name="form" value="gast_einzelbeleg" />
</jsp:include>

<HTML>
  <HEAD>
    <TITLE>Nomen et Gens |
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Textfeld" value="Titel"/>
      </jsp:include>
    </TITLE>
    <link rel="icon" href="layout/images/nomen_et_gens_icon.gif" type="image/gif">
    <link rel="stylesheet" href="layout/layout.css" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Alegreya+Sans+SC:400,700' rel='stylesheet' type='text/css'>
    <script src="../javascript/funktionen.js" type="text/javascript"></script>
    <script src="../javascript/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../javascript/javascript.js" type="text/javascript"></script>
    <noscript></noscript>
  </HEAD>

  <BODY onLoad="javascript:urlRewrite(<%= id %>);">
    <jsp:include page="layout/header.inc.jsp">
            <jsp:param name="current" value="einzelbeleg" />
    </jsp:include>
<!--      <jsp:include page="layout/image.inc.jsp" />-->
      <jsp:include page="layout/titel.inc.jsp">
        <jsp:param name="title" value="Einzelbeleg" />
        <jsp:param name="ID" value="<%= id %>" />
        <jsp:param name="size" value="" />
        <jsp:param name="Formular" value="einzelbeleg" />
      </jsp:include>

      <jsp:include page="../inc.erzeugeFormular.jsp">
        <jsp:param name="ID" value="<%= id %>"/>
        <jsp:param name="Formular" value="einzelbeleg"/>
        <jsp:param name="Datenfeld" value="ID"/>
        <jsp:param name="size" value="11"/>
      </jsp:include>


      <div id="content">

<!----------ID---------->
        <div id="id">
          <jsp:include page="../forms/id.jsp">
            <jsp:param name="ID" value="<%=id%>"/>
            <jsp:param name="title" value="gast_einzelbeleg"/>
          </jsp:include>
        </div>

<!----------Belegstelle---------->
        <h3>
          <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Textfeld" value="TabBelegstelle"/>
          </jsp:include>
        </h3>

        <table class="content-table">
          <tbody>
            <tr>
              <th>
            <jsp:include page="../inc.erzeugeBeschriftung.jsp">
              <jsp:param name="Formular" value="einzelbeleg"/>
              <jsp:param name="Datenfeld" value="PersonRO"/>
            </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="PersonRO"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="Belegform"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="Belegform"/>
                  <jsp:param name="size" value="50"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                      <jsp:param name="ID" value="<%= id %>"/>
                      <jsp:param name="Formular" value="einzelbeleg"/>
                      <jsp:param name="Datenfeld" value="Griechisch"/>
                      <jsp:param name="size" value="50"/>
                      <jsp:param name="Readonly" value="yes"/>
                    </jsp:include>
              </td>
            </tr>
            <tr>
              <th><jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="LemmaRO"/>
                  </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="LemmaRO"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            
             <tr>
              <th><jsp:include page="../inc.erzeugeBeschriftung.jsp">
                    <jsp:param name="Formular" value="einzelbeleg"/>
                    <jsp:param name="Datenfeld" value="MGHLemmaRO"/>
                  </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="MGHLemmaRO"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            
            
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="Kontext"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="Kontext"/>
                  <jsp:param name="cols" value="40"/>
                  <jsp:param name="rows" value="5"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="LebendVerstorben"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="LebendVerstorben"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Textfeld" value="DatierungNennung"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="Formular" value="gast_einzelbeleg"/>
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Datenfeld" value="Datierung"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="DatierungUngewiss"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="DatierungUngewiss"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="KommentarDatierung"/>
                  <jsp:param name="cols" value="40"/>
                  <jsp:param name="rows" value="5"/>
                      <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
          </tbody>
        </table>

<!----------Quelle---------->
        <h3>
          <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Textfeld" value="BoxQuelle"/>
          </jsp:include>
        </h3>
        <table class="content-table">
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Textfeld" value="Kurztitel"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="QuelleLink"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Textfeld" value="Edition"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="Edition"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Textfeld" value="Kapitel"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="EditionKapitel"/>
                  <jsp:param name="size" value="20"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Textfeld" value="Seite"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="EditionSeite"/>
                  <jsp:param name="size" value="20"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
            <tr>
              <th>
                <jsp:include page="../inc.erzeugeBeschriftung.jsp">
                  <jsp:param name="Formular" value="einzelbeleg"/>
                  <jsp:param name="Datenfeld" value="QuelleDatierung"/>
                </jsp:include>
              </th>
              <td>
                <jsp:include page="../inc.erzeugeFormular.jsp">
                  <jsp:param name="Formular" value="gast_einzelbeleg"/>
                  <jsp:param name="ID" value="<%= id %>"/>
                  <jsp:param name="Datenfeld" value="QuelleDatierung"/>
                  <jsp:param name="Readonly" value="yes"/>
                </jsp:include>
              </td>
            </tr>
        </table>

<!----------Textkritik---------->
        <div id="textkritik">
            <h3>
            <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Textfeld" value="TabTextkritik"/>
            </jsp:include>
            </h3>
            <jsp:include page="../inc.modul.jsp">
            <jsp:param name="ID" value="<%= id %>"/>
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Modul" value="lesartenRO"/>
            </jsp:include>
        </div>
  </div>
<jsp:include page="layout/footer.inc.jsp" />
  </BODY>
</HTML>
<%
  }
  else {
  %>
    <p>
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
      </jsp:include>
    </p>
    <a href="index.jsp">
      <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a>
  <%
  }
%>
