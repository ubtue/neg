<%@ page language="java" contentType="text/html; charset=utf-8"
 pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Nomen et Gens - 


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
            <form:hidden path="id" />
            <div id="form">
                  <table style="width:100%;">
                        <tbody>
                            <tr>
                                <td width="200">
                                    Standardname
                                </td>
                                <td width="450">
                                    <form:input path="standardname"/>
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
                                    Geschlecht ${geschlechtCount} ${test}
                                </td>
                                <td width="450">
                                    <form:select path="geschlecht">
                                        <form:options items="${geschlecht}" />
                                    </form:select>
                                </td>
                            </tr>
                        </tbody>
                  </table>
            </div>
            <form:button>Submit</form:button>
        </form:form>

    </body>
</html>