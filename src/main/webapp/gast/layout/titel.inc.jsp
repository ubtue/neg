<%@ include file="../../configuration.jsp" %>

<%
  int id = -1;
  String title = request.getParameter("title");

  //Filter berechnen
  session = request.getSession(true);
  int filter = 0;
  String filterParameter = null;
  try {
    filter = ((Integer) session.getAttribute("filter")).intValue();
    filterParameter = (String) session.getAttribute("filterParameter");
  }
  catch (Exception e) {}

  try {
    id = Integer.parseInt(request.getParameter("ID"));
  }
  catch (NumberFormatException e) {}


%>

<div class="ut-wrapper ut-wrapper--color-components-1" style="padding-top: 10px; padding-bottom: 10px;">
<div class="container" id="jump-to" >
<form method="post" >
<%
if(request.getParameter("title").equals("mgh_lemma")){
%>
    <button type="button" class="ut-btn ut-btn--outline " style="background-color: white;"  aria-label="gehe zu mghlemma" disabled>MGH-Lemma</button>
    <button type="button" class="ut-btn ut-btn--outline "  aria-label="gehe zu Namenlemma" onclick="window.location.href='namenkommentar?fromLemma=MGH-Lemma';">Namenlemma</button>

<%
}
if(request.getParameter("title").equals("namenkommentar")){
%>
    <button type="button" class="ut-btn ut-btn--outline "  aria-label="gehe zu Namenlemma" onclick="window.location.href='mghlemma?fromLemma=Namenlemma';">MGH-Lemma</button>
    <button type="button" class="ut-btn ut-btn--outline " style="background-color: white;"  aria-label="gehe zu mghlemma" disabled>Namenlemma</button>
<%
}
%>
<div id="jump-1" >
  <!------------Jump1------------>
  <jsp:include page="../forms/jumpID.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>
</div>
<div id="jump-2">
  <!------------Jump2------------>
  <jsp:include page="../forms/jump.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>
</div>
<div class="clear"></div>
</form>
</div>
</div>

<!------------prev-next------------>
<div class="pager-wrap">
  <jsp:include page="../forms/link.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="Command" value="first"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>

  <jsp:include page="../forms/link.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="Command" value="back"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>

    <!------------Eintraege------------>
  <span class="counter">
  <jsp:include page="../../forms/filter.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>
  Eintrag <jsp:include page="../../forms/counter.jsp">
      <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
      <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
      <jsp:param name="filter" value="<%= filter %>"/>
      <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
    </jsp:include>
    </span>

  <jsp:include page="../forms/link.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="Command" value="next"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>

  <jsp:include page="../forms/link.jsp">
    <jsp:param name="ID" value="<%= request.getParameter("ID") %>"/>
    <jsp:param name="title" value="<%= "gast_"+request.getParameter("title").toLowerCase() %>"/>
    <jsp:param name="Command" value="last"/>
    <jsp:param name="filter" value="<%= filter %>"/>
    <jsp:param name="filterParameter" value="<%= filterParameter %>"/>
  </jsp:include>
</div>



