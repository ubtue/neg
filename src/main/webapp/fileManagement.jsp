<%@page import="de.uni_tuebingen.ub.nppm.model.Content.Context"%>
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
        <%
            DatenbankTexte titel = DatenbankTexteDB.getText("fileManagement", "Titel");
            String value = "Nomen et Gens | " + titel.getDe();
            int id = 1;
        %>
        <title><%= value%></title>

        <style>

            .cell-padding {
                 padding-top: 5px;
                padding-bottom: 5px;
            }

            .full-width-button {
                display: block;
                width: 100%;
                margin-bottom: 2px;
                box-sizing: border-box;
            }
        </style>

    </head>
    <body>
        <div id="dynamicContentDiv">
            <%
                if (AuthHelper.isAdminLogin(request)) {

                    String context = "";
                    if (request.getParameter("context") != null) {
                        context = request.getParameter("context");
                    }

                    Content.Context contextEnum = null;
                    if (context.equals("HILFE")) {
                        contextEnum = Content.Context.HILFE;
                    } else if (context.equals("NAMENKOMMENTAR")) {
                        contextEnum = Content.Context.NAMENKOMMENTAR;
                    }
            %>
            <br>
            <form method="get">
                <select name="context" onchange="this.form.submit();">
                    <option value="">Context ausw&auml;hlen</option>
                    <option value="HILFE" <% if (contextEnum == Content.Context.HILFE) {
                            out.print("selected");
                        } %>>Hilfe</option>
                            <option value="NAMENKOMMENTAR" <% if (contextEnum == Content.Context.NAMENKOMMENTAR)
                            out.print("selected"); %>>Namenkommentar</option>
                </select>
            </form>

            <%
                try {
                    String fileToDelete = request.getParameter("filename");
                    boolean deleteConfirmation = (fileToDelete != null && !fileToDelete.isEmpty());
                    boolean showPage = (!context.isEmpty());
                    if (showPage) {

            %>
            <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
            <form action="file?context=<%=context%>&fileAccess=fileUpload" method="post" enctype="multipart/form-data">
                <input type="file" name="file[]" value="Datei auswahl" multiple>
                <br><br>
                <input type="submit" value="hochladen">
            </form>

            <table style="border-collapse:collapse;" border=1>
                <tr>
                    <th>Pfad</th>
                    <th>Load</th>
                    <th>&nbsp;</th>
                </tr>

                <%
                    List<Content> fileList = ContentDB.getList(contextEnum.toString());
                    for (Content content : fileList) {
                        if (content.getContent_Type().startsWith("text/html")) {
                            String name = content.getName();
                            String fileUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);

                %>
                <tr>
                    <td><a href="<%=fileUrl%>" target="_blank"><%=name%></a></td>
                    <td><a href="edit?loadFile=<%=name%>">Load in TinyMce</a></td>
                    <td class="cell-padding">
                        <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich l&ouml;schen?');">
                            <input  class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                            <input type="hidden" name="fileAccess" value="fileDelete">
                            <input type="hidden" name="id" value="<%=content.getID()%>">
                            <input type="hidden" name="context" value="<%=context%>">
                        </form>

                       <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                        <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich ersetzen?');" enctype="multipart/form-data">
                            <input type="file" name="file" value="Datei auswahl" >
                            <input  class="full-width-button" type="submit"  value ="Ersetzen">
                        </form>
                    </td>
                </tr>
                <%
                    }
                    if (content.getContent_Type().startsWith("text/plain") || content.getContent_Type().startsWith("application/vnd.oasis.opendocument.text")
                            || content.getContent_Type().startsWith("application/msword")
                            || content.getContent_Type().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")) {

                        String name = content.getName();
                        String fileUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);
                %>
                <tr>
                    <td><a href="<%=fileUrl%>" target="_blank"><%=name%></a></td>
                    <td></td>
                     <td class="cell-padding">
                        <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich l&ouml;schen?');">
                            <input class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                            <input type="hidden" name="fileAccess" value="fileDelete">
                            <input type="hidden" name="id" value="<%=content.getID()%>">
                            <input type="hidden" name="context" value="<%=context%>">
                        </form>

                        <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                        <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich ersetzen?');" enctype="multipart/form-data">
                            <input type="file" name="file" value="Datei auswahl" >
                            <input  class="full-width-button" type="submit"  value ="Ersetzen">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                    for (Content content : fileList) {
                        if (content.getContent_Type().startsWith("image")) {
                            String name = content.getName();
                            String imageUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);
                %>
                <tr>
                    <td><a href="<%=imageUrl%>" target="_blank"><%=name%></a></td>
                    <td><img src="<%=imageUrl%>" height="256px"></td>
                    <td class="cell-padding">
                        <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich l&ouml;schen?');">
                            <input class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                            <input type="hidden" name="fileAccess" value="fileDelete">
                            <input type="hidden" name="id" value="<%=content.getID()%>">
                            <input type="hidden" name="context" value="<%=context%>">
                        </form>

                        <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                        <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName() %> wirklich ersetzen?');" enctype="multipart/form-data">
                            <input type="file" name="file" value="Datei auswahl" >
                            <input  class="full-width-button" type="submit"  value ="Ersetzen">
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
            <%                        }//end showPage
                    } catch (Exception e) {
                        out.println("Error: " + e.toString());
                    }
                    out.println("</table>");
                }//end if (AuthHelper.isAdminLogin(request))
                else {
                    //Redirect to logout.jsp
                    response.sendRedirect("logout.jsp");
                }
            %>
        </div>
    </body>
</html>
