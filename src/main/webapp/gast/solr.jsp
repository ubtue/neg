<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<%@ page import="org.apache.http.client.utils.URIBuilder" isThreadSafe="false" %>
<%@ page import="org.apache.solr.common.SolrDocument" isThreadSafe="false" %>
<%@ page import="org.apache.solr.common.params.MultiMapSolrParams" isThreadSafe="false" %>
<%@ page import="org.apache.solr.client.solrj.response.FacetField" isThreadSafe="false" %>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>


<%
    String lookfor = request.getParameter("lookfor") != null ? request.getParameter("lookfor") : "";
    String type = request.getParameter("type") != null ? request.getParameter("type") : "";
    String sort = request.getParameter("sort") != null ? request.getParameter("sort") : "";

    MultiMapSolrParams queryParams = (MultiMapSolrParams)request.getAttribute("solrParams");
    QueryResponse queryResponse = (QueryResponse)request.getAttribute("solrResponse");

    List<String> types = new ArrayList<>();
    //types.add("AllFields");
    types.add("belegform");
    types.add("kontext");
    types.add("person");
    types.add("quelle");

    List<String> sorts = new ArrayList<>();
    sorts.add("score desc");
    sorts.add("belegform asc");
    sorts.add("quelle asc");
%>

<form id="searchForm" method="get">
    Suche
    <input name="lookfor" type="search" value="<%=lookfor%>" placeholder="z.B. *:* oder Ebrochardus">
    in
    <select name="type">
        <% for (String entry : types) { %>
            <option value="<%=entry%>" <%= type.equals(entry) ? " selected" : "" %>><%=entry%></option>
        <% } %>
    </select>
    sortiert nach
    <select name="sort">
        <% for (String entry : sorts) { %>
            <option value="<%=entry%>" <%= sort.equals(entry) ? " selected" : "" %>><%=entry%></option>
        <% } %>
    </select>
    <button type="submit">Suchen</button>
</form>

<% if (queryResponse.getResults().getNumFound() > 0)  { %>

<p class="results-total">Anzahl Treffer: <%=queryResponse.getResults().getNumFound()%></p>

<table class="main">
    <!-- Search results -->
    <tr>
    <td class="mainbody">
        <div class="results">
            <% int i=0; %>
            <% for (SolrDocument document : queryResponse.getResults()) { %>
                <% ++i; %>
                <div class="result" style="background-color: #<%= (i % 2 == 0) ? "ccc" : "ddd" %>">
                    <%
                        String id = (String)document.getFirstValue("id");
                        String belegform = (String)document.getFirstValue("belegform");
                        String quelle = (String)document.getFirstValue("quelle");
                        String kontext = document.getFirstValue("kontext") != null ? (String)document.getFirstValue("kontext") : "";
                    %>
                    <div>
                        <span class="belegform"><a href="<%=Utils.getBaseUrl(request)%>/gast/einzelbeleg?ID=<%=id%>"><%=belegform%></a></span><br>
                        <span class="quelle">In: <%=quelle%></span><br>
                        <% if (!kontext.isEmpty()) { %>
                            <span class="kontext"><%=kontext%></span>
                        <% } %>
                    </div>
                    <div class="id">ID:&nbsp;<%=id%></div>
                </div>
            <% } %>
        </div>
    </td>

    <!-- Facets -->
    <td class="sidebar">
        <%  for (FacetField facet : queryResponse.getFacetFields()) { %>
            <div class="facet-group">
                <span class="facet-title"><%=facet.getName()%> (TOP 10)</span>
                <ul class="facet-list">
                    <% for (FacetField.Count count : facet.getValues()) { %>
                        <% if (request.getParameter(facet.getName()) == null || !request.getParameter(facet.getName()).equals(count.getName())) { %>
                            <li class="facet-list-item">
                                <a class="facet-link" href="<%=new URIBuilder(request.getRequestURL().toString() + "?" + request.getQueryString()).addParameter(facet.getName(), count.getName()).build().toString()%>">
                                    <span class="facet-value"><%= count.getName()%></span>
                                    <span class="facet-count"><%= String.valueOf(count.getCount())%></span>
                                </a>
                            </li>
                        <% } else { %>
                            <li class="facet-list-item-active">
                                <span class="facet-value"><%= count.getName()%></span>
                            </li>
                        <% } %>
                    <% } %>
                </ul>
            </div>
        <% } %>
    </td>
</table>

<% } else { %>
    <p class="results-total">Keine Ergebnisse gefunden.</p>
<% } %>
