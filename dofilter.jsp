<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
  session = request.getSession(true);
  int filter = 0;
  String filterParameter = "";
  
      String form = request.getParameter("form");
      
  //    out.println(form);
  
  
  if(session.getAttribute(form+"filterParameter")==null)session.setAttribute(form+"filterParameter", "");

  try {
    filter = ((Integer) session.getAttribute(form+"filter")).intValue();
    filterParameter = (String) session.getAttribute(form+"filterParameter");
  }
  catch (Exception e) {}

  boolean newFilter = false;
  // Wenn neuer Filter per Parameter, dann in Session speichern
  try {
    if (filter != Integer.parseInt(request.getParameter("filter"))) {
  //    out.println(filter + "::" + request.getParameter("filter"));
      filter = Integer.parseInt(request.getParameter("filter"));
      session.setAttribute(form+"filter", new Integer(filter));
      newFilter = true;
    }
    if (filterParameter == null && request.getParameter("filterParameter") != null ||
        filterParameter != null && !filterParameter.equals(request.getParameter("filterParameter"))) {
  //    out.println(filterParameter + "::" + request.getParameter("filterParameter"));
      filterParameter = request.getParameter("filterParameter");
      session.setAttribute(form+"filterParameter", filterParameter);
      newFilter = true;
    }
    if (filter==0)
      filterParameter = null;
    session.setAttribute(form+"filterParameter", filterParameter);
    if(newFilter && filter!=0)      out.println("<script type=\"text/javascript\">location.replace('"+request.getRequestURL()+"')</script>");
    
  }
  catch (Exception e) {}
%>