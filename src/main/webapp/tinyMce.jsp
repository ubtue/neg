<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="java.io.File"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
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
        <%
            DatenbankTexte titel = DatenbankTexteDB.getText("tinyMce", "Titel");
            String value = "Nomen et Gens | " + titel.getDe();

        %>
        <title><%= value%></title>
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
            String helpFileName = request.getParameter("loadFile").toString();

            if (request.getParameter("speichern") != null) {
                String html = request.getParameter("area");

                Content content = ContentDB.getByName(helpFileName);
                byte[] htmlBytes = html.getBytes(java.nio.charset.StandardCharsets.UTF_8);
                content.setContent(htmlBytes);
                ContentDB.saveOrUpdate(content);
                out.println("<span style=\"color:green\">Erfolgreich gespeichert</span>");
            }

            Content content = ContentDB.getByName(helpFileName);
            byte[] htmlBytes = content.getContent();
            String utf8String = new String(htmlBytes, java.nio.charset.StandardCharsets.UTF_8);

        %>

        <form method="post">
            <textarea id="mytextarea" name="area">
                <%                    out.println(utf8String);
                %>
            </textarea>

            <div style="display: flex;">
                <div style="margin-right: 10px;" method="post">
                    <input type="submit" name="speichern" value="speichern"/>
                </div>

                <a href="file" style="margin-right: 10px;">Datei <%= DBtoHTML("&")%> Bild Verwaltung</a>
            </div>
        </form>
    </body>
</html>
<%
    } else {
        // Weiterleitung zur logout.jsp
        response.sendRedirect("logout.jsp");
    }
%>