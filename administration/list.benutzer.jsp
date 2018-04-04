<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;

  try {
    Class.forName( sqlDriver );
    cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
    st = cn.createStatement();
    rs = st.executeQuery("SELECT * FROM benutzer, benutzer_gruppe WHERE benutzer.GruppeID=benutzer_gruppe.ID ORDER BY istAktiv DESC, Nachname ASC, Vorname ASC");
    
    out.println("<ul class=\"mktree\" id=\"complete\">");
    out.println("  <li class=\"liOpen\" style=\"font-size:large\"><b>Aktive Benutzer</b>");
    
    boolean first=false;

    out.println("<ul><table>");
    out.println("<tr>");
    out.println("<th>ID</th>");
    out.println("<th>Nachname</th>");
    out.println("<th>Vorname</th>");
    out.println("<th>Login</th>");
    out.println("<th>E-Mail</th>");
    out.println("<th>Projektgruppe</th>");
    out.println("<th>Admin.</th>");
    out.println("<th>Sprache</th>");
    out.println("<th>Bearbeiten</th>");
    out.println("</tr>");
    while( rs.next() ) {
       if(!first && rs.getString("istAktiv").equals("0")){
      	first = true;
        out.println("</table></ul>");
        out.println("</li>");
        out.println("  <li class=\"liClosed\"  style=\"font-size:large\"><b>Inaktive Benutzer</b>");
      	out.println("<ul><table>");
        out.println("<tr>");
    	out.println("<th>ID</th>");
    	out.println("<th>Nachname</th>");
    	out.println("<th>Vorname</th>");
    	out.println("<th>Login</th>");
    	out.println("<th>E-Mail</th>");
    	out.println("<th>Projektgruppe</th>");
    	out.println("<th>Admin.</th>");
    	out.println("<th>Sprache</th>");
    	out.println("<th>Bearbeiten</th>");
    	out.println("</tr>");
       }
      
      out.println("<tr>");
      out.println("<td align=\"right\">"+DBtoHTML(rs.getString("id"))+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("Nachname"))+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("Vorname"))+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("Login"))+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("EMail"))+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("benutzer_gruppe.Bezeichnung"))+"</td>");
      out.println("<td>"+(rs.getInt("IstAdmin")==1?"JA":"&nbsp;")+"</td>");
      out.println("<td>"+DBtoHTML(rs.getString("Sprache"))+"</td>");
      out.println("<td><a href=\"einstellungen.jsp?ID=" + rs.getString("ID")+"\">&auml;ndern</a></td>");
      out.println("</tr>");
      
      
    }
    out.println("</table></ul></li>");
    out.println("</ul>");
  }
  finally {
    try { if( null != rs ) rs.close(); } catch( Exception ex ) {}
    try { if( null != st ) st.close(); } catch( Exception ex ) {}
    try { if( null != cn ) cn.close(); } catch( Exception ex ) {}
  }
%>