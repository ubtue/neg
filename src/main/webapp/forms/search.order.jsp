<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%
  Connection cn = null;
  Statement st = null;
  ResultSet rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT Textfeld FROM datenbank_texte WHERE Formular='freie_suche' AND Textfeld LIKE \"Order%\" order by Textfeld");

    String radio = request.getParameter("name")+"ASCDESC";
    String zeitraum = request.getParameter("name")+"zeit";

    out.println("<select name=\""+request.getParameter("name")+"\">");
    out.println("  <option value=\"-1\">--</option>");
    while (rs.next()) {
%>
      <option value="<%= rs.getString("Textfeld") %>">
        <jsp:include page="../inc.erzeugeBeschriftung.jsp">
          <jsp:param name="Formular" value="freie_suche"/>
          <jsp:param name="Textfeld" value="<%= rs.getString("Textfeld") %>"/>
        </jsp:include>
      </option>
<%
    }
    out.println("</select>");
%>
    <input type="radio" name="<%= radio %>" value="ASC" checked/>
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="freie_suche"/>
      <jsp:param name="Textfeld" value="SortierungASC"/>
    </jsp:include>
    &nbsp;
    <input type="radio" name="<%= radio %>" value="DESC" />
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
      <jsp:param name="Formular" value="freie_suche"/>
      <jsp:param name="Textfeld" value="SortierungDESC"/>
    </jsp:include>
    <br>Zeitraum (nur für Datierung): <input type="text" name="<%= zeitraum %>" />     
    
    
<%
  }
  catch (SQLException e) {out.println(e);}
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>
