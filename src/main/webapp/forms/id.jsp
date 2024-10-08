<%@page import="de.uni_tuebingen.ub.nppm.db.PersonDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.NamenKommentarDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.QuelleDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.EditionDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.HandschriftDB"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.MghLemmaDB"%>
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
        provenanceSrc = EinzelbelegDB.getProvenanceSource(id, "einzelbeleg");
    } else if (title.toLowerCase().equals("person")) {
        out.print("P");
        provenanceId = PersonDB.getProvenanceId(id, "person");
        provenanceSrc = PersonDB.getProvenanceSource(id, "person");
    } else if (title.toLowerCase().equals("namenkommentar")) {
        out.print("N");
        provenanceId = NamenKommentarDB.getProvenanceId(id, "namenkommentar");
        provenanceSrc = NamenKommentarDB.getProvenanceSource(id, "namenkommentar");
    } else if (title.toLowerCase().equals("quelle")) {
        out.print("Q");
        provenanceId = QuelleDB.getProvenanceId(id, "quelle");
        provenanceSrc = QuelleDB.getProvenanceSource(id, "quelle");
    } else if (title.toLowerCase().equals("edition")) {
        out.print("E");
        provenanceId = EditionDB.getProvenanceId(id, "edition");
        provenanceSrc = EditionDB.getProvenanceSource(id, "edition");
    } else if (title.toLowerCase().equals("handschrift")) {
        out.print("T");
        provenanceId = HandschriftDB.getProvenanceId(id, "handschrift");
        provenanceSrc = HandschriftDB.getProvenanceSource(id, "handschrift");
    } else if (title.toLowerCase().equals("mghlemma")) {
        out.print("M");
        provenanceId = MghLemmaDB.getProvenanceId(id, "mgh_lemma");
        provenanceSrc = MghLemmaDB.getProvenanceSource(id, "mgh_lemma");
    }

    out.println(id);
    if(provenanceSrc != null)
        out.println("<br>Provenance Source: "+provenanceSrc);
    if(provenanceId != null)
        out.println("<br>Provenance ID: "+provenanceId);
%>
