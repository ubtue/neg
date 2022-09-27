<%@ page import="java.util.List" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.model.DatenbankSprache" isThreadSafe="false" %>

<HTML>
    <HEAD>
        <TITLE>
            Nomen et Gens -
        </TITLE>
        <link rel="stylesheet" href="layout/layout.css" type="text/css">
        <style>
            .flexbox-container{
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                margin: 200px 0px 0px 0px;
            }

            .flex-item-table{
                align-items: first;
            }
        </style>
    </HEAD>
    <BODY>
        <form method="POST">
            <input type="hidden" name="action" value="login">
            <div class="flexbox-container" >
                <div class="flex-item-title">
                    <h1 class="login">Nomen et Gens</h1>
                </div>
                <div class="flex-item-title flex-item-table">
                    <table border="0">

                        <tr><td colspan="2"><h2 class="login">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Anmeldung"/>
                                    </jsp:include>
                                </h2></td></tr>
                        <tr>
                            <th><label for="username">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Benutzername"/>
                                    </jsp:include>
                                </label></th>
                            <td><input name="username" maxlength="20" placeholder="Benutzername" /></td>
                        </tr>
                        <tr>
                            <th><label for="password">
                                    <jsp:include page="inc.erzeugeBeschriftung.jsp">
                                        <jsp:param name="Formular" value="login"/>
                                        <jsp:param name="Textfeld" value="Passwort"/>
                                    </jsp:include>
                                </label></th>
                            <td><input type="password" name="password" maxlength="20" placeholder="Passwort" /></td>
                        </tr>
                    </table>


                </div>
                <input type="submit" value="Daten absenden" style="margin:5px 0px 0px 50px"/>



                <p> &nbsp; </p><!-- comment -->
                <a href="forgotPassword">Passwort vergessen ?</a>
            </div>  <!-- ende flexbox-container -->
        </form>
    <center>
        <% List<DatenbankSprache> sprachen = DatenbankDB.getListSprache(); %>
        <form method="POST">
            <% for (DatenbankSprache sprache : sprachen) { %>
                <input type="image" name="language" alt="" title="" src="layout/flags/<%=sprache.getKuerzel()%>.gif" value="<%=sprache.getKuerzel()%>" style="border:#000 1px solid;">
            <% } %>
        </form>
    </center>
</BODY>
</HTML>
