<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  if (request.getParameter("language") != null) {
    session = request.getSession(true);
    String language = null;

    try {
      language = (String) session.getAttribute("Sprache");
    }
    catch (Exception e) {}

    // Wenn neue Sprache per Parameter, dann in Session speichern
    try {
      if (language == null && request.getParameter("language") != null ||
          language != null && !language.equals(request.getParameter("language"))) {
        session.setAttribute("Sprache", request.getParameter("language"));
      }
    }
    catch (Exception e) {}
  }
%>