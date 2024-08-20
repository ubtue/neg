<%@page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<div id="navigation">
    <a href="einzelbeleg">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einzelbeleg"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="person">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="person"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="namenkommentar">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="namenkommentar"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="lemma">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="mgh_lemma"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="quelle">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="quelle"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="edition">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="edition"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="handschrift">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="handschrift"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="suche">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="suche"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="ohneVerknuepfung">offene Verkn&uuml;pfung</a>
    <br>
    <hr>
    <a href="freie_suche">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="freie_suche"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <hr>
    <hr>
    <a href="einstellungen">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="einstellungen"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a><%      if (session.getAttribute("BenutzerID") != null
                && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0
                && ((Boolean) session.getAttribute("Administrator")).booleanValue()) {
    %>

    <br>
    <hr>
    <a href="administration">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="administration"/>
            <jsp:param name="Textfeld" value="Titel"/>
        </jsp:include>
    </a>
    <br>
    <hr>
    <a href="file">
        <%
            DatenbankTexte label = DatenbankTexteDB.getText("navigation", "InhaltBearbeiten");
        %>
        <%= label.getDe()%>
    </a>
    <%
        }
    %>
    <br>
    <hr>
    <hr>
    <a href="logout?go=gast">Abmelden</a>
    <br>
    <br>
    <%
        if (session.getAttribute("BenutzerID") != null
                && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0) {

            Benutzer user = BenutzerDB.getById((Integer) session.getAttribute("BenutzerID"));

            if (user != null) {
    %>
    <center>
        <font size="1">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
            <jsp:param name="Formular" value="navigation"/>
            <jsp:param name="Textfeld" value="AngemeldetAls"/>
        </jsp:include>
        <%= DBtoHTML(user.getVorname())%>
        <%= DBtoHTML(user.getNachname())%>
        (<%= DBtoHTML(user.getGruppe().getBezeichnung())%>)
        </font>
    </center>
    <%
            }

        }
    %>
    <br>
    <jsp:include page="../forms/language.jsp">
        <jsp:param name="ID" value="<%= request.getParameter("ID")%>"/>
        <jsp:param name="title" value="<%= request.getParameter("title")%>"/>
    </jsp:include>
</div>
