<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
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

<!------------prev-next------------>
<div class="container" style="display: flex; justify-content: center; padding-top: 10px ">

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
      <% Language.printTextfield(out, session, "titel_inc", "Eintrag");%>
  <jsp:include page="../../forms/counter.jsp">
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
