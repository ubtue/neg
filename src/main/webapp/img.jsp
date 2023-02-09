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
<%@include file="functions.jsp" %>

<%    if (AuthHelper.isAdminLogin(request)) {

%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="../javascript/funktionen.js"></script>
    </head>
    <body>

        <%
            try {
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

                        String contentType = item.getContentType();

                        if (!item.isFormField()) {

                            if (item.getContentType().startsWith("image") || item.getName().toLowerCase().endsWith("png")) {

                                String pathname = this.getServletContext().getRealPath("/") + "layout/" + item.getName();
                                String pictureName = item.getName().toString();

                                boolean pictureExists = TinyMCE_ContentDB.searchName(pictureName);

                                if (pictureExists == true) {

                                    out.println("<p>Datei existiert bereits!</p>"); //hier pop up window
                                } else {

                                    // Write stream to file
                                    FileOutputStream file = new FileOutputStream(new File(pathname));
                                    for (int data = stream.read(); data >= 0; data = stream.read()) {
                                        file.write(data);
                                    }
                                    file.close();

                                    //Now copy from temp folder to database/table
                                    TinyMCE_ContentDB.saveFile(pathname, pictureName, contentType);

                                    //Now delete the temporary file again
                                    File myObj = new File(pathname);
                                    myObj.delete();

                                    out.println("<p>Datei erfolgreich hochgeladen!</p>");
                                }
                            } else {
                                out.println("Dateityp nicht erlaubt. Bitte wenden Sie sich an den Administrator");
                            }
                        }
                    }
                }
            } catch (Exception e) {
                out.println("Error: " + e.toString());
            }

            try {

        %>

        <table style="border-collapse:collapse;" border=1>
            <tr>
                <th>Pfad</th>
                <th>Abbildung</th>
                <th>&nbsp;</th>
            </tr>

            <%                     List<TinyMCE_Content> pictureList = TinyMCE_ContentDB.getList();

                for (TinyMCE_Content content : pictureList) {
                    if (content.getContent_Type().startsWith("image")) {
                        String name = content.getName();
                        String imageUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);

            %>
                        <tr>
                            <td><a href="<%=imageUrl%>" target="_blank"><%=name%></a></td>
                            <td><img src="<%=imageUrl%>" height="256px"></td>
                            <td>
                                <form action="img?pictureAccess=pictureDelete&filename=<%=name%>"  method="post" enctype="multipart/form-data">
                                    <input type="submit" name="deleteFile" value ="l&ouml;schen">
                                </form>
                            </td>
                        </tr>
            <%
                    }
                }

            %>

        </table>

        <%                      } catch (Exception e) {
                out.println("Error: " + e.toString());
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