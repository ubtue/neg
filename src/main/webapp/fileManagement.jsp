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
<%@ include file="configuration.jsp" %>



<header>
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

        <style>
        .tab-container {
            display: flex;
        }

        .select-language {
            padding: 10px 20px;
            background-color: #f0f0f0;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .select-language.active {
            background-color: red;
            color: white;
        }
    </style>
</style>
</header>
<div id="dynamicContentDiv">
    <%        String language = (String) session.getAttribute("Sprache");
        int id = 1;
        String context = "";
        if (request.getParameter("context") != null) {
            context = request.getParameter("context");
        }

        Content.Context contextEnum = null;
        if (context.equals("HILFE")) {
            contextEnum = Content.Context.HILFE;
        } else if (context.equals("NAMENKOMMENTAR")) {
            contextEnum = Content.Context.NAMENKOMMENTAR;
        } else if (context.equals("QUELLENKOMMENTAR")) {
            contextEnum = Content.Context.QUELLENKOMMENTAR;
        } else if (context.equals("UEBERLIEFERUNGSKOMMENTAR")) {
            contextEnum = Content.Context.UEBERLIEFERUNGSKOMMENTAR;
        } else if (context.equals("CMS")) {
            contextEnum = Content.Context.CMS;
        }
    %>
    <br>
    <form method="get">
        <select name="context" onchange="this.form.submit();">
            <option value="">Context ausw&auml;hlen</option>
                    <option value="HILFE" <% if (contextEnum == Content.Context.HILFE) {
                    out.print("selected");
                } %>>Hilfe</option>
            <option value="NAMENKOMMENTAR" <% if (contextEnum == Content.Context.NAMENKOMMENTAR) {
                    out.print("selected");
                } %>>Namenkommentar</option>
            <option value="QUELLENKOMMENTAR" <% if (contextEnum == Content.Context.QUELLENKOMMENTAR) {
                    out.print("selected");
                } %>>Quellenkommentar</option>
            <option value="UEBERLIEFERUNGSKOMMENTAR" <% if (contextEnum == Content.Context.UEBERLIEFERUNGSKOMMENTAR) {
                    out.print("selected");
                } %>>Überlieferungskommentar</option>
            <option value="CMS" <% if (contextEnum == Content.Context.CMS) {
                    out.print("selected");
                } %>>Content Management System</option>
        </select>
    </form>
    <br>


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

    <br>

    <div class="tab-container">
        <button data-id="tab-1" class="select-language" type="button" aria-label="Deutsch" onclick="setLanguage('de')">
            Deutsch
        </button>

        <button data-id="tab-2" class="select-language" type="button" aria-label="Englisch" onclick="setLanguage('gb')">
            Englisch
        </button>

        <button data-id="tab-3" class="select-language" type="button" aria-label="Französisch" onclick="setLanguage('fr')">
            Französisch
        </button>

        <button data-id="tab-4" class="select-language" type="button" aria-label="Latein" onclick="setLanguage('la')">
            Latein
        </button>
    </div>

    <table style="border-collapse:collapse;" border=1>
        <tr>
            <th>Pfad</th>
            <th>Vorschau</th>
            <th>Aktionen</th>
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
            <td></td>
            <td class="cell-padding">
                <a href="edit?loadFile=<%=name%>">HTML Bearbeiten (TinyMCE)</a>

                <hr>

                <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich ersetzen?');" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl" >
                    <input  class="full-width-button" type="submit"  value ="Ersetzen">
                </form>

                <hr>

                <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich l&ouml;schen?');">
                    <input  class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                    <input type="hidden" name="fileAccess" value="fileDelete">
                    <input type="hidden" name="id" value="<%=content.getID()%>">
                    <input type="hidden" name="context" value="<%=context%>">
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
                <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich ersetzen?');" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl" >
                    <input  class="full-width-button" type="submit"  value ="Ersetzen">
                </form>

                <hr>

                <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich l&ouml;schen?');">
                    <input class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                    <input type="hidden" name="fileAccess" value="fileDelete">
                    <input type="hidden" name="id" value="<%=content.getID()%>">
                    <input type="hidden" name="context" value="<%=context%>">
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
                <!-- Attention with enctype="multipart/form-data" hidden' does not work; parameters can be sent through the URL file.?... -->
                <form  action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich ersetzen?');" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl" >
                    <input  class="full-width-button" type="submit"  value ="Ersetzen">
                </form>

                <hr>

                <form action="file" method="post" onsubmit="return confirm('Datei <%= content.getName()%> wirklich l&ouml;schen?');">
                    <input class="full-width-button" type="submit" name="deleteFile" value ="l&ouml;schen">
                    <input type="hidden" name="fileAccess" value="fileDelete">
                    <input type="hidden" name="id" value="<%=content.getID()%>">
                    <input type="hidden" name="context" value="<%=context%>">
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
    %>

    <script>
        function setLanguage(languageCode) {
            fetch('file?language_neu=' + languageCode, {
                method: 'POST',
                credentials: 'same-origin' // Sendet Cookies mit der Anforderung
            }).then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                // Sprachinformation in der Session speichern
                sessionStorage.setItem('language_neu', languageCode);
                console.log('Sprache erfolgreich festgelegt: ' + languageCode);
            }).catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
        }
    </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            let buttons = document.querySelectorAll('.select-language');

            // Funktion zum Aktivieren des Buttons basierend auf der Sprache
            function activateTabByLanguage(language_neu) {
                let tabId;
                // Sprachcode mit Tab-ID vergleichen und die entsprechende Tab-ID auswählen
                if (language_neu === 'de') {
                    tabId = 'tab-1';
                } else if (language_neu === 'gb') {
                    tabId = 'tab-2';
                } else if (language_neu === 'fr') {
                    tabId = 'tab-3';
                } else if (language_neu === 'la') {
                    tabId = 'tab-4';
                }

                // Aktiviere den entsprechenden Tab
                activateTab(tabId);
            }

            // Die Sprache aus der Session abrufen
            let language_neu = '<%= language%>';

            // Den entsprechenden Button aktivieren
            activateTabByLanguage(language_neu);

            function activateTab(tabId) {
                buttons.forEach(function (button) {
                    if (button.getAttribute('data-id') === tabId) {
                        button.classList.add('active');
                    } else {
                        button.classList.remove('active');
                    }
                });
            }

            buttons.forEach(function (button) {
                button.addEventListener('click', function () {
                    let tabId = this.getAttribute('data-id');
                    activateTab(tabId);
                });
            });
        });
    </script>
</div>