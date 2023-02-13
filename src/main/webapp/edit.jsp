<%--
    Document   : gismo
    Created on : 30.01.2023, 09:45:22
    Author     : root
--%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="java.io.File"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.*"%>
<%@page import="java.nio.*"%>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>

<%    if (AuthHelper.isAdminLogin(request)) {

%>
<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="layout/tinymce/tinymce.min.js"></script>
        <script type="text/javascript">
            tinymce.init({
                selector: '#mytextarea',
                themes: 'modern',
                width: 1024,
                height: 600,

                plugins: ['template', 'emoticons', 'fullscreen', 'preview', 'print', 'image', 'print', 'insertdatetime', 'pagebreak', 'table', 'export', 'anchor', 'link', 'fontselect',
                    'searchreplace', 'visualblocks', 'visualchars', 'code', "advlist lists ", 'nonbreaking', 'charmap', 'wordcount'],

                contextmenu: "link | image | inserttable | cell row column deletetable",
                content_css: "layout/help.css",
                language: 'de',

                table_toolbar: 'tableprops tabledelete | tableinsertrowbefore tableinsertrowafter tabledeleterow | tableinsertcolbefore tableinsertcolafter tabledeletecol',

                toolbar: 'undo redo | styleselect | forecolor | backcolor | blockquote | bold italic | underline | link |  fontselect | fontsizeselect | formatselect | h1 h2 h3 h4| alignleft aligncenter alignright alignjustify |\n\
                numlist bullist | outdent | indent | copy | cut | paste | anchor |  emoticons | image | pagebreak | fullscreen | preview | visualblocks | visualchars | searchreplace | print | insertdatetime  | charmap | code',

            });

        </script>
    </head>
    <body>
        <%
              if (request.getParameter("speichern") != null) {
                  String jspPath = session.getServletContext().getRealPath("gast");
                  InputStream is = null;
                  OutputStream os = null;
                  try {
                      is = new FileInputStream(jspPath + "/hilfe.html");
                      os = new FileOutputStream(jspPath + "/hilfe_" + System.currentTimeMillis() + ".html");
                      byte[] buffer = new byte[1024];
                      int length;
                      while ((length = is.read(buffer)) > 0) {
                          os.write(buffer, 0, length);
                      }
                  } finally {
                      is.close();
                      os.close();
                  }

                  try {
                      String content = request.getParameter("area");

                      os = new FileOutputStream(jspPath + "/hilfe.html");
                      byte[] buffer = content.getBytes();
                      os.write(buffer);
                      os.flush();
                  } finally {
                      os.close();
                  }
              try{
                  //Save hilfe.html to the database
                  jspPath += "/hilfe.html";

                  String filename = "hilfe.html";
                  String contentType = "text/html";
                  //Delete first the old hilfe.html from database, then save the new version of hilfe.html to database
                    boolean available = TinyMCE_ContentDB.searchName(filename);
                    if(available)
                    {
                        TinyMCE_ContentDB.deleteByName(filename);
                    }

                    TinyMCE_ContentDB.saveFile(jspPath, filename, contentType);
            }
            catch(Exception e)
            {
              out.println("Error konnte hilfe.html nicht in die Datenbank speichern: " + e.toString());
            }
                  out.println("<span style=\"color:green\">Erfolgreich gespeichert</span>");
              }
        %>


        <form method="post">
            <%

               //When the page is accessed, the help.thml is copied from the database to a temporary folder and read from there

                String jspPath = session.getServletContext().getRealPath("gast") + "/";

                String name = "hilfe.html";
                TinyMCE_ContentDB.copyHTMLFromDatabaseTableToTempFolder(jspPath, name);


                String txtFilePath = jspPath + "hilfe.html";
                BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));
                StringBuilder sb = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    sb.append(line + "\n");
                }
                String myString = sb.toString();

            %>

            <textarea id="mytextarea" name="area">
                <%
                    out.println(DBtoHTML(myString));
                %>
            </textarea>

            <div style="display: flex;">
                <div style="margin-right: 10px;" method="post">
                    <input type="submit" name="speichern" value="speichern"/>
                </div>
                <a href="img?pictureAccess=1">Bild Verwaltung</a>
            </div>
        </form>
    </body>
</html>
<%
} else {
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