<%@page import="java.io.PrintWriter"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.SaltHash"%>
﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.security.MessageDigest" isThreadSafe="false" %>

<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>


<%    if (session != null && session.getAttribute("BenutzerID") != null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && !((Boolean) session.getAttribute("Gast"))) {
%><jsp:forward page="einzelbeleg.jsp" /><%
} else if (session != null && session.getAttribute("BenutzerID") != null && ((Integer) session.getAttribute("BenutzerID")).intValue() > 0 && ((Boolean) session.getAttribute("Gast"))) {
    response.sendRedirect("gast/einfache_suche.jsp");
} else {
    Connection cn = null;
    Statement st = null;
    ResultSet rs = null;

    if (request.getParameter("language") != null) {
        session = request.getSession(true);
        session.setAttribute("Sprache", request.getParameter("language"));
        session.setMaxInactiveInterval(sessionTimeout);
    }

    if (request.getParameter("action") != null && request.getParameter("action").equals("login")) {
        String login = request.getParameter("username");
        String password = request.getParameter("password");

        // Passwort verschlüsseln - veraltets orginal mit MD5 zugang
        //  MessageDigest m = MessageDigest.getInstance("MD5");
        //  m.update(password.getBytes(), 0, password.length());
        //  String passwordMD5 = (new BigInteger(1, m.digest()).toString(16));
        try {

            //Decrypt password
            SaltHash saltHash = new SaltHash();
            String algorithm = "MD5";

            Class.forName(sqlDriver);
            cn = DriverManager.getConnection(sqlURL, sqlUser, sqlPassword);
            st = cn.createStatement();

            //Fetch Salt from the database
            String sql_saltString = "SELECT Salt FROM benutzer WHERE Login = '" + login + "'; ";
            rs = st.executeQuery(sql_saltString);

            if (rs.next()) {
                saltHash.setSaltString(rs.getString("Salt"));
            } else {
                response.sendRedirect("gast/einfache_suche.jsp");
            }

            //Now decode password with salt to the hash value that is under password in the database    
            String passwordMD5 = "";
            if (saltHash.getSaltString() != null && saltHash.getSaltString().length() > 0) {
                passwordMD5 = saltHash.decodeSaltHash(password, algorithm, saltHash.getSaltString());
                rs = st.executeQuery("SELECT ID, Login, GruppeID, IstAdmin, Sprache, IstGast FROM benutzer WHERE Login='" + login + "' AND Password ='" + passwordMD5 + "' AND IstAktiv='1'");

                if (rs.next()) {
                    // Falls Session vorhanden, löschen
                    if (session != null) {
                        session.invalidate();
                    }

                    // Neue Session erzeugen
                    session = request.getSession(true);
                    session.setAttribute("BenutzerID", new Integer(rs.getInt("ID")));
                    session.setAttribute("GruppeID", new Integer(rs.getInt("GruppeID")));
                    session.setAttribute("Benutzername", rs.getString("Login"));
                    session.setAttribute("Administrator", new Boolean((rs.getInt("IstAdmin") == 1 ? true : false)));
                    session.setAttribute("Gast", new Boolean((rs.getInt("IstGast") == 1 ? true : false)));
                    session.setAttribute("Sprache", rs.getString("Sprache"));
                    session.setMaxInactiveInterval(sessionTimeout);

                    // Weiterleitung
                    if ((Boolean) session.getAttribute("Gast")) {
                        response.sendRedirect("gast/einfache_suche.jsp");
                    } else {
                        response.sendRedirect("einzelbeleg.jsp");
                    }
                } else {
%>
<p>
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="error"/>
        <jsp:param name="Textfeld" value="Zugriff"/>
    </jsp:include>
</p>
<a href="index.jsp">
    <jsp:include page="inc.erzeugeBeschriftung.jsp">
        <jsp:param name="Formular" value="all"/>
        <jsp:param name="Textfeld" value="Startseite"/>
    </jsp:include>
</a>
<%
            }
        } else { //users didn`t upgrade to Salt-MD5-Hash

            PrintWriter pw = response.getWriter();

            pw.println("<!DOCTYPE html>");
            pw.println("<html>");
            pw.println("<head>");
            pw.println("<title>Fehler Link nicht generiert</title>");
            pw.println("</head>");
            pw.println("<body>");
            pw.println("<h1 style=\"text-align: center;\">Datenbank Sicherheit wurde verbessert das Password muss neu gesetzt werden </h1>");
            pw.println("<h1 style=\"text-align: center;\"><a href=\"http://localhost:8080/neg/forgotPassword.jsp\">Neuen Link generieren</a></h1>");
            pw.println("</body>");
            pw.println("</html>");
        }
    } finally {
        try {
            if (null != rs) {
                rs.close();
            }
        } catch (Exception ex) {
        }
        try {
            if (null != st) {
                st.close();
            }
        } catch (Exception ex) {
        }
        try {
            if (null != cn) {
                cn.close();
            }
        } catch (Exception ex) {
        }
    }
} else {
%>

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
                <a href="forgotPassword.jsp">Passwort vergessen ?</a>
            </div>  <!-- ende flexbox-container -->
        </form>
    <center>
        <%
            try {
                Class.forName(sqlDriver);
                cn = DriverManager.getConnection(sqlURL, sqlUser, sqlPassword);
                st = cn.createStatement();
                rs = st.executeQuery("SELECT Kuerzel, Sprache FROM datenbank_sprachen ORDER BY ID");
                out.println("<form method=\"POST\">");
                while (rs.next()) {
                    out.println("<input type=\"image\" name=\"language\" alt=\"" + DBtoHTML(rs.getString("Sprache")) + "\" title=\"" + DBtoHTML(rs.getString("Sprache")) + "\" src=\"layout/flags/" + rs.getString("Kuerzel") + ".gif\" value=\"" + rs.getString("Kuerzel") + "\" style=\"border:#000 1px solid;\">");
                }
                out.println("</form>");
            } catch (SQLException e) {
                out.println(e);
            } finally {
                try {
                    if (null != rs) {
                        rs.close();
                    }
                } catch (Exception ex) {
                }
                try {
                    if (null != st) {
                        st.close();
                    }
                } catch (Exception ex) {
                }
                try {
                    if (null != cn) {
                        cn.close();
                    }
                } catch (Exception ex) {
                }
            }
        %>
    </center>
</BODY>
</HTML>

<%
        }
    }
%>
