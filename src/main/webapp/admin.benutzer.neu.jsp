<%@page import="de.uni_tuebingen.ub.nppm.util.SaltHash"%>
﻿<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>
<%@ include file="functions.jsp" %>

<%    if (AuthHelper.isAdminLogin(request)) {

        if (request.getParameter("action") == null
                || request.getParameter("Benutzername") == null
                || request.getParameter("Nachname") == null
                || request.getParameter("Vorname") == null
                || request.getParameter("EMail") == null
                || request.getParameter("Kennwort") == null) {
            out.println("<p>Falscher Aufruf!</p>");
            out.println("<a href=\"index.jsp\">Zur&uuml;ck zur Startseite</a>");
        } else {
%>

<HTML>
    <HEAD>
        <TITLE>Nomen et Gens - Administration</TITLE>
        <link rel="stylesheet" href="layout/layout.css" type="text/css">
        <script src="../javascript/funktionen.js" type="text/javascript"></script>
        <noscript></noscript>
    </HEAD>

    <BODY>
        <jsp:include page="layout/navigation.inc.jsp" />
        <jsp:include page="layout/image.inc.html" />
        <jsp:include page="layout/titel.administration.jsp" />
        <div id="form">

            <%
                Connection cn = null;
                Statement st = null;
                ResultSet rs = null;
                boolean fehler = false;

                if (request.getParameter("Benutzername").equals("")) {
                    out.println("<p><b>Fehler:</b> Benutzername ist leer</p>");
                    fehler = true;
                } else {
                    try {
                        Class.forName(sqlDriver);
                        cn = DriverManager.getConnection(sqlURL, sqlUser, sqlPassword);
                        st = cn.createStatement();
                        rs = st.executeQuery("SELECT * FROM benutzer WHERE Login =\"" + request.getParameter("Benutzername") + "\"");
                        if (rs.next()) {
                            out.println("<p><b>Fehler:</b> Benutzername ist bereits vorhanden</p>");
                            fehler = true;
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
                }

                if (request.getParameter("Nachname").equals("")) {
                    out.println("<p><b>Fehler:</b> Nachname ist leer</p>");
                    fehler = true;
                }

                if (request.getParameter("Vorname").equals("")) {
                    out.println("<p><b>Fehler:</b> Vorname ist leer</p>");
                    fehler = true;
                }

                if (request.getParameter("EMail").equals("")) {
                    out.println("<p><b>Fehler:</b> E-Mail ist leer</p>");
                    fehler = true;
                }

                if (request.getParameter("Kennwort").equals("")) {
                    out.println("<p><b>Fehler:</b> Kennwort ist leer</p>");
                    fehler = true;
                }

                if (fehler) {
                    out.println("<a href=\"javascript:history.back()\">zur&uuml;ck</a>");
                } else {
                    try {
                        Class.forName(sqlDriver);
                        cn = DriverManager.getConnection(sqlURL, sqlUser, sqlPassword);
                        st = cn.createStatement();

                        String password = request.getParameter("Kennwort");
                        SaltHash saltHash = new SaltHash();
                        String algorithm = "MD5";
                        byte[] salt = saltHash.createSalt();
                        password = saltHash.generateHash(password, algorithm, salt);
                        String saltValue = saltHash.getSaltString();

                        st.execute("INSERT INTO benutzer (Login, Nachname, Vorname, EMail, Password, Sprache, IstAdmin, GruppeID, Salt) VALUES ("
                                + "\"" + request.getParameter("Benutzername") + "\", "
                                + "\"" + request.getParameter("Nachname") + "\", "
                                + "\"" + request.getParameter("Vorname") + "\", "
                                + "\"" + request.getParameter("EMail") + "\","
                                + "\"" + password + "\", "
                                + "\"" + request.getParameter("Sprache") + "\", "
                                + "\"" + (request.getParameter("Administrator") != null && request.getParameter("Administrator").equals("on") ? "1" : "0") + "\", "
                                + "\"" + request.getParameter("Projektgruppe") + "\","
                                + "\"" + saltValue + "\");");

                        out.println("<p>Benutzer \"" + request.getParameter("Benutzername") + "\"erfolgreich angelegt.</p>");
                        out.println("<a href=\"administration.jsp\">zur&uuml;ck</a>");
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
                }
            %>

        </div>
    </BODY>
</HTML>

<%
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
%>

