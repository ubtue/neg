<%@page import="de.uni_tuebingen.ub.nppm.util.Language"%>
<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>
<footer id="ut-identifier--footer" class="ut-page__footer ut-page-footer">
    <div class="container">
        <div class="ut-grid ut-grid--deck ut-grid--444 ut-page-footer__quicklinks">
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
            <div class="ut-grid__col-2 ut-page-footer__col">
                <div class="ut-panel panel ut-panel--collapsing-only-mobile" id="footerpanel-2">
                    <div class="ut-panel__heading ut-page-footer__heading" id="footerpanel-2-ph"><h6 class="ut-heading ut-panel__title"><a class="ut-link ut-panel__link collapsed" href="#footerpanel-2-pc" data-toggle="collapse" aria-expanded="false">Weitere Informationen<span class="ut-link__icon ut-link__icon--right ut-panel__icon ut-icon ut-icon-down-dir"></span></a></h6></div>
                    <div class="ut-panel__collapse collapse" id="footerpanel-2-pc">
                        <div class="ut-panel__body">
                            <div class="ut-link-register ut-link-register--color-text ut-link-register--without-icons">
                               <div class="ut-link-register ut-page-footer__link-list">
                                    <div class="ut-link-register__link-list">
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/ziele"><% Language.printTextfield(out, session, "ziele", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/datenbank"><% Language.printTextfield(out, session, "datenbank", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/quellenliste"><% Language.printTextfield(out, session, "quellenliste", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/tagungen"><% Language.printTextfield(out, session, "tagungen", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/mitglieder"><% Language.printTextfield(out, session, "mitglieder", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/projekte"><% Language.printTextfield(out, session, "projekte", "Titel"); %></a>
                                            <a class="ut-link ut-link--internal ut-link--block" href="/neg/gast/publikationen"><% Language.printTextfield(out, session, "publikationen", "Titel"); %></a>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ut-grid__col-3 ut-page-footer__col">
                <div class="ut-panel panel ut-panel--collapsing-only-mobile" id="footerpanel-3">
                    <div class="ut-panel__heading ut-page-footer__heading" id="footerpanel-3-ph">
                        <h6 class="ut-heading ut-panel__title"><a class="ut-link ut-panel__link" href="#footerpanel-3-pc" data-toggle="collapse" title="Panel öffnen/schließen">Gefördert von<span class="ut-link__icon ut-link__icon--right ut-panel__icon ut-icon ut-icon-down-dir"></span></a></h6>
                    </div>
                    <div class="ut-panel__collapse collapse" id="footerpanel-3-pc">
                        <div class="ut-panel__body">
                            <a href="//dfg.de" target="_blank"><img src="layout/dfg_logo_schriftzug.svg" height="36"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <hr class="ut-page-footer__devider hidden-xs">
        <div class="row ut-page-footer__legal">
            <div class="col-xs-12 col-sm-6 col-md-6 ut-page-footer__copyright">
                <p class="ut-copyright">© 2024 Eberhard Karls Universität Tübingen, Tübingen</p>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-6 ut-page-footer__nav-meta">
                <nav class="ut-nav ut-nav--meta-bottom" aria-label="Metanavigation">
                    <ul class="ut-nav__list ">
                        <li class="ut-nav__item " data-level-count="1">
                            <a class="ut-link ut-nav__link" href="<%=Utils.getBaseUrl(request)%>/gast/impressum">Impressum</a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <a href="#top" title="To top" class="top-link">
        <span class="ut-icon ut-icon-up-big ut-icon__to-top" role="img" aria-label="Nach oben scrollen"></span>
    </a>
</footer>


<jsp:include page="../../inc.matomo.jsp">
    <jsp:param name="frontendType" value="Frontend" />
</jsp:include>
