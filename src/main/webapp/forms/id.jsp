<%@page import="de.uni_tuebingen.ub.nppm.db.EinzelbelegDB"%>
<%@ include file="../configuration.jsp" %>

<%
    String id = request.getParameter("ID");
    String title = request.getParameter("title");
    String provenanceId = null;
    String provenanceSrc = null;
    if (title.contains("gast_")) {
        title = title.substring(5);
    }

    out.println("ID: ");
    if (title.toLowerCase().equals("einzelbeleg")) {
        out.print("B");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "einzelbeleg");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "einzelbeleg");
    } else if (title.toLowerCase().equals("person")) {
        out.print("P");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "person");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "person");
    } else if (title.toLowerCase().equals("namenkommentar")) {
        out.print("N");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "namenkommentar");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "namenkommentar");
    } else if (title.toLowerCase().equals("quelle")) {
        out.print("Q");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "quelle");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "quelle");
    } else if (title.toLowerCase().equals("edition")) {
        out.print("E");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "edition");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "edition");
    } else if (title.toLowerCase().equals("handschrift")) {
        out.print("T");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "handschrift");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "handschrift");
    } else if (title.toLowerCase().equals("mghlemma")) {
        out.print("M");
        provenanceId = EinzelbelegDB.getProvenanceId(id, "mghlemma");
        provenanceSrc = EinzelbelegDB.getProvenanceSrc(id, "mgh_lemma");
    }

    out.println(id);
    if(provenanceSrc != null)
        out.println("<br>Provenance Source: "+provenanceSrc);
    if(provenanceId != null)
        out.println("<br>Provenance ID: "+provenanceId);
%>
