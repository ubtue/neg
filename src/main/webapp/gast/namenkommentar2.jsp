<%@ page import="de.uni_tuebingen.ub.nppm.util.Language" isThreadSafe="false" %>
<%@ page import="com.lowagie.text.Document" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.*" isThreadSafe="false"%>
<%@ page import="com.lowagie.text.rtf.*" isThreadSafe="false"%>
<%@ page import="java.io.*" isThreadSafe="false"%>
<%@ page import="java.util.Enumeration" isThreadSafe="false"%>
<%@ page import="java.util.List" isThreadSafe="false"%>
<%@ page import="java.util.Map" isThreadSafe="false"%>

<%@ include file="../configuration.jsp"%>
<%@ include file="../functions.jsp"%>

<jsp:include page="../dofilter.jsp" />

<%
    Language.setLanguage(request);
    List<Map> rowlist = DatenbankDB.getMappedList("SELECT DISTINCT Bezeichnung from gastnamenkommentar order by Bezeichnung");
    for (Map row : rowlist) {
        out.println(format(row.get("Bezeichnung").toString(), "PLemma") + "<br> ");
    }
%>
