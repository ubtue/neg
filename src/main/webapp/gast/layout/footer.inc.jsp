<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<footer id="ut-identifier--footer" class="ut-page__footer ut-page-footer">
    <div class="container">
        <div id="footer-menu">
            <p>
                <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/startseite"> NeG </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/quellenliste"> Quellenliste </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/tagungen"> Tagungen </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/mitglieder"> Mitglieder </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/projekte"> Projekte </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/publikationen"> Publikationen </a>|
                <a class="ut-link" href="http://www.neg.uni-tuebingen.de/?q=de/ziele"> Ziele </a>|
                <a class="ut-link" href="<%=Utils.getBaseUrl(request)%>/gast/impressum"> Impressum </a>
            </p>
        </div>
        <div class="ut-grid ut-grid--deck ut-grid--3333 ut-page-footer__quicklinks">
            <div class="ut-grid__col-1 ut-page-footer__col">
                <div class="ut-panel panel ut-panel--collapsing-only-mobile" id="footerpanel-1">
                    <div class="ut-panel__heading ut-page-footer__heading" id="footerpanel-1-ph">
                        <h6 class="ut-heading ut-panel__title"><a class="ut-link ut-panel__link" href="#footerpanel-1-pc" data-toggle="collapse" title="Panel öffnen/schließen">Kontakt<span class="ut-link__icon ut-link__icon--right ut-panel__icon ut-icon ut-icon-down-dir"></span></a></h6>
                    </div>
                    <div class="ut-panel__collapse collapse" id="footerpanel-1-pc">
                        <div class="ut-panel__body ">
                            <address class="ut-page-footer__contact">
                                <strong>Nomen et Gens</strong><br>
                                Seminar f&uuml;r mittelalterliche Geschichte<br>
                                Eberhard Karls Universit&auml;t T&uuml;bingen<br>
                                Wilhelmstr. 36<br>
                                72074 Tübingen<br>
                                <a class="ut-link ut-link--email ut-link--block ut-link--context-icon" href="mailto:neg@uni-tuebingen.de" title="E-Mail senden">neg@uni-tuebingen.de</a><br>
                            </address>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ut-grid__col-2 ut-page-footer__col"></div>
            <div class="ut-grid__col-3 ut-page-footer__col"></div>
            <div class="ut-grid__col-4 ut-page-footer__col">
                <div class="ut-panel panel ut-panel--collapsing-only-mobile" id="footerpanel-4">
                    <div class="ut-panel__heading ut-page-footer__heading" id="footerpanel-4-ph">
                        <h6 class="ut-heading ut-panel__title"><a class="ut-link ut-panel__link" href="#footerpanel-4-pc" data-toggle="collapse" title="Panel öffnen/schließen">Gefördert von<span class="ut-link__icon ut-link__icon--right ut-panel__icon ut-icon ut-icon-down-dir"></span></a></h6>
                    </div>
                    <div class="ut-panel__collapse collapse" id="footerpanel-4-pc">
                        <div class="ut-panel__body">
                            <a href="//dfg.de" target="_blank"><img src="layout/dfg_logo_schriftzug.svg"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr class="ut-page-footer__devider hidden-xs">
        <div class="row ut-page-footer__legal">
            <div class="col-xs-12 col-sm-12 col-md-12 ut-page-footer__copyright">
                <p class="ut-copyright">© 2024 Eberhard Karls Universität Tübingen, Tübingen</p>
            </div>
        </div>
    </div>
    <a href="#top" title="To top" class="top-link cd-is-visible cd-fade-out">
	<span class="ut-icon ut-icon-up-big ut-icon__to-top" role="img" aria-label="Nach oben scrollen"></span>
    </a>
</footer>


<jsp:include page="../../inc.matomo.jsp">
    <jsp:param name="frontendType" value="Frontend" />
</jsp:include>
