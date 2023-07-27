<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
    int id = -1;
    String title = request.getParameter("title");
    if (title.contains("gast_")) {
        title = title.substring(5);
    }

    try {
        id = Integer.parseInt(request.getParameter("ID"));
    } catch (NumberFormatException e) {
    }
%>
<span>Springe zu NeG-ID:</span>
<input type="text" name="jumpValueID" size="5">
<input type="hidden" name="jumpTable" value="<%= title%>">
<input type="hidden" name="akt" value="<%= id%>">
<input type="submit" name="jumpID" value="los">
