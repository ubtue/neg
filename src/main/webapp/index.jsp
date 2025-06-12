<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.Benutzer" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%    if (AuthHelper.isBenutzerLogin(request)) {

        String selectedLanguage = (String) request.getSession().getAttribute("Sprache");
        Benutzer benutzer = BenutzerDB.getById(AuthHelper.getBenutzer(request).getID());

        int aktuelle_version = -1;

        if (selectedLanguage.equals("de")) {
            aktuelle_version = benutzer.getDataAgreementVersion_de();

        } else {
            aktuelle_version = benutzer.getDataAgreementVersion_gb();
            selectedLanguage = "gb";
        }

        int data_agreement_version = ContentDB.getByNameAndLanguage("dataagreement.html", selectedLanguage).getVersion();

        if (data_agreement_version != aktuelle_version) {
            response.sendRedirect(Utils.getBaseUrl(request) + "/gast/login");
        } else {
%>
<jsp:forward page="einzelbeleg" />
<%
        }
    } else {
        response.sendRedirect(Utils.getBaseUrl(request) + "/gast/infos?sharedHtml=start&current=start");
    }
%>
