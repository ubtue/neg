<%@ page isErrorPage="true" %>
<%@ page import="de.uni_tuebingen.ub.nppm.exception.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.*" isThreadSafe="false" %>

<%
// Note: We cannot use the regular "Gast" check here because the URL will change
// when this template is called. So check for the session instead:
boolean isGast = session == null || session.getAttribute("Gast") == null || (session.getAttribute("Gast") != null && (boolean)session.getAttribute("Gast") == true);

%>

<%!

public boolean containsCause(Throwable t, Class type) throws java.io.IOException {
    if (t.getClass().equals(type)) {
        return true;
    }
    if (t.getCause() != null) {
        return containsCause(t.getCause(), type);
    }
    return false;
}

%>

<% if (isGast) { %>
    <jsp:include page="gast/servlet/header.jsp" />
<% } else { %>
    <jsp:include page="servlet/header.jsp" />
    <div id="titel"></div>
    <div id="form">
<% } %>

<h1 style="color: red">Fehler</h1>
<p style="font-weight: bold;">
    <% if (response.getStatus() == 404) { %>
        Die Unterseite existiert nicht.
    <% } else if (exception != null) { %>
        <% if (containsCause(exception, IdNotFoundException.class)) { %>
            <% response.setStatus(HttpServletResponse.SC_NOT_FOUND); %>
            Diese ID wurde nicht gefunden.
        <% } else if (containsCause(exception, IdInvalidException.class)) { %>
            <% response.setStatus(HttpServletResponse.SC_BAD_REQUEST); %>
            ID muss mit B, P, M, N, Q, T, oder E beginnen und mit einer Nummer enden (z.B. P7404).
        <% } else if (Utils.isDevelopmentEnvironment()) { %>
            <pre><%=exception.getMessage()%></pre>
        <% } else { %>
            Eine unbehandelte Ausnahme vom Typ <%=exception.getClass().getSimpleName()%> ist aufgetreten.
        <% } %>
    <% } else { %>
        Keine weiteren Informationen verfügbar.
    <% } %>
</p>

<hr>

<p>
    Falls Sie technischen Support benötigen, können Sie uns unter folgender Adresse kontaktieren: <a href="mailto:nppm-team@ub.uni-tuebingen.de" rel="nofollow">nppm-team@ub.uni-tuebingen.de</a>.<br>
    Bitte fügen Sie folgende Angaben hinzu:
    <ul style="list-style: initial;">
        <li>Datum/Uhrzeit</li>
        <li>Screenshot (inkl. URL + Fehlermeldung)</li>
        <li>Ihr Benutzername (falls zutreffend)</li>
    </ul>
</p>

<% if (isGast) { %>
    <jsp:include page="gast/servlet/footer.jsp" />
<% } else { %>
    </div>
<% } %>
