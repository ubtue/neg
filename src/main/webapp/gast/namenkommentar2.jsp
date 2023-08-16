<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>
<%@ page import="java.util.Enumeration" isThreadSafe="false"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<%@ page import="com.lowagie.text.Document" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.*" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false"%>
<%@ page import="java.io.*" isThreadSafe="false"%>

<jsp:include page="../dofilter.jsp" />

<%
try {
      Language.setLanguage(request);
      Class.forName( sqlDriver );
      Connection cn = DriverManager.getConnection( sqlURL, sqlUser, sqlPassword );
      Statement st = cn.createStatement();

      ResultSet rs = st.executeQuery("SELECT DISTINCT Bezeichnung from gastnamenkommentar order by Bezeichnung");
      while ( rs.next()) {
        out.println(format(rs.getString("Bezeichnung"), "PLemma") + "<br> ");
      }
}    catch (Exception e) { }

%>
