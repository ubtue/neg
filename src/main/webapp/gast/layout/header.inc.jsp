<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%// Wenn ein Link geklickt wurde, setzen Sie die Sprache entsprechend
    if (request.getParameter("language") != null) {
        String selectedLanguage = request.getParameter("language");
        session.setAttribute("Sprache", selectedLanguage);
    }

// Hole die aktuelle Spracheinstellung aus der Session
    String language = (String) session.getAttribute("Sprache");
%>

<header>
    <nav class="ut-nav ut-nav--skipanchors" aria-label="Bereiche überspringen">
        <ul class="ut-nav__list">
            <li class="ut-nav__item" data-level-count="1">
                <a class="ut-link ut-nav__link hidden-xs hidden-sm sr-only sr-only-focusable" href="#ut-identifier--main-nav" tabindex="0">###DT-skip_to_main_navigation###</a>
            </li>
            <li class="ut-nav__item" data-level-count="2">
                <a class="ut-link ut-nav__link sr-only sr-only-focusable" href="#ut-identifier--main-content" tabindex="0">###DT-skip_to_content###</a>
            </li>
            <li class="ut-nav__item" data-level-count="3">
                <a class="ut-link ut-nav__link sr-only sr-only-focusable" href="#ut-identifier--footer" tabindex="0">###DT-skip_to_footer###</a>
            </li>
        </ul>
    </nav>
    <div class="container ut-page-header__container">
        <div class="ut-page-header__menu">
            <nav class="ut-page-header__switch ut-switchbar">
                <ul class="ut-switchbar__list" role="tablist">

                    <!-- Suchen -->
                    <li class="ut-switchbar__item" id="switchbar-search">
                        <button class="ut-switchbar__toggle" id="ut-identifier--search-toggle" data-toggle="switchbar" data-target="#switchblock-search" title="Suchen" aria-haspopup="true" aria-expanded="false" tabindex="0">
                            <span class="ut-switchbar__icon ut-icon ut-icon-search"></span>
                            <span class="ut-switchbar__label">Suchen</span>
                        </button>
                        <div class="ut-switchblock__item ut-switchblock__item--dropdown" id="switchblock-search" style="right: 381px;">
                            <div class="ut-switchblock__header">
                                <span class="ut-switchblock__title">Suche (in Einzelbelegen)</span>
                            </div>
                            <div class="ut-switchblock__content">
                                <form class="ut-form ut-form--search ut-form--small" name="searchForm" role="search" action="<%=Utils.getBaseUrl(request)%>/gast/einfaches_ergebnis" onsubmit="appendSiteToQuery()">
                                    <fieldset>
                                        <div class="ut-form__row row ">
                                            <input class="ut-form__input ut-form__field" id="search" type="search" name="query" placeholder="Ihre Suchanfrage" value="" aria-label="Suchanfrage eingeben" required="">
                                            <input type="hidden" name="form" value="einfache_suche">
                                        </div>
                                        <div class="ut-form__actions row ">
                                            <button type="submit" class="ut-btn ut-btn--outline ut-btn--color-primary-1 ut-form__action" aria-label="Suche starten">
                                                Suchen
                                                <span class="ut-btn__icon ut-btn__icon--right ut-icon ut-icon-right-big"></span>
                                            </button>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <span class="ut-switchblock__close-icon ut-icon ut-icon-cancel" role="button" tabindex="0"></span>
                        </div>
                    </li>

                    <!-- Help -->
                    <li class="ut-switchbar__item" id="switchbar-help">
                        <a href="<%=Utils.getBaseUrl(request)%>/gast/hilfe" class="ut-switchbar__toggle" data-toggle="switchbar" data-target="#switchblock-help" title="Hilfe" role="button" aria-haspopup="false" aria-expanded="false">
                            <span class="ut-switchbar__icon ut-icon ut-icon-info-circled"></span>
                            <span class="ut-switchbar__label">Hilfe</span>
                        </a>
                    </li>

                    <!-- Login -->
                    <li class="ut-switchbar__item" id="switchbar-login">
                        <a href="<%=Utils.getBaseUrl(request)%>/logout?go=intern" class="ut-switchbar__toggle" data-toggle="switchbar" data-target="#switchblock-login" title="Interner Bereich" role="button" aria-haspopup="false" aria-expanded="false">
                            <span class="ut-switchbar__icon ut-icon ut-icon-login"></span>
                            <span class="ut-switchbar__label">Interner Bereich</span>
                        </a>
                    </li>

                    <!-- Language -->
                    <li class="ut-switchbar__item" id="switchbar-language">
                        <a href="#" class="ut-switchbar__toggle" data-toggle="switchbar" data-target="#switchblock-language"
                           title="Sprache wählen" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="ut-switchbar__icon ut-icon ut-icon-globe"></span>
                            <span class="ut-switchbar__label">Language</span>
                        </a>
                        <div class="ut-switchblock__item ut-switchblock__item--dropdown" id="switchblock-language">
                            <div class="ut-switchblock__header">
                                <span class="ut-switchblock__title">Sprachauswahl</span>
                                <span class="ut-switchblock__close-icon ut-icon ut-icon-cancel" role="button"></span>
                            </div>
                            <div class="ut-switchblock__content">
                                <nav class="ut-nav ut-nav--language" aria-label="bobo">
                                    <ul class="ut-nav__list ">
                                        <li class="ut-nav__item " data-level-count="1">
                                            <a class="ut-link ut-nav__link" href="?language=de" title="Sprache Deutsch wählen">Deutsch</a>
                                        </li>
                                        <li class="ut-nav__item " data-level-count="2">
                                            <a class="ut-link ut-nav__link" href="?language=gb" title="Sprache Englisch wählen">Englisch</a>
                                        </li>
                                        <li class="ut-nav__item " data-level-count="2">
                                            <a class="ut-link ut-nav__link" href="?language=fr" title="Sprache Französisch wählen">Französisch (nur Felder)</a>
                                        </li><!-- comment -->
                                        <li class="ut-nav__item " data-level-count="2">
                                            <a class="ut-link ut-nav__link" href="?language=la" title="Sprache Latein wählen">Latein (nur Felder)</a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </li>

                    <!-- Switchbar Menu (for low resolutions) -->
                    <li class="ut-switchbar__item" id="switchbar-menu">
                        <a href="#" class="ut-switchbar__toggle" id="ut-identifier--menu-toggle" data-toggle="switchbar" data-target="#switchblock-menu" title="###DT-language_chooser###" role="button" aria-haspopup="true" aria-expanded="false">
                            <span class="ut-switchbar__icon ut-icon ut-icon-menu"></span>
                            <span class="ut-switchbar__label sr-only-focusable">Menu</span>
                        </a>
                    </li>

                </ul>
            </nav>
        </div>
        <div class="ut-page-header__banner">
            <div class="ut-page-header__logos">
                <a href="https://www.uni-tuebingen.de" title="" class="ut-logo-link ut-logo-link--main">
                    <img src="vendor/ut-typo3/img/Logo_Universitaet_Tuebingen.svg" class="ut-img ut-img--logo ut-img--logo-main" alt="##DT-img_university_tuebingen###">
                </a>
                <a href="https://www.uni-tuebingen.de/exzellenzinitiative/" title="" class="ut-logo-link ut-logo-link--excellence">
                    <img src="vendor/ut-typo3/img/Logo_Universitaet_Tuebingen_Exzellent_EN.svg" class="ut-img ut-img--logo ut-img--logo-excellence-###LANGUAGE_CODE_LOWER###" alt="##DT-img_logo_excellence###">
                </a>
            </div>
            <div class="ut-page-header__dropdowns"></div>
        </div>
        <nav class="ut-nav-area ut-page-header__area_nav" aria-label="###DT-area_navigation###">
            <h4 class="ut-heading ut-nav-area__prev-level">
                <a href="https://www.ub.uni-tuebingen.de" title="###DT-university_library###" class="ut-link ut-nav-area__link ut-nav-area__link--prev">
                    Universitätsbibliothek
                </a>
            </h4>
            <h2 class="ut-heading ut-nav-area__current-level">
                <a class="ut-link ut-nav-area__link" title="Nomen et Gens" href="/neg">
                    Nomen et Gens
                </a>
            </h2>
        </nav>
        <div class="ut-page__switchblock ut-switchblock">
            <div id="switchblock-menu" class="ut-switchblock__item">
                <div class="ut-switchblock__header">
                    <span class="ut-switchblock__title">Menu</span>
                    <span class="ut-switchblock__close-icon ut-icon ut-icon-cancel" role="button"></span>
                </div>

                <div class="ut-switchblock__content" data-breadcrumbuids="0">
                    <nav id="ut-identifier--main-nav" class="ut-nav ut-nav--main lory-slider js_variablewidth variablewidth" data-current-languageuid="###LANGUAGE_UID###">
                        <div class="lory-frame js_frame">
                            <!-- ###TOPNAV### Start -->
                            <ul class="ut-nav__list ut-nav__list--level-1 lory-slides js_slides">
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="1">
                                    ${param.current eq 'startseite' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'startseite' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/startseite" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="startseite"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'startseite' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="2">
                                    ${param.current eq 'einzelbeleg' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'einzelbeleg' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/einzelbeleg" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="einzelbeleg"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'einzelbeleg' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="3">
                                    ${param.current eq 'person' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'person' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/person" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="person"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'person' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="4">
                                    ${param.current eq 'namenkommentar' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'namenkommentar' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/mghlemma" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="namenkommentar"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'namenkommentar' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="5">
                                    ${param.current eq 'quelle' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'quelle' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/quelle" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="quelle"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'quelle' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="6">
                                    ${param.current eq 'einfaches_ergebnis' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'einfaches_ergebnis' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/einfaches_ergebnis" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="gast_freie_suche"/>
                                                <jsp:param name="Textfeld" value="Suchen"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'einfaches_ergebnis' ? '</div>' : ''}
                                </li>
                                <li class="ut-nav__item ut-nav__item--level-1 lory-slides__item js-slide" data-level-count="7">
                                    ${param.current eq 'freie_suche' ? '<div class="ut-nav__link-group ut-nav__link-group--is-current">' : ''}
                                        <a class="ut-link ut-nav__link ut-nav__link--level-1 ${param.current eq 'freie_suche' ? 'ut-nav__link--is-active' : ''} ut-nav__link--no-sub" href="<%=Utils.getBaseUrl(request)%>/gast/freie_suche" tabindex="0">
                                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                                <jsp:param name="Formular" value="gast_freie_suche"/>
                                                <jsp:param name="Textfeld" value="Titel"/>
                                            </jsp:include>
                                        </a>
                                    ${param.current eq 'freie_suche' ? '</div>' : ''}
                                </li>
                            </ul>
                            <!-- ###TOPNAV### End -->
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>
