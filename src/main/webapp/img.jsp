<%@page import="de.uni_tuebingen.ub.nppm.util.AuthHelper"%>
﻿<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@ page import="org.apache.commons.fileupload.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.disk.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" isThreadSafe="false" %>
<%@ page import="org.apache.commons.fileupload.util.*" isThreadSafe="false" %>

<%@ include file="../configuration.jsp" %>
<%@ include file="../functions.jsp" %>


<%    if (AuthHelper.isAdminLogin(request)) {

%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="../javascript/funktionen.js"></script>
    </head>
    <body>

        <%
            String folder = "gast\\layout";
            out.println("<a href=\"edit\">Zurück zu TinyMce</a>");
            out.println("<h2>Bild hochladen</h2>");
            out.println("<form action=\"img?pictureAccess=1\" method=\"POST\" enctype=\"multipart/form-data\">");
            out.println("<input type=\"file\" name=\"file\">");
            out.println("<br/><br/>");
            out.println("<input type=\"submit\" value=\"hochladen\">");
            out.println("<input type=\"hidden\" name=\"pictureAccess\" >");
            out.println("</form>");

            if (ServletFileUpload.isMultipartContent(request)) {
                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload();

                // Parse the request
                FileItemIterator iter = upload.getItemIterator(request);
                out.println("Übertragung gestartet...");

                while (iter.hasNext()) {

                    FileItemStream item = iter.next();
                    String name = item.getFieldName();
                    InputStream stream = item.openStream();
                    if (!item.isFormField()) {

                        if (item.getContentType().startsWith("image") || item.getName().toLowerCase().endsWith("png")) {

                            String pathname = this.getServletContext().getRealPath("/") + "gast/layout/" + item.getName();

                            if ((new File(pathname)).exists()) {
                                // Datei existiert bereits -> Dateiname tauschen
                                out.println("<p>Datei existiert bereits!</p>");
                            } else {
                                // Datei existiert nicht und kann abgespeichert werden

                                // Stream in Datei schreiben
                                FileOutputStream file = new FileOutputStream(new File(pathname));
                                for (int data = stream.read(); data >= 0; data = stream.read()) {
                                    file.write(data);
                                }
                                file.close();
                                out.println("<p>Datei erfolgreich hochgeladen!</p>");
                            }
                        } else {
                            out.println("Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator");
                        }
                    }
                }
            }

            try {

                File[] files = new File(this.getServletContext().getRealPath("/") + "gast/layout/").listFiles();  //Versthen und üben !!!

                out.println("<table style=\"border-collapse:collapse;\"border=1><tr><th>Pfad</th><th>Abbildung</th><th>&nbsp;</th></tr>");

                if (files != null) {
                    for (int i = 0; i < files.length; i++) {
                        File file = files[i];
                        if (!file.isDirectory()) {

                            if (file.getName().toLowerCase().endsWith("png")
                                    || file.getName().toLowerCase().endsWith("jpg")
                                    || file.getName().toLowerCase().endsWith("jpeg")
                                    || file.getName().toLowerCase().endsWith("gif")) {
                                out.println("<tr><td>layout/" + file.getName() + "</td><td><img src=\"layout/" + file.getName() + "\" height=\"256px\"></td>");
                                out.println("<td><form method=\"post\" action=\"img?pictureAccess=1&deleteFile=1\"><input type=\"hidden\" name=\"filename\" value=\"" + file.getName() + "\"><input type=\"submit\" name=\"deleteFile\" value=\"l&ouml;schen\">  </form></td>");

                                out.println("</tr>");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                out.println("Error: " + e.toString());
            }

            try {
                String fileToDelete = "";
                if (request.getParameter("deleteFile") != null) {
                    if (request.getParameter("filename") != null) {
                        fileToDelete = request.getParameter("filename");

                        String pathname = this.getServletContext().getRealPath("/") + "gast/layout/" + fileToDelete;

                        File file = new File(pathname);
                        boolean fileIsDeleted = file.delete();
                        if (fileIsDeleted == true) {
                            out.println("<script>location.reload();</script>");
                           // response.setIntHeader("Refresh", 1);  //refresh page
                            out.println("<p>Bild " + fileToDelete + " erfolgreich gel&ouml;scht!</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println(e.toString());
            }
            out.println("</table>");
        %>
    </body>
</html>
<%} else {
%>
<p>
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
    </jsp:include>
</p>
<a href="index.jsp">
    <jsp:include page="../inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
    </jsp:include>
</a>
<%
    }
%>