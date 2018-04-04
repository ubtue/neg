<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.util.Enumeration" isThreadSafe="false" %>
<%@ page import="java.util.Vector" isThreadSafe="false" %>

<%
  String formular = request.getParameter("form");

      out.println("<table class=\"date\">\n");
      out.println("<tr><th>Link</th><th>Belegform</th><th>Kontext</th></tr>\n");
      Connection cn = null;
      Statement  st = null;
      ResultSet  rs = null;
      try {
        Class.forName( sqlDriver );
        cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
        st = cn.createStatement();

        rs = st.executeQuery("SELECT eh2.NamenkommentarID"
                             +" FROM einzelbeleg_hatnamenkommentar eh2, einzelbeleg e2"
                             +" WHERE e2.Belegform='" +request.getParameter("Belegform")+"' AND eh2.EinzelbelegID=e2.ID");
        if(rs.next()){
           int id = rs.getInt("eh2.NamenkommentarID");
           rs = st.executeQuery("SELECT e1.ID, e1.Belegform, e1.Kontext"
                             +" FROM einzelbeleg_hatnamenkommentar eh1, einzelbeleg e1"
                             +" WHERE eh1.NamenkommentarID="+id+" AND eh1.EinzelbelegID=e1.ID");

         int count=0;
        while ( rs.next() ) {
        count++;
          if(count%2==0)out.println("<tr>");
          else out.println("<tr bgcolor='#AACCDD'>");

          out.println("<td><a href=\"einzelbeleg.jsp?ID="+rs.getInt("e1.ID")+"\">Beleg...</a></td>");
          out.println("<td>"+(rs.getString("e1.Belegform")==null?"&nbsp;":rs.getString("e1.Belegform"))+"</td>");
          out.println("<td>"+(rs.getString("e1.Kontext")==null?"&nbsp;":rs.getString("e1.Kontext"))+"</td>");
          out.println("</tr>");
        }
        }
      }
      catch (Exception e) {
        out.println(e);
      }
      out.println("</table>\n");

%>