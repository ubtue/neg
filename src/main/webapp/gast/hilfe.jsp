<%@page import="de.uni_tuebingen.ub.nppm.model.TinyMCE_Content"%>
<%@page import="java.util.List"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
﻿<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@page import="org.apache.commons.fileupload.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.disk.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.servlet.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.util.*" isThreadSafe="false" %>

<%
               //When the page is accessed, the help.thml is copied from the database to a temporary folder and read from there

                String jspPath = session.getServletContext().getRealPath("gast") + "/";

                String name = "hilfe.html";
                boolean available = TinyMCE_ContentDB.searchName(name);
                if(available)
                {
                    TinyMCE_ContentDB.copyHTMLFromDatabaseTableToTempFolder(jspPath, name);
                }
                else
                {
                    out.println("Error: Datei " + name + " ist nicht vorhanden");
                }

                String txtFilePath = jspPath + "hilfe.html";
                BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));
                StringBuilder sb = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    sb.append(line + "\n");
                }
                String myString = sb.toString();

            %>
<jsp:include page="hilfe.html" />



