<%@ page import="java.sql.Connection" isThreadSafe="false" %>
<%@ page import="java.sql.DriverManager" isThreadSafe="false" %>
<%@ page import="java.sql.ResultSet" isThreadSafe="false" %>
<%@ page import="java.sql.SQLException" isThreadSafe="false" %>
<%@ page import="java.sql.Statement" isThreadSafe="false" %>

<%@ include file="../../configuration.jsp" %>
<%@ include file="../../functions.jsp" %>

<%
  Connection cn = null;
  Statement  st = null;
  ResultSet  rs = null;
%>
</div>
</div>
    <div id="footer">
        <div id="footer-menu">
            <p> <a href="startseite.jsp"> NeG </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/quellenliste"> Quellenliste </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/tagungen"> Tagungen </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/mitglieder"> Mitglieder </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/projekte"> Projekte </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/publikationen"> Publikationen </a>|
             <a href="http://www.neg.uni-tuebingen.de/?q=de/ziele"> Ziele </a>|
            <a href="impressum.jsp"> Impressum </a>
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

