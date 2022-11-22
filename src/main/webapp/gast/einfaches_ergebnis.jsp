<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>
<%@ include file="../group.jsp" %>



  <div>
    <form method="post" action="einfaches_ergebnis.jsp">



      <%
        if (  request.getParameter("form")!=null && request.getParameter("form").equals("einfache_suche") ) {
          %><%@ include file="suche/einfache_suche.jsp" %><%
        }
      %>


    </form>
  </div>
