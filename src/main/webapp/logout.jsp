<%
  if (session != null) {
    String sprache = (String) session.getAttribute("Sprache");
    session.invalidate();

    session = request.getSession(true);
    session.setAttribute("Sprache", sprache);

    String ziel = request.getParameter("go"); // "intern" oder "gast"
  %>
    <p>
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="login"/>
        <jsp:param name="Textfeld" value="ErfolgreichAusgeloggt"/>
      </jsp:include>
    </p>
    <!-- <a href="login">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a> -->
    <% if(ziel == null || ziel.equals("intern")) { %>
    	<script>window.location = 'login';</script>
    <% } else { %>
    	<script>window.location = '.';</script>
  	<% }
  }
%>
