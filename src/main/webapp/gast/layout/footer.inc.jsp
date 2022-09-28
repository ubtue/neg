<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<% //close <div id="page"> and <div id="page-wrap">, see header.inc.jsp  %>
  </div>
</div>
<div id="footer">
    <div id="footer-menu">
        <p> <a href="<%=Utils.getBaseUrl(request)%>/gast/startseite"> NeG </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/quellenliste"> Quellenliste </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/tagungen"> Tagungen </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/mitglieder"> Mitglieder </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/projekte"> Projekte </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/publikationen"> Publikationen </a>|
         <a href="http://www.neg.uni-tuebingen.de/?q=de/ziele"> Ziele </a>|
        <a href="<%=Utils.getBaseUrl(request)%>/gast/impressum"> Impressum </a>
        </p>
    </div>
    <div id="footer-contact">
        <p> <span>Nomen et Gens</span>
            <span>Seminar f&uuml;r mittelalterliche Geschichte</span>
            <span>Eberhard Karls Universit&auml;t T&uuml;bingen</span>
        </p>
        <p>
            <span>Wilhelmstr. 36</span>
            <span>72074 T&uuml;bingen</span>
            <span><strong> <a href="mailto:neg@uni-tuebingen.de"> neg@uni-tuebingen.de</a></strong></span>
        </p>
    </div>
    <div class="clear"> </div>
</div>


<jsp:include page="../../inc.matomo.jsp">
  <jsp:param name="frontendType" value="Frontend" />
</jsp:include>
