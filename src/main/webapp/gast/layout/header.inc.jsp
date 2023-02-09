<%@ page import="de.uni_tuebingen.ub.nppm.util.Utils" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<div id="page-wrap">
    <div id="page">
        <div id="header">
            <div id="header-left">
                <a href="startseite"> Nomen et Gens </a>
            </div>
            <div id="header-right">
                <p><a href="<%=Utils.getBaseUrl(request)%>/gast/hilfe"><strong>Hilfe</strong></a> | <a href="<%=Utils.getBaseUrl(request)%>/logout?go=intern"><strong>Interner Bereich</strong></a></p>
            </div>
            <div class="clear"></div>
        </div>


        <div class="menu-placeholder">
            <div class="menu-wrap">
                <div class="menu">
                    <ul>
                        <li> <a class="${param.current eq 'startseite' ? 'current' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/startseite"> Startseite </a></li>
                        <li> <a class="${param.current eq 'einzelbeleg' ? 'current' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/einzelbeleg">
                                <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                    <jsp:param name="Formular" value="einzelbeleg"/>
                                    <jsp:param name="Textfeld" value="Titel"/>
                                </jsp:include>
                            </a>
                        </li>
                        <li><a class="${param.current eq 'person' ? 'current' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/person">
                                <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                    <jsp:param name="Formular" value="person"/>
                                    <jsp:param name="Textfeld" value="Titel"/>
                                </jsp:include>
                            </a>
                        </li>
                        <li><a class="${param.current eq 'namenkommentar' ? 'current' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/mghlemma">
                                <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                    <jsp:param name="Formular" value="namenkommentar"/>
                                    <jsp:param name="Textfeld" value="Titel"/>
                                </jsp:include>
                            </a>
                        </li>
                        <li><a class="${param.current eq 'quelle' ? 'current' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/quelle">
                                <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                    <jsp:param name="Formular" value="quelle"/>
                                    <jsp:param name="Textfeld" value="Titel"/>
                                </jsp:include>
                            </a>
                        </li>
                    </ul>
                    <div id="search-wrap">
                        <div id="search">
                            <FORM method="POST" action="<%=Utils.getBaseUrl(request)%>/gast/einfaches_ergebnis">
                                <input type="hidden" name="form" value="einfache_suche">
                                <input id="button" name="Suchen" value="" type="submit">
                                <input type="text" name="query" placeholder="Suchen">
                            </FORM>
                        </div>
                        <a id="erweiterte_suche_button" class="${param.current eq 'erweiterte_suche' ? 'erweiterte_suche_active' : ''}" href="<%=Utils.getBaseUrl(request)%>/gast/freie_suche">
                            <jsp:include page="../../inc.erzeugeBeschriftung.jsp">
                                <jsp:param name="Formular" value="gast_freie_suche"/>
                                <jsp:param name="Textfeld" value="Titel"/>
                            </jsp:include>
                        </a>
                    </div>
                    <div class="anim1"></div>
                </div>
                <div class="clear"> </div>
                <div id="line-after-menu"> </div>
            </div>
        </div>
<% //<div id="page-wrap"> and <div id="page"> will be closed in footer.inc.jsp  %>
