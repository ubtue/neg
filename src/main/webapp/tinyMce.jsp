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

<header>
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
</header>
<jsp:include page="layout/titel.inhalt.jsp" />
<div id="form">
    <%        String helpFileName = request.getParameter("loadFile");
        String selectedLanguage = ContentDB.getCookieLanguage(request);

        Content content = ContentDB.getByNameAndLanguage(helpFileName, selectedLanguage);
        byte[] htmlBytes = content.getContent();
        String utf8String = new String(htmlBytes, java.nio.charset.StandardCharsets.UTF_8);


    %>

    <form method="post" action="edit">
        <textarea id="mytextarea" name="htmlContent">
            <%= utf8String%>
        </textarea>
        <input type="hidden" name="tinyFileName" value="<%= helpFileName%>">
        <input type="hidden" name="tinyLanguage" value="<%= selectedLanguage%>">

        <div style="display: flex;">
            <div style="margin-right: 10px;">
                <input class="full-width-button" type="submit" value="speichern">
                <input type="hidden" name="htmlFileAccess" value="HtmlSaveToDatabase">
            </div>
            <a href='file?context=<%=content.getContext() %>' style="margin-right: 10px;">Datei <%= DBtoHTML("&")%> Bild Verwaltung</a>
        </div>
    </form>
</div>

