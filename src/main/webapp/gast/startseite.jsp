<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Utils"%>
<%@ include file="../functions.jsp" %>

<%    if (session.getAttribute("Sprache").equals("de")) {

%>
<h1 class="ut-heading ut-heading--h1">Herzlich willkommen bei der Datenbank</h1>
<h1 class="ut-heading ut-heading--h1">"<%= DBtoHTML(Language.getTextfield(session, "logo", "NPPM")) %>"!</h1>

<p>Die Datenbank bietet Ihnen historisch und linguistisch bearbeitete Quellenbelege zu Namen und Personen des
    fr&uuml;hmittelalterlichen Kontinentaleuropa. Suchen Sie nach Namen, Personen, Quellen oder Einzelbelegen
    (konkreten Namensnennungen in einer Quelle).
</p>

<p><a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/einfaches_ergebnis">Hier</a> k&ouml;nnen Sie die Datenbank durchsuchen,
    f&uuml;r komplexere Suchanfragen wechseln Sie bitte zur
    <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/freie_suche">erweiterten Suche</a>.
    Eine ausf&uuml;hrliche Beschreibung der Datenbank und der Suchm&ouml;glichkeiten finden Sie unter
    <a class="ut-link"  href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=hilfe">Hilfe</a>.
</p>

<p>Eine Liste aller bislang erfassten Quellen finden Sie <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=quellenliste">hier</a>.</p>

<p>Weiterf&uuml;hrende Informationen zum Projekt "<%= DBtoHTML(Language.getTextfield(session, "logo", "NPPM")) %>" finden Sie unter
    <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=ziele">Ziele</a>.</p>

<%} else{
%>

<h1 class="ut-heading ut-heading--h1">Welcome to the database of</h1>
<h1 class="ut-heading ut-heading--h1">"<%= DBtoHTML(Language.getTextfield(session, "logo", "NPPM")) %>"!</h1>

<p>The database offers you historically and linguistically processed source evidence on names and persons from
    early medieval continental Europe. Search for names, people, sources or single references
    (specific names mentioned in a source).
</p>

<p> You can search the database <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/einfaches_ergebnis">here</a>.
    For more complex queries, please switch to the
    <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/freie_suche">advanced search</a>.
    You can find a detailed description of the database and the search options under
    <a class="ut-link"  href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=hilfe">Help</a>.
</p>

<p>A list of all sources recorded so far can be found <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=quellenliste">here</a>.</p>

<p>Further information about the "<%= DBtoHTML(Language.getTextfield(session, "logo", "NPPM")) %>" project can be found under
    <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/infos?sharedHtml=ziele">Goals</a>.</p>

<%
    }
%>
