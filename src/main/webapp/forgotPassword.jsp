<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="de.uni_tuebingen.ub.nppm.util.Utils"%>
<%@page import="de.uni_tuebingen.ub.nppm.model.Benutzer"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.BenutzerDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="layout/layout.css" type="text/css">
        <title>Reset Password</title>
        <style>

            html, body {
                margin: 0;
                padding: 0;
            }

            h1{
                text-align: center;
            }

            *{
                box-sizing: border-box;
            }

            .forgotPassword_container{

                width: 100%;
                display: flex;
                justify-content: center;
            }
            .div-1 {
                background-color: #EBEBEB;
                padding: 10px 20px 10px 20px;
                /*margin: 0 auto;*/
            }

            .div-2 {
                display: flex;
                flex-direction: column;
            }

            input[type="email"] {
                width: 300px;
                font-size: 18px;
            }

            input[type="submit"]{
                font-size: 18px;
            }

            input[type="password"]{
                font-size: 18px;
            }

            button{
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <%
            String uuid_content = request.getParameter("varURLUUID");  //ResetToken
            String email_content = request.getParameter("varURLEmail"); //EMail
            String timeStamp_content = request.getParameter("varURLTime"); //ResetTokenValidUntil

            //If there was no ResetToken sended by getParameter, so show layout for putting your E-Mail Address inside and submit.
            if ((uuid_content == null || uuid_content.equals("")) || (email_content == null || email_content.equals(""))) {
        %>
        <div class="forgotPassword_container">
            <div class="div-1">
                <h1>Passwort vergessen ?</h1>
                <p>1. Geben Sie unten Ihre E-Mail Adresse ein.</p>
                <p>2. Unser System sendet Ihnen einen Link an Ihre E-Mail Adresse</p>
                <p>3. Klicken Sie den Link in Ihrer E-mail an, sie werden weiter geleitet um Ihr Passwort neu zu setzen</p>
                <br>
                <div class="div-1">
                    <form method="post" action="newPassword" id="register-form">
                        <input type="email" name="email" id="email" value="" placeholder="Ihre Registrierte E-Mail" />
                        <input type="submit" value="Neues Passwort" name="submit_new_password" />
                        <a href="login"><button type="button">zur&uuml;ck zum Login</button></a>
                    </form>

                </div>
            </div>
        </div>
        <% } else if ((uuid_content != null && !uuid_content.equals("")) && (email_content != null && !email_content.equals(""))) {
            //check if the email is registered
            boolean emailIsRegistered = BenutzerDB.hasEmail(email_content);
            if (!emailIsRegistered) {
        %>
        <h1>Fehler, E-mail Adresse ist nicht registriert versuchen sie einen Link mit einer anderen EMail Adresse zugenerieren</h1>
        <%
        } else {

            Benutzer benutzer = BenutzerDB.getByMail(email_content);
            //Get ResetToken from database
            String databaseUUID = benutzer.getResetToken();

            long timeBetween = 25;
            if (benutzer.getResetTokenValidUntil() != null) {
                LocalDateTime pastDateTime = benutzer.getResetTokenValidUntil();
                LocalDateTime nowDateTime = LocalDateTime.now();
                timeBetween = ChronoUnit.HOURS.between(pastDateTime, nowDateTime);
            }

            if (databaseUUID == null || !databaseUUID.equals(uuid_content) || timeBetween > 24) {

                String temp = "/forgotPassword";
        %>
        <h1>Link ist nicht mehr g&uuml;ltig, bitte einen neuen Link generieren.</h1>
        <h1><a href=" <%= Utils.getBaseUrl(request) + temp%> " >Neuen Link generieren</a></h1>
        <%
        } else { //show layout for Reset your Password by typing twice your new Password in Fields

        %>

        <div class="forgotPassword_container">
            <div class="div-1">
                <h1>Reset Passwort</h1>

                <br>
                <div class="div-1">
                    <form method="post" action="newPassword" id="register-form">
                        <div class="div-2">
                            <input type="password" name="newPassword" value="" minlength="6" placeholder="Neues Passwort" />
                            <input type="password" name="repeatPassword" value="" minlength="6" placeholder="Wiederhole neues Passwort" />
                            <input type="submit" value="Reset" />
                            <input type="hidden" name="url_uuid" value="<%= uuid_content%>">
                            <input type="hidden" name="url_email" value="<%= email_content%>">
                            <input type="hidden" name="url_timeStamp" value="<%= timeStamp_content%>">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
                    }
                }
            }
        %>
    </body>
</html>