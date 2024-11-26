<%@page import="de.uni_tuebingen.ub.nppm.model.SelektionProvenance"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.SelektionBezeichnung"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Selektion"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Utils"%>
<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.SelektionDB" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>

<div>
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">
        <div id="main">
        <%
            List<Selektion> bezList = SelektionDB.getList(request.getParameter("Tabelle"));
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>");
            out.println("Bezeichnung");
            out.println("</th>");
            out.println("<th>");
            out.println("Provenance Source");
            out.println("</th>");
            out.println("<th>");
            out.println("Provenance ID");
            out.println("</th>");
            out.println("</tr>");
            for(Selektion sel: bezList){
                String bez = SelektionDB.getBezeichnungByID(String.valueOf(sel.getId()),request.getParameter("Tabelle"));
                String proSrc = SelektionDB.getProvenanceSource(String.valueOf(sel.getId()),request.getParameter("Tabelle"));
                String proID = SelektionDB.getProvenanceId(String.valueOf(sel.getId()),request.getParameter("Tabelle"));
                out.println("<tr>");
                out.println("<td>");
                out.println(bez);
                out.println("</td>");
                out.println("<td>");
                out.println(proSrc);
                out.println("</td>");
                out.println("<td>");
                out.println(proID);
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        %>
        </div>
    </div>
</div>
