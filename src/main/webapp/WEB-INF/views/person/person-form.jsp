<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8"
 pageEncoding="utf-8"%>
﻿<%@ page import="java.sql.Connection" isThreadSafe="false"%>
<%@ page import="java.sql.DriverManager" isThreadSafe="false"%>
<%@ page import="java.sql.ResultSet" isThreadSafe="false"%>
<%@ page import="java.sql.SQLException" isThreadSafe="false"%>
<%@ page import="java.sql.Statement" isThreadSafe="false"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../partials/configuration.jsp"%>

<jsp:include page="../partials/dolanguage.jsp" />
<jsp:include page="../partials/dofilter.jsp">
     <jsp:param name="form" value="person" />
</jsp:include>

<jsp:include page="../partials/dosave.jsp">
	<jsp:param name="form" value="person" />
	<jsp:param name="ID" value="${id}" />
</jsp:include>
<jsp:include page="../partials/dojump.jsp">
	<jsp:param name="form" value="person" />
</jsp:include>

<html>
    <head>
        <title>Nomen et Gens - 
            <jsp:include page="../partials/inc.erzeugeBeschriftung.jsp">
                <jsp:param name="Formular" value="person" />
                <jsp:param name="Textfeld" value="Titel" />
            </jsp:include>
        </title>

        <link rel="stylesheet" href="../layout/layout.css" type="text/css">

        <script src="../javascript/funktionen.js" type="text/javascript"></script>

        <noscript></noscript>
    </head>
    
    <body>
        <jsp:include page="../partials/navigation.jsp" />
        <div id="image">
            <jsp:include page="../partials/image.jsp" />
        </div>
        <div id="title">
            <!--TODO-->
        </div>
        <form:form action="savePerson" method="post" modelAttribute="person">
            <!-- need to associate this data with person id -->
            <hidden path="id" />
            <div id="form">
                  <table style="width:100%;">
                        <tbody>
                            <tr>
                                <td width="200">
                                    Standardname ${test}
                                </td>
                                <td width="450">
                                    <input path="standardname"/>
                                </td>
                                <td>
                                    <span style="float:right;display:block;font-weight:bold;">
                                        ID: <!-- TODO -->
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td width="200">
                                    andere Namen
                                </td>
                                <td width="450">
                                    <!-- TODO -->
                                </td>
                            </tr>
                            <tr>
                                <td width="200">
                                    Geschlecht
                                </td>
                                <td width="450">
                                    <select path="geschlecht">
                                        <options items="${geschlecht}" />
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="200">
                                    Person fiktiv
                                </td>
                                <td width="450">
                                    <select path="geschlecht">
                                        <options items="${geschlecht}" />
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                  </table>
                  <button>Submit</button>
            </div>
            
        </form:form>

    </body>
</html>