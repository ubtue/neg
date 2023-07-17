<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  int id = -1;
  String title = request.getParameter("title");
  String guest = "";
  if (title.contains("gast_")) {
    title = title.substring(5);
    guest = "gast_";
  }
  int filter = 0;
  String filterParameter = request.getParameter("filterParameter");

  try {
    id = Integer.parseInt(request.getParameter("ID"));
    filter = Integer.parseInt(request.getParameter("filter"));
  } catch (NumberFormatException e) {}
%>
    <select name="jumpType">
      <option value="1">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
          <jsp:param name="Formular" value="jump"/>
          <jsp:param name="Textfeld" value="vor"/>
        </jsp:include>
      </option>
      <option value="-1">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
          <jsp:param name="Formular" value="jump"/>
          <jsp:param name="Textfeld" value="zurück"/>
        </jsp:include>
      </option>
      <option value="0">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
          <jsp:param name="Formular" value="jump"/>
          <jsp:param name="Textfeld" value="zu"/>
        </jsp:include>
      </option>
    </select>
    <input type="text" name="jumpValue" size="5">
    <input type="hidden" name="jumpTable" value="<%= title %>">
    <input type="hidden" name="akt" value="<%= id %>">
    <input type="submit" name="jump" value="los">
