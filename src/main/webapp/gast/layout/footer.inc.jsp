<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<% //close <div id="page"> and <div id="page-wrap">, see header.inc.jsp  %>
  </div>
</div>

<footer id="ut-identifier--footer" class="ut-page__footer ut-page-footer">   
    <div class="container"><div class="ut-grid ut-grid--deck ut-grid--3333 ut-page-footer__quicklinks">
            <div class="ut-grid__col-1 ut-page-footer__col">
                <div class="ut-panel panel ut-panel--collapsing-only-mobile" id="footerpanel-1">
                    <div class="ut-panel__heading ut-page-footer__heading" id="footerpanel-1-ph">
                        <h6 class="ut-heading ut-panel__title"><a class="ut-link ut-panel__link" href="#footerpanel-1-pc" data-toggle="collapse" title="Panel öffnen/schließen">Kontakt<span class="ut-link__icon ut-link__icon--right ut-panel__icon ut-icon ut-icon-down-dir"></span></a></h6>
                    </div>
                    <div class="ut-panel__collapse collapse" id="footerpanel-1-pc">
                        <div class="ut-panel__body ">
                            <address class="ut-page-footer__contact">
                                <strong>Eberhard Karls Universit&auml;t T&uuml;bingen</strong><br>Seminar f&uuml;r mittelalterliche Geschichte<br>Nomen et Gens<br>Wilhelmstr. 36<br>72074 Tübingen<br><a class="ut-link ut-link--email ut-link--block ut-link--context-icon" href="mailto:gundert-portal@ub.uni-tuebingen.de" title="E-Mail senden">neg@uni-tuebingen.de</a><br>
                            </address>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ut-grid__col-2 ut-page-footer__col"></div>
            <div class="ut-grid__col-3 ut-page-footer__col"></div>
            <div class="ut-grid__col-4 ut-page-footer__col">
            </div>
        </div>

        <hr class="ut-page-footer__devider hidden-xs">

        <div class="row ut-page-footer__legal">
            <div class="col-xs-12 col-sm-6 col-md-6 ut-page-footer__copyright">
                <p class="ut-copyright">© 2018 Eberhard Karls Universität Tübingen, Tübingen</p>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 ut-page-footer__nav-meta">
                <nav class="ut-nav ut-nav--meta-bottom" aria-label="Metanavigation">
                    <ul class="ut-nav__list ">
                        <li class="ut-nav__item " data-level-count="1">
                            <a class="ut-link ut-nav__link" href="<%=Utils.getBaseUrl(request)%>/gast/startseite">NeG</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="2">
                            <a class="ut-link ut-nav__link" target="_blank" href="http://www.neg.uni-tuebingen.de/?q=de/quellenliste">Quellenliste</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="3">
                            <a class="ut-link ut-nav__link" href="http://www.neg.uni-tuebingen.de/?q=de/tagungen">Tagungen</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="4">
                            <a class="ut-link ut-nav__link" href="http://www.neg.uni-tuebingen.de/?q=de/mitglieder">Mitglieder</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="5">
                            <a class="ut-link ut-nav__link" href="http://www.neg.uni-tuebingen.de/?q=de/projekte">Projekte</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="6">
                            <a class="ut-link ut-nav__link" href="http://www.neg.uni-tuebingen.de/?q=de/publikationen">Publikationen</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="7">
                            <a class="ut-link ut-nav__link" href="http://www.neg.uni-tuebingen.de/?q=de/ziele">Ziele</a>
                        </li>
                        <li class="ut-nav__item " data-level-count="8">
                            <a class="ut-link ut-nav__link" href="<%=Utils.getBaseUrl(request)%>/gast/impressum">Impressum</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</footer>
                                
<jsp:include page="../../inc.matomo.jsp">
  <jsp:param name="frontendType" value="Frontend" />
</jsp:include>