<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankMapping" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankTexte" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%
    String formular = request.getParameter("Formular");
    String datenfeld = request.getParameter("Datenfeld");
    String textfeld = request.getParameter("Textfeld");
    String sprache = "de";
    if (session != null && session.getAttribute("Sprache") != null) {
        sprache = (String) session.getAttribute("Sprache");
    }

    if (datenfeld == null && textfeld != null) {
        DatenbankTexte dt = DatenbankDB.getLabel(formular, textfeld);
        if (dt != null) {
            out.print(dt.get(sprache));
        } else {
            out.print("No label found for " + formular + "/" + textfeld);
        }
    } else if (datenfeld != null && textfeld == null) {
        DatenbankMapping dm = DatenbankDB.getMapping(formular, datenfeld);
        if (dm != null) {
            out.print("<label for=\"" + datenfeld + "\">");
            out.print(dm.getBeschriftung(sprache));
            out.print("</label>");
        } else {
            out.print("No mapping found for " + formular + "/" + textfeld);
        }
    }
%>
