<%@page import="com.google.gson.Gson"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Content.Context"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.*"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
</header>

<div id="dynamicContentDiv">
    <% String language = (String) session.getAttribute("Sprache");
        int id = 0;
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
    <form method="get" id="contextForm" onchange="this.submit();">
        <select name="context">
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
                List<Integer> ids = new ArrayList<>(); // IDs-Liste initialisieren
    %>
    <form action="file?context=<%=context%>&fileAccess=fileUpload" method="post" enctype="multipart/form-data">
        <input type="file" name="file[]" value="Datei auswahl" multiple>
        <br><br>
        <input type="submit" value="hochladen">
    </form>
    <br>

    <div class="tab-container">
        <button data-language="de" class="select-language" type="button" aria-label="Deutsch" onclick="setLanguage('de')">Deutsch</button>
        <button data-language="gb" class="select-language" type="button" aria-label="Englisch" onclick="setLanguage('gb')">Englisch</button>
        <button data-language="fr" class="select-language" type="button" aria-label="Französisch" onclick="setLanguage('fr')">Französisch</button>
        <button data-language="la" class="select-language" type="button" aria-label="Latein" onclick="setLanguage('la')">Latein</button>
    </div>

    <table style="border-collapse:collapse;" border="1">
        <tr>
            <th>Pfad</th>
            <th>Vorschau</th>
            <th>Aktionen</th>
        </tr>

        <%
            List<Content> fileList = ContentDB.getList(contextEnum.toString());
            for (Content content : fileList) {
                if (content.getContent_Type().startsWith("text/html")) {
                    Content firstResult = ContentDB.getFirstResultByName(content.getName());
                    if (firstResult != null && firstResult.getID() == content.getID()) {
                        String name = content.getName();
                        String fileUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);
                        id++;
                        ids.add(id); // ID zur Liste hinzufügen
%>


        <tr>
            <td>
                <a id="fileLink_<%=id%>" style="display: none;" href="<%=fileUrl%>" target="_blank"><%=name%></a>
                <p id="fileParagraph_<%=id%>" style="display: none;"><%=name%></p>
            </td>
            <td></td>
            <td class="cell-padding">
                <form name="formFileLanguage_<%=id%>">
                    <input type="hidden" name="content_name" value="<%=name%>">
                    <input type="hidden" name="content_language" value="de">
                    <input type="submit" style="display:none;">
                </form>
                <button id="createFileButton_<%=id%>" style="display: none;">Datei erstellen</button>
                <a id="showTinyLink_<%=id%>" style="display: none;" href="edit?loadFile=<%=name%>">HTML Bearbeiten (TinyMCE)</a>
                <hr>
                <form id="chooseFileForm_<%=id%>" style="display: none;" action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirmReplace();" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl">
                    <input class="full-width-button" type="submit" value="Ersetzen">
                    <input type="hidden" id="contentNameReplace" value="<%= content.getName() %>">
                </form>
                <hr>
                <form id="deleteFileForm_<%=id%>" style="display: none;"  action="file" method="post" onsubmit="return confirmDelete();">
                    <input class="full-width-button" type="submit" name="deleteFile" value="l&ouml;schen">
                    <input type="hidden" name="fileAccess" value="fileDelete">
                    <input type="hidden" name="id" value="<%=content.getID()%>">
                    <input type="hidden" name="context" value="<%=context%>">
                    <input type="hidden" id="contentName" value="<%= content.getName() %>">
                </form>
            </td>
        </tr>
        <%
            }
        } else if (content.getContent_Type().startsWith("text/plain") || content.getContent_Type().startsWith("application/vnd.oasis.opendocument.text")
                || content.getContent_Type().startsWith("application/msword") || content.getContent_Type().startsWith("application/vnd.openxmlformats-officedocument.wordprocessingml.document")) {
            String name = content.getName();
            String fileUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);
        %>
        <tr>
            <td><a href="<%=fileUrl%>" target="_blank"><%=name%></a></td>
            <td></td>
            <td class="cell-padding">
                <form action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%=content.getName()%> wirklich ersetzen?');" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl">
                    <input class="full-width-button" type="submit" value="Ersetzen">
                </form>
                <hr>
                <form action="file" method="post" onsubmit="return confirm('Datei <%=content.getName()%> wirklich l&ouml;schen?');">
                    <input class="full-width-button" type="submit" name="deleteFile" value="l&ouml;schen">
                    <input type="hidden" name="fileAccess" value="fileDelete">
                    <input type="hidden" name="id" value="<%=content.getID()%>">
                    <input type="hidden" name="context" value="<%=context%>">
                </form>
            </td>
        </tr>
        <%
                }
            }
            String idsJson = new Gson().toJson(ids);
        %>

        <input type="hidden" id="idsArray" value="<%= idsJson%>">
        <%

            for (Content content : fileList) {
                if (content.getContent_Type().startsWith("image")) {
                    String name = content.getName();
                    String imageUrl = Utils.getBaseUrl(request) + "/content?name=" + urlEncode(name);
        %>
        <tr>
            <td><a href="<%=imageUrl%>" target="_blank"><%=name%></a></td>
            <td><img src="<%=imageUrl%>" height="256px"></td>
            <td class="cell-padding">
                <form action="file?context=<%=context%>&fileAccess=fileReplace&id=<%=content.getID()%>" method="post" onsubmit="return confirm('Datei <%=content.getName()%> wirklich ersetzen?');" enctype="multipart/form-data">
                    <input type="file" name="file" value="Datei auswahl">
                    <input class="full-width-button" type="submit" value="Ersetzen">
                </form>
                <hr>
                <form action="file" method="post" onsubmit="return confirm('Datei <%=content.getName()%> wirklich l&ouml;schen?');">
                    <input class="full-width-button" type="submit" name="deleteFile" value="l&ouml;schen">
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
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.toString());
        }
    %>

    <script>
        var idsJsonString = document.getElementById('idsArray').value;
        var ids = JSON.parse(idsJsonString);

        // Jetzt kannst du die IDs in JavaScript verwenden
        console.log(ids); // Zum Beispiel, um die IDs in der Konsole anzuzeigen

        function updateButtons(answer, id) {
            if (answer === "true") {
                document.getElementById("createFileButton_" + id).style.display = "none";
                document.getElementById("showTinyLink_" + id).style.display = "inline-block";
                document.getElementById("chooseFileForm_" + id).style.display = "inline-block";
                document.getElementById("deleteFileForm_" + id).style.display = "inline-block";
                document.getElementById("fileLink_" + id).style.display = "inline-block";
                document.getElementById("fileParagraph_" + id).style.display = "none";


            } else {
                document.getElementById("createFileButton_" + id).style.display = "inline-block";
                document.getElementById("showTinyLink_" + id).style.display = "none";
                document.getElementById("chooseFileForm_" + id).style.display = "none";
                document.getElementById("deleteFileForm_" + id).style.display = "none";
                document.getElementById("fileLink_" + id).style.display = "none";
                document.getElementById("fileParagraph_" + id).style.display = "inline-block";
            }
        }

        function setLanguage(languageCode) {
            document.cookie = "selectedLanguage=" + languageCode;
        }

        function activateTab(tabLanguage) {
            document.querySelectorAll('.select-language').forEach(function (button) {
                if (button.getAttribute('data-language') === tabLanguage) {
                    button.classList.add('active');
                } else {
                    button.classList.remove('active');
                }
            });
        }

        document.querySelectorAll('.select-language').forEach(function (button) {
            button.addEventListener('click', function () {
                let languageCode = this.getAttribute('data-language');
                activateTab(languageCode);
                setLanguage(languageCode);
                ids.forEach(function (id) {
                    take_values(languageCode, id);
                });
            });
        });

        function take_values(content_language, id) {
            let n = document.forms["formFileLanguage_" + id]["content_name"].value;
            if (n == null || n == "") {
                alert("Please enter a value");
                return false;
            } else {
                var http = new XMLHttpRequest();
                http.open("POST", "berechne", true);
                http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                var params = "param1=" + encodeURIComponent(n) + "&param2=" + encodeURIComponent(content_language);
                http.send(params);
                http.onload = function () {
                    let answer = http.responseText;
                    updateButtons(answer, id);
                };
            }
        }

        function setContextCookie() {
            var selectElement = document.getElementById('contextSelect');
            var selectedContext = selectElement.value;

            // Prüfen, ob sich der ausgewählte Kontext geändert hat
            var previousContext = getCookie('selectedContext');
            if (selectedContext !== previousContext) {
                document.cookie = "selectedContext=" + selectedContext + "; path=/";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            let languageCookie = getCookie("selectedLanguage");
            if (!languageCookie) {
                languageCookie = 'de';
            }
            activateTab(languageCookie);
            setLanguage(languageCookie);
            ids.forEach(function (id) {
                take_values(languageCookie, id);
            });
        });

        function getCookie(name) {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i].trim();
                if (cookie.startsWith(name + '=')) {
                    return cookie.substring(name.length + 1);
                }
            }
            return null;
        }

        function confirmDelete() {
            // Abrufen des aktuellen Werts des Cookies
            var selectedLanguage = getCookie('selectedLanguage');

            // Abrufen des Namens des Inhalts aus dem versteckten HTML-Element
            var contentName = document.getElementById('contentName').value;

            // Anzeigen des Bestätigungsfensters mit dem aktuellen Wert des Cookies und dem Namen des Inhalts
            return confirm('Datei ' + contentName + ' (' + selectedLanguage + ') wirklich löschen?');
        }

        function confirmReplace() {
            // Abrufen des aktuellen Werts des Cookies
            var selectedLanguage = getCookie('selectedLanguage');

            // Abrufen des Namens des Inhalts aus dem versteckten HTML-Element
            var contentName = document.getElementById('contentNameReplace').value;

            // Anzeigen des Bestätigungsfensters mit dem aktuellen Wert des Cookies und dem Namen des Inhalts
            return confirm('Datei ' + contentName + ' (' + selectedLanguage + ') wirklich ersetzen?');
        }
    </script>
</div>
