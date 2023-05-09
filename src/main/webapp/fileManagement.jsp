<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@page import="org.apache.commons.fileupload.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.disk.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.servlet.*" isThreadSafe="false" %>
<%@page import="org.apache.commons.fileupload.util.*" isThreadSafe="false" %>
<%@include file="functions.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try {
                out.println("<h2>Html Dateien & Bilder verwalten</h2>");
                out.println("<form action=\"file?fileAccess=1\" method=\"POST\" enctype=\"multipart/form-data\">");
                out.println("<input type=\"file\" name=\"file\">");
                out.println("<br/><br/>");
                out.println("<input type=\"submit\" value=\"hochladen\">");
                out.println("<input type=\"hidden\" name=\"fileAccess\" >");
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

                            if (item.getContentType().startsWith("text/html") || item.getContentType().startsWith("image")) {

                                String pathname = this.getServletContext().getRealPath("/") + item.getName();

                                String fileName = item.getName().toString();

                                boolean fileExists = TinyMCE_ContentDB.searchName(fileName);

                                if (fileExists == true) {

                                    out.println("<p>Datei existiert bereits!</p>"); //hier pop up window
                                } else {

                                    // Write stream to file
                                    FileOutputStream file = new FileOutputStream(new File(pathname));
                                    for (int data = stream.read(); data >= 0; data = stream.read()) {
                                        file.write(data);
                                    }
                                    file.close();

                                    //Now copy from temp folder to database/table
                                    TinyMCE_ContentDB.saveFile(pathname, fileName, contentType);

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
                <th>Load</th>
                <th>&nbsp;</th>
            </tr>

            <%                     List<TinyMCE_Content> fileList = TinyMCE_ContentDB.getList();

                for (TinyMCE_Content content : fileList) {
                    if (content.getContent_Type().startsWith("text/html")) {
                        String name = content.getName();
                        String fileUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);

            %>
            <tr>
                <td><a href="<%=fileUrl%>" target="_blank"><%=name%></a></td>
                <td><a href="edit?loadFile=<%=name%>">Load in TinyMce</a></td>
                <td>
                    <form action="file?fileAccess=fileDelete&filename=<%=name%>"  method="post" enctype="multipart/form-data">
                        <input type="submit" name="deleteFile" value ="l&ouml;schen">
                    </form>
                </td>
            </tr>
            <%
                    }
                }
                for (TinyMCE_Content content : fileList) {
                    if (content.getContent_Type().startsWith("image")) {
                        String name = content.getName();
                        String imageUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);

            %>
            <tr>
                <td><a href="<%=imageUrl%>" target="_blank"><%=name%></a></td>
                <td><img src="<%=imageUrl%>" height="256px"></td>
                <td>
                    <form action="file?fileAccess=fileDelete&filename=<%=name%>"  method="post" enctype="multipart/form-data">
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
