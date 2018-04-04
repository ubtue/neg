<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>

<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.nio.charset.Charset"%>

<%
 
    String query = request.getParameter("q");
    String form = request.getParameter("form");
    String field = request.getParameter("field");
    
    Connection cn = null;
    Statement  st = null;
    ResultSet  rs = null;

    try {

      Class.forName( sqlDriver );
      cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      st = cn.createStatement();
      
  //    st.executeUpdate("set character set utf8;");
    
 
      String sql= "";
      sql = "Select distinct "+field+" from " + form;
      if(!query.equals("?")) sql +=" where "+field+" like '%"+query+"%' ";
      sql += " order by " + field;
      
      List<String> matched = new ArrayList<String>();
	  rs = st.executeQuery(sql);
	  while ( rs.next() ) {
	     matched.add(rs.getString(field));
	  }
	  
	      Charset csets = Charset.forName("UTF-8");

	  
 
      Iterator<String> iterator = matched.iterator();
      while(iterator.hasNext()) {
         String country = (String)iterator.next();
         out.println(new String(country.getBytes("UTF-8"), "ISO-8859-1"));
      }
      
   }catch(Exception ex2){}
    
%>