<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.ContentDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Utils"%>
<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankSprache" isThreadSafe="false" %>

<!DOCTYPE html>
<HTML>
    <HEAD>
        <TITLE>
            NPPM | <% Language.printTextfield(out, session, "login", "Datenvereinbarung"); %>
        </TITLE>
        <link rel="stylesheet" href="<%=Utils.getVersionedHref(request, application, "/layout/layout.css")%>" type="text/css">
        <link rel="stylesheet" href="<%=Utils.getVersionedHref(request, application, "/gast/layout/login.css")%>" type="text/css">
    </HEAD>
    <BODY>
        <div class="flexbox-container" >
            <form action="login" method="post">
                <%

                    String html = ContentDB.loadHtmlContent("dataagreement.html", "gb");
                    if (session.getAttribute("Sprache").equals("de")) {
                        html = ContentDB.loadHtmlContent("dataagreement.html", "de");
                    } else if(session.getAttribute("Sprache").equals("fr")){
                        html = ContentDB.loadHtmlContent("dataagreement.html", "gb"); // For safety, use English in case a French file was accidentally created in the CMS.
                    } else if(session.getAttribute("Sprache").equals("la")){          // If it actually should be French, change to "fr" here.
                        html = ContentDB.loadHtmlContent("dataagreement.html", "gb"); // For safety, use English in case a Latin file was accidentally created in the CMS.
                    }                                                                 // If it actually should be Latin, change to "la" here.

                    request.getSession().setAttribute("Sprache", session.getAttribute("Sprache"));
                %>

                <%= html%>

                <input type="hidden" name="username" value="<%= session.getAttribute("username")%>">
                <input type="hidden" name="password" value="<%= session.getAttribute("password")%>">
                <button type="submit" name="setDataAgreed"  value="true"><% Language.printTextfield(out, session, "login", "Zustimmen"); %></button>
                <button type="button" onclick="window.location.href = '<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=start'"><% Language.printTextfield(out, session, "admin", "Abbrechen"); %></button>
            </form>
        </div>
    </BODY>
