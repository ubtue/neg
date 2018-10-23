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
        <jsp:param name="Textfeld" value="ErfolgreichAusgelogt"/>
      </jsp:include>
    </p>
    <!-- <a href="index1.jsp">
      <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
      </jsp:include>
    </a> -->
    <% if(ziel == null || ziel.equals("intern")) { %>
    	<script>window.location = 'index1.jsp';</script>
    <% } else { %>
    	<script>window.location = '.';</script>
  	<% }
  }
%>
