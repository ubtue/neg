<%@page import="de.uni_tuebingen.ub.nppm.model.Content"%>
<%@page import="java.util.List"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@page import="org.apache.commons.fileupload.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.disk.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.servlet.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.util.*" isThreadSafe="false" %>

<%
    //When the page is accessed, the help.html is read from the database
    String myFile = "projekte.html";
    Content content = ContentDB.getByName(myFile);
    byte[] htmlBytes = content.getContent();
    String utf8String = new String(htmlBytes, java.nio.charset.StandardCharsets.UTF_8);
    out.println(utf8String);
%>