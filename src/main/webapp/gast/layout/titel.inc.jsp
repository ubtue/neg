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

<div id="jump-to-wrap">
<div id="jump-to">
<form method="post" >
<%
if(request.getParameter("title").equals("mgh_lemma")){
	  out.println("<div style='display: inline-block;padding:0px;margin-right: 40px;  border: 1px solid #999;background: #cccccc;'><div style='border: 1px solid #666;box-shadow: 2px 2px #999;display: inline-block;margin-right:5px;padding:7px;z-index:1;background: #fff;font-weight:bold;'>Lemma</div><div style='box-shadow: -1px -1px #ccc inset;z-index:50;display: inline-block;margin:0px;padding:5px;background: #ccc;'><a href='namenkommentar?fromLemma=MGH-Lemma' style='color:#666;text-decoration:none;font-weight:normal;'>Philologisches-Lemma</a></div></div>");
}
if(request.getParameter("title").equals("namenkommentar")){
	  out.println("<div style='display: inline-block;padding:0px;margin-right: 40px;  border: 1px solid #999;background: #cccccc;'><div style='box-shadow: -1px -1px #ccc inset;z-index:50;display: inline-block;margin:0px;padding:5px;background: #ccc;'><a href='mghlemma?fromLemma=Namenlemma' style='color:#666;text-decoration:none;font-weight:normal;'>Lemma</a></div><div style='border: 1px solid #666;box-shadow: 2px 2px #999;display: inline-block;margin-left:5px;padding:7px;z-index:1;background: #fff;font-weight:bold;'>Philologisches-Lemma</div></div>");
}
%>
<div id="jump-1">
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



